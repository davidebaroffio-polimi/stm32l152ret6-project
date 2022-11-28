import subprocess
import random
import time
import os
import signal
import psutil
import re
import csv

class SignalHandler(object):
    def __init__(self, process):
        self.expired = False
        self.process = process
    def handle(self, signum, frm):
        print("received signal", signum)
        self.process.kill()
        self.expired = True

cmd_stlink = "/opt/st/stm32cubeide_1.10.1/plugins/com.st.stm32cube.ide.mcu.externaltools.stlink-gdb-server.linux64_2.0.300.202203231527/tools/bin/ST-LINK_gdbserver -p 61234 -l 1 -d -s -cp /opt/st/stm32cubeide_1.10.1/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.0.301.202207041506/tools/bin -m 0 -k"

cmd_gdb = "~/Downloads/LLVMEmbeddedToolchainForArm-15.0.2-Linux-x86_64/bin/gdb ~/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project/out.elf"

data = []
fieldnames = ['attempt', 'stop_addr', 'stop_fn', 'delay', 'target', 'bitflip', 'code']
begin = time.time()

def handler(signum, frame):
    save_data()

def save_data():
    end = time.time()
    print("Test lasted for {:.3f} seconds".format(end-begin))
    
    with open('faults.csv', 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(data)
    exit(0)

def write(process, bytestring):
    #print("Executing: ", bytestring)
    process.stdin.write(bytestring)
    process.stdin.flush()

def read(process, pattern, timeout = 2.0):
    pid = os.fork()
    if pid == 0: # timer of the process, if we take longer than timeout we send a SIGALRM to the parent
        time.sleep(timeout)
        os.kill(os.getppid(), signal.SIGALRM)
        while True:
            pass
    else: # process finding the pattern
        # define the signal handler if the alarm rings
        s = SignalHandler(process=process)
        signal.signal(signal.SIGALRM, s.handle)
        expired = False
        # iterate over the stdout lines in order to find the pattern
        while expired == False:
            ln = process.stdout.readline()
            # if a pattern is found we kill the timer process and return ln
            if re.match(pattern, ln.decode('utf-8')) != None:
                os.kill(pid, signal.SIGKILL)
                return ln
            expired = s.expired
        # if no pattern is found within the time limit we kill the timer and return None
        os.kill(pid, signal.SIGKILL)
        return None

def main():
    #attempt = 0
    for attempt in range(0, 1000):

        pid = os.fork()
        if pid == 0:
            # Initialize stlink
            subprocess.run(cmd_stlink, shell=True, stdout=subprocess.DEVNULL, stdin=subprocess.DEVNULL)
            return
        else:
            p_stlink = psutil.Process(pid)
            while(p_stlink.status() != psutil.STATUS_SLEEPING):
                pass
            # Initialize gdb
            p_gdb = subprocess.Popen(["/bin/bash", "-c" ,cmd_gdb], shell=False, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
            # Connect to gdb server         
            write(p_gdb, b'target remote localhost:61234\n')

            write(p_gdb, b'c\n')
            # Make sure that we are continuing before running the interrupt
            if read(p_gdb, '^.*Continuing.') != None:
                print("Connected... ", end="")
                
                # Add some delay (<500ms)
                delay = random.randint(attempt, attempt+50) / 1000
                time.sleep(delay)

                # Interrupt the execution for the fault injection  
                addr = None
                fn = None
                os.kill(p_gdb.pid, signal.SIGINT)
                print("Interrupted... ", end = "")
                ln = read(p_gdb, "^0x.*()\n$")
                if ln == None:
                    print("Error detected")
                    save_data()
                ln_array = ln.decode("utf-8").split(" ")
                addr = ln_array[0]
                fn = ln_array[-2]
                print(ln.decode("utf-8")[:-1], end=" ")
                
                # Select what to alter  
                what_to_alter = None
                target = random.randint(0, 100)
                if target < 30: # 30% chance of altering the stack
                    # get the stack pointer 
                    write(p_gdb, b'p $sp\n')
                    ln = read(p_gdb, "^.*\$.*0x.*\n$")
                    ln_array = ln.decode("utf-8").split(" ")
                    # find the element 0x<address> in the line
                    for elem in ln_array:
                        if elem.startswith('0x'):
                            pt = elem
                    pt_num = int(pt, base=0)
                    offset = random.randint(-target, target) # select the byte
                    what_to_alter = b'*' + str.encode(hex(offset+pt_num))
                if target < 50: # 50% chance of altering a register
                    register = random.randint(0, 15)
                    what_to_alter = b'$r' + str.encode(str(register))
                else: # 50% chance of altering some memory area (80KB of memory, but only 9544B allocated)
                    byte = random.randint(0, 9544) # select the byte
                    what_to_alter = b'*' + str.encode(hex(byte + 0x20000000))

                # Select the bit to flip 
                bitflip = 2**(random.randint(0,7))
                write(p_gdb, b'set $bitflip = ' + str.encode(str(bitflip)) + b'\n')

                # Set a breakpoint to Error_Handler => the fault has been detected
                write(p_gdb, b'b *Error_Handler\n')
                # Set a breakpoint to HardFault_Handler => the fault has not been detected and it broke the program
                write(p_gdb, b'b *HardFault_Handler\n')
                # Set a breakpoint to Incorrect_Result => the fault has not been detected and a wrong output was submitted
                write(p_gdb, b'b *Incorrect_Result\n')
                # Set a breakpoint to a check location => the fault didn't alter the execution
                write(p_gdb, b'b *done\n')

                print(what_to_alter, "=", what_to_alter, "+", bitflip, "after", delay, "seconds")

                ### TODO change the `+` into `^`
                write(p_gdb, b'set '+ what_to_alter+ b' = ' + what_to_alter + b' + $bitflip\n')
                write(p_gdb, b'c\n')

                reached_done = False
                ln = read(p_gdb, "^Breakpoint.*()\n$", 5)
                if ln == None: # in this case we have an incorrect execution with the program stuck somewhere
                    code = -3
                else:
                    ln_array = ln.decode("utf-8").split(" ")
                    if(ln_array[-2] == "Error_Handler"):
                        code = 1
                    elif(ln_array[-2] == "HardFault_Handler"):
                        code = -1
                    elif(ln_array[-2] == "Incorrect_Result"):
                        code = -2
                    elif(ln_array[-2] == "done"):
                        write(p_gdb, b'c\n')
                        ln = read(p_gdb, "^Breakpoint.*()\n$", 5)
                        if ln == None: # in this case we have an incorrect execution with the program stuck somewhere
                            code = -2
                        else:
                            ln_array = ln.decode("utf-8").split(" ")
                            if(ln_array[-2] == "Error_Handler"):
                                code = 1
                            elif(ln_array[-2] == "HardFault_Handler"):
                                code = -1
                            elif(ln_array[-2] == "Incorrect_Result"):
                                code = -2
                            elif(ln_array[-2] == "done"):
                                code = 0
                '''for ln in p_gdb.stdout:
                    if re.match("^Breakpoint.*()\n$", ln.decode("utf-8")) != None:
                        ln_array = ln.decode("utf-8").split(" ")
                        if(ln_array[-2] == "Error_Handler"):
                            code = 1
                        elif(ln_array[-2] == "HardFault_Handler"):
                            code = -1
                        elif(ln_array[-2] == "Incorrect_Result"):
                            code = -2
                        elif(ln_array[-2] == "done"):
                            write(p_gdb, b'c\n')
                            reached_done = True
                        break
                if reached_done:
                    for ln in p_gdb.stdout:
                        if re.match("^Breakpoint.*()\n$", ln.decode("utf-8")) != None:
                                    ln_array = ln.decode("utf-8").split(" ")
                                    if(ln_array[-2] == "Error_Handler"):
                                        code = 1
                                    elif(ln_array[-2] == "HardFault_Handler"):
                                        code = -1
                                    elif(ln_array[-2] == "Incorrect_Result"):
                                        code = -2
                                    elif(ln_array[-2] == "done"):
                                        code = 0
                                    break'''

                # Collect results
                print("#"+str(attempt), "\tEnded with code:", code)

                p_gdb.kill()

                data.append({'attempt': attempt,
                            'stop_addr': addr ,
                            'stop_fn': fn, 
                            'delay': delay, 
                            'target': what_to_alter.decode("utf-8")[1:], 
                            'bitflip': bitflip, 
                            'code': code})
            else:
                p_gdb.kill()

            # wait for p_stlink to finish
            try:
                p_stlink.wait()
                while p_stlink.status() != psutil.STATUS_ZOMBIE:
                    pass
            except psutil.NoSuchProcess:
                pass
    save_data()

if __name__ == "__main__":
    signal.signal(signal.SIGCHLD, signal.SIG_IGN)
    signal.signal(signal.SIGINT, handler)
    main()
