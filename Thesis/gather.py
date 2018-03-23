#!/usr/bin/python
import time
from datetime import datetime
import threading
import os
class perpetualTimer():
   def __init__(self,t,hFunction):
      self.t=t
      self.hFunction = hFunction
      self.thread = threading.Timer(self.t,self.handle_function)
   def handle_function(self):
      self.hFunction()
      self.thread = threading.Timer(self.t,self.handle_function)
      self.thread.start()
   def start(self):
      self.thread.start()
   def cancel(self):
      self.thread.cancel()
def perf(i_ready, n_ready, p_ready):
    print "start perf"
    os.system("echo 'time' > /home/sam/Documents/per.txt")
    i_ready.set()
    n_ready.wait()
    p_ready.wait()       
    with open('/home/sam/Documents/per.txt', 'a') as f:
        f.write('began at %s\n' %datetime.now().time())
    os.system("iperf3 -c 10.82.31.86 -i 1 -t 600 -p 5202 -l 4K >> /home/sam/Documents/per.txt")
    with open('/home/sam/Documents/per.txt', 'a') as f:
        f.write('finished at %s\n' %datetime.now().time())
def nets(i_ready, n_ready, p_ready):
    print "start nmcli"
    os.system('echo "TIME, SSID, BSSID, SIGNAL, ACTIVE" > /home/sam/Documents/nd.txt')
    n_ready.set()
    i_ready.wait()
    p_ready.wait() 
    #timer - loop as many seconds needed
    global count
    starttime=time.time()
    while (count<600):
        count+=1
        nmlook()
        time.sleep(1.0-((time.time()-starttime)%1.0))
def nmlook():
    with open('/home/sam/Documents/nd.txt', 'a') as f:
        f.write('%s  ' %datetime.now().time())
    os.system("iw dev wlo1 link | awk '{printf \"%s \",$0} END {print \"\"}' >> /home/sam/Documents/nd.txt")
    with open('/home/sam/Documents/nd.txt', 'a') as f:
        f.write('\n')
def pingD(i_ready, n_ready, p_ready):
    os.system('echo "TIME # BYTES FROM IP SEQ# TTL DELAY MS" > /home/sam/Documents/pings.txt')
    p_ready.set()
    n_ready.wait()
    i_ready.wait()
    os.system("ping 10.82.31.86 -c 600 -D >> /home/sam/Documents/pings.txt")
def main():
    print(datetime.now().time())
    i_ready = threading.Event()
    p_ready = threading.Event()
    n_ready = threading.Event()
     print "starting"
    ithread = threading.Thread(target=perf,
         args = (i_ready, n_ready, p_ready))
    ithread.start()
    pthread = threading.Thread(target=pingD,
         args = (i_ready, n_ready, p_ready))
    pthread.start()
    nets(i_ready, n_ready, p_ready)
count = 0 
main()
 
