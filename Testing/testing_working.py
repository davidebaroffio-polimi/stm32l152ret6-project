import subprocess
import time
import os
import signal
import psutil
import re
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

# works on lab workstation...
#cmd_stlink = "/opt/st/stm32cubeide_1.11.2/plugins/com.st.stm32cube.ide.mcu.externaltools.stlink-gdb-server.linux64_2.0.400.202209281104/tools/bin/ST-LINK_gdbserver -p 61234 -l 1 -d -s -cp /opt/st/stm32cubeide_1.11.2/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.0.500.202209151145/tools/bin -m 0 -k"

# works on my pc
cmd_stlink = "/opt/st/stm32cubeide_1.11.0/plugins/com.st.stm32cube.ide.mcu.externaltools.stlink-gdb-server.linux64_2.0.400.202209281104/tools/bin/ST-LINK_gdbserver -p 61234 -l 1 -d -s -cp /opt/st/stm32cubeide_1.11.0/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.0.500.202209151145/tools/bin -m 0 -k"

cmd_gdb = "gdb-multiarch"

done_func_name = b"done_ret_dup"
benchmark_func_name = b"benchmark_res_ret_dup"
eddi_name = b"DataCorruption_Handler"
cfcss_name = b"SigMismatch_Handler"
hard_name = b"HardFault_Handler"

original_pid = os.getpid()

def write(process, bytestring):
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
            print(ln)
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
    cfc_p = ['cfcss', 'rasm', 'inter-rasm']
    data_p = ['eddi', 'seddi', 'fdsc']
    scope = [x for x in range(1,7)]
    names = []
    for c in cfc_p:
        for d in data_p:
            for s in scope:
                names.append("out_" + d + "_" + c + "_" + str(s) + ".elf")

    faults = 0
    attempt = 0
    #for attempt in range(0, num_attempts):
    for name in names:
        subprocess.run("./stm32-dump-and-run.sh " + name)
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
                    exit(0)
            # Initialize gdb
            p_gdb = subprocess.Popen(["/bin/bash", "-c" ,cmd_gdb+' '+name], shell=False, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)

            #print("Running checks on "+name, file=sys.stderr)

            # Connect to gdb server         
            write(p_gdb, b'target remote localhost:61234\n')

            write(p_gdb, b"c\n")
            if read(p_gdb, '^.*Continuing.') != None:
                time.sleep(5)
                os.kill(p_gdb.pid, signal.SIGINT)
                # Add breakpoints
                write(p_gdb, b'b *' + done_func_name + b'\n')
                write(p_gdb, b'b *' + benchmark_func_name + b'\n')
                write(p_gdb, b'b *' + eddi_name + b'\n')
                write(p_gdb, b'b *' + cfcss_name + b'\n')
                write(p_gdb, b'b *' + hard_name + b'\n')
                write(p_gdb, b"c\n")
                ln = read(p_gdb, "^Breakpoint.*()\n$", 120)
                if ln == None: # in this case we have an incorrect execution with the program stuck somewhere
                    print (name + "\t[Stuck]")
                else:
                    ln_array = ln.decode("utf-8").split(" ")
                    if(ln_array[-2] == done_func_name.decode() or ln_array[-2] == benchmark_func_name.decode()):
                        print (name + "\t[OK]\t\t" + ln_array[-2])
                    else:
                        print (name + "\t[Fault?]\t" + ln_array[-2])

                p_gdb.kill()
                    
            else:
                p_gdb.kill()
            # wait for p_stlink to finish
            try:
                p_stlink.wait()
                while p_stlink.status() != psutil.STATUS_ZOMBIE:
                    pass
            except psutil.NoSuchProcess:
                pass

if __name__ == "__main__":
    signal.signal(signal.SIGCHLD, signal.SIG_IGN)
    main()
