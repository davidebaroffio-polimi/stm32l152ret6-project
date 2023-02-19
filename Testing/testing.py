import subprocess
import random
import time
import os
import signal
import psutil
import re
import csv
import sys
from elftools.elf.elffile import ELFFile

class SignalHandler(object):
    def __init__(self, process):
        self.expired = False
        self.process = process
    def handle(self, signum, frm):
        print("received signal", signum)
        self.process.kill()
        self.expired = True

cmd_stlink = "/opt/st/stm32cubeide_1.11.2/plugins/com.st.stm32cube.ide.mcu.externaltools.stlink-gdb-server.linux64_2.0.400.202209281104/tools/bin/ST-LINK_gdbserver -p 61234 -l 1 -d -s -cp /opt/st/stm32cubeide_1.11.2/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.0.500.202209151145/tools/bin -m 0 -k"

cmd_gdb = "gdb-multiarch"

seed = 12345
data = []
scope = None
fieldnames = ['attempt', 'stop_addr', 'stop_fn', 'delay', 'target', 'bitflip', 'code', 'seed']
begin = None
writable_size = 0

original_pid = os.getpid()

def handler(signum, frame):
    save_data()

def read_writable_address_size(elffile):
    writable_size = 0
    for section in ELFFile(elffile).iter_sections():
        if section.name in ['.data', '.bss', '._user_heap_stack']:
            writable_size = writable_size + section.header['sh_size']
    return writable_size

def save_data():
    if os.getpid() == original_pid:
        end = time.time()
        print("Test lasted for {:.3f} seconds".format(end-begin))

        already_exists = os.path.exists('faults_'+scope+'.csv')
        
        with open('faults_'+scope+'.csv', 'a', newline='') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            if already_exists == False:
                writer.writeheader()
            writer.writerows(data)
    exit(0)

def write(process, bytestring):
    #print("Executing: ", bytestring)
    process.stdin.write(bytestring)
    process.stdin.flush()

def read(process, pattern, timeout = 2.0, debug=False):
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
        if debug == True:
            debug_data = []
        while expired == False:
            ln = process.stdout.readline()
            if debug == True:
                debug_data.append(ln)
            # if a pattern is found we kill the timer process and return ln
            if re.match(pattern, ln.decode('utf-8')) != None:
                os.kill(pid, signal.SIGKILL)
                if debug == True:
                    return ln, debug_data
                return ln
            expired = s.expired
        # if no pattern is found within the time limit we kill the timer and return None
        os.kill(pid, signal.SIGKILL)
        if debug == True:
            return None, debug_data
        return None

def main():
    faults = 0
    attempt = 0
    for attempt in range(0, 15000):
    #while True:
        pid = os.fork()
        if pid == 0:
            # Initialize stlink
            subprocess.run(cmd_stlink, shell=True, stdout=subprocess.DEVNULL, stdin=subprocess.DEVNULL)
            return
        else:
            p_stlink = psutil.Process(pid)
            i = 0
            while(p_stlink.status() != psutil.STATUS_SLEEPING):
                time.sleep(.01)
                i+=1
                if i > 1000: # if after 10 seconds im still stuck there is a problem
                    print("ST-Link doesn't start...")
                    save_data()
            # Initialize gdb
            p_gdb = subprocess.Popen(["/bin/bash", "-c" ,cmd_gdb+' '+sys.argv[2]], shell=False, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)

            # Connect to gdb server         
            write(p_gdb, b'target remote localhost:61234\n')

            #write(p_gdb, b"b memset\n")
            write(p_gdb, b"c\n")
            # Make sure that we are continuing before running the interrupt
            if read(p_gdb, '^.*Continuing.') != None:
                print("Connected... ", end="")
                
                # Add some delay (<500ms)
                delay = (random.randint(attempt, attempt+50) / 5000) % 3000
                time.sleep(delay)

                # Interrupt the execution for the fault injection  
                addr = None
                fn = None
                os.kill(p_gdb.pid, signal.SIGINT)
                print("Interrupted... ", end = "")
                ln, debug_data = read(p_gdb, "^[0-9a-zA-Z_ ]+\(.*\)\\n$", debug=True)
                if ln == None:
                    print("Error detected")
                    print(debug_data)
                    #save_data()
                else:
                    ln_array = ln.decode("utf-8").split(" ")
                    addr = ln_array[0]
                    fn = ln_array[2]
                    print(ln.decode("utf-8")[:-1], end=" ")

                    # Select what to alter  
                    what_to_alter = None
                    if scope == "registers": # alter a register
                        register = random.randint(0, 15)
                        what_to_alter = b'$r' + str.encode(str(register))
                    else: # alter some memory area (80KB of memory, but writable_size is allocated)
                        byte = random.randint(0, writable_size) # select the byte
                        what_to_alter = b'*' + str.encode(hex(byte + 0x20000000))

                    # Select the bit to flip 
                    bitflip = 2**(random.randint(0,7))
                    write(p_gdb, b'set $bitflip = ' + str.encode(str(bitflip)) + b'\n')

                    # Set a breakpoint to Error_Handler => the fault has been detected
                    write(p_gdb, b'b *DataCorruption_Handler\n')
                    # Set a breakpoint to Error_Handler => the fault has been detected
                    write(p_gdb, b'b *SigMismatch_Handler\n')
                    # Set a breakpoint to HardFault_Handler => the fault has not been detected and it broke the program
                    write(p_gdb, b'b *HardFault_Handler\n')
                    # Set a breakpoint to Incorrect_Result => the fault has not been detected and a wrong output was submitted
                    write(p_gdb, b'b *Incorrect_Result\n')
                    # Set a breakpoint to a check location => the fault didn't alter the execution
                    write(p_gdb, b'b *done\n')

                    print(what_to_alter, "=", what_to_alter, "^", bitflip, "after", delay, "seconds")

                    ### TODO change the `+` into `^`
                    if what_to_alter in [b'$r13', b'$r14', b'$r15']:
                        write(p_gdb, b'print (int)' + what_to_alter + b'\n')
                        ln = read(p_gdb, "^.*\$.* = .*\n$")
                        ln_array = ln.decode("utf-8").split(" ")
                        new_value = int(ln_array[-1][:-1]) ^ bitflip
                        write(p_gdb, b'set ' + what_to_alter + b' = ' + str.encode(str(new_value)) + b'\n')
                    else:
                        write(p_gdb, b'set '+ what_to_alter+ b' = ' + what_to_alter + b' ^ $bitflip\n')
                    
                    write(p_gdb, b'c\n')

                    ln = read(p_gdb, "^Breakpoint.*()\n$", 5)
                    if ln == None: # in this case we have an incorrect execution with the program stuck somewhere
                        code = -3
                    else:
                        ln_array = ln.decode("utf-8").split(" ")
                        if(ln_array[-2] == "DataCorruption_Handler"):
                            code = 1
                        elif(ln_array[-2] == "SigMismatch_Handler"):
                            code = 2
                        elif(ln_array[-2] == "HardFault_Handler"):
                            code = -1
                        elif(ln_array[-2] == "Incorrect_Result"):
                            code = -2
                        elif(ln_array[-2] == "done"):
                            write(p_gdb, b'c\n')
                            ln = read(p_gdb, "^Breakpoint.*()\n$", 5)
                            if ln == None: # in this case we have an incorrect execution with the program stuck somewhere
                                code = -3
                            else:
                                ln_array = ln.decode("utf-8").split(" ")
                                if(ln_array[-2] == "DataCorruption_Handler"):
                                    code = 1
                                elif(ln_array[-2] == "SigMismatch_Handler"):
                                    code = 2
                                elif(ln_array[-2] == "HardFault_Handler"):
                                    code = -1
                                elif(ln_array[-2] == "Incorrect_Result"):
                                    code = -2
                                elif(ln_array[-2] == "done"):
                                    code = 0

                    # Collect results
                    print("#"+str(attempt), "\tEnded with code:", code)
                    if code != 0:
                        faults+=1

                    p_gdb.kill()

                    data.append({'attempt': attempt,
                                'stop_addr': addr ,
                                'stop_fn': fn, 
                                'delay': delay, 
                                'target': what_to_alter.decode("utf-8")[1:], 
                                'bitflip': bitflip, 
                                'code': code,
                                'seed': seed })
            else:
                p_gdb.kill()
            attempt += 1
            # wait for p_stlink to finish
            try:
                p_stlink.wait()
                while p_stlink.status() != psutil.STATUS_ZOMBIE:
                    pass
            except psutil.NoSuchProcess:
                pass
    save_data()

if __name__ == "__main__":
    try:
        scope = sys.argv[1]
        elffilename = sys.argv[2]
    except:
        print("Usage: python3 testing.py [registers|memory] <elf_filename>")
        exit(0)

    try:
        if not scope in ["registers", "memory"]:
            raise      
    except:
        print("ERROR - please select a valid scope:", ["registers", "memory"])
        print("Usage: python3 testing.py [registers|memory] <elf_filename>")
        exit(0)

    try:
        with open(elffilename, 'rb') as elffile:
            writable_size = read_writable_address_size(elffile)
            print(writable_size)
    except:
        print("ERROR - Unable to read file", elffilename)
        print("Usage: python3 testing.py [registers|memory] <elf_filename>")
        exit(0)
        
    signal.signal(signal.SIGCHLD, signal.SIG_IGN)
    signal.signal(signal.SIGINT, handler)
    begin = time.time()
    random.seed(seed)
    main()
