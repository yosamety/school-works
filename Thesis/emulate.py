#!/usr/bin/python
import time
from datetime import datetime
import threading
import os
import subprocess
import math
import sys

def control(i_ready, c_ready):
    wait_time = int(1)
    int_name = str('h1-eth0')
    with open("/home/sam/Documents/Thesis/network/bigtest.txt", "r") as in_file:      
        c_ready.set()
        i_ready.wait()
        for line in in_file:
            st = time.time()
            x = "1"
            try:
                bw = int(math.ceil(float(line)))
                if bw == 0:
                    bw = 1
                    x = str(bw)+"Kbit"
                else:
                    x = str(bw)+"Mbit"
            except ValueError:
                return 
            print x
            subprocess.call(['sudo','tc','qdisc','replace','dev',int_name,'root','tbf','rate',x,'latency','1000ms','burst','10K'])
            print "next"
            time.sleep(wait_time-(time.time()-st))

def perf(i_ready, c_ready):
    print "start perf"
    os.system("echo 'time' > /home/sam/Documents/Thesis/network/per.txt")
    i_ready.set()
    c_ready.wait()        
    with open('/home/sam/Documents/Thesis/network/per.txt', 'a') as f:
        f.write('began at %s\n' %datetime.now().time())
    os.system("iperf3 -c 10.0.0.2 -i 1 -t 600>> /home/sam/Documents/Thesis/network/per.txt")
    with open('/home/sam/Documents/Thesis/network/per.txt', 'a') as f:
        f.write('finished at %s\n' %datetime.now().time())

def main():
    print(datetime.now().time())
    c_ready = threading.Event()
    i_ready = threading.Event()  
    print "starting"
    ithread = threading.Thread(target=perf,
         args = (i_ready, c_ready))
    ithread.start()
    cthread = threading.Thread(target=control,
         args = (i_ready, c_ready))
    cthread.start()

main()

