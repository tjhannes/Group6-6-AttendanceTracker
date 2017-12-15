#!/usr/bin/env python
#-*- coding: UTF-8 -*-
import os
import signal
import subprocess
import pifacecad                                                                
import sys                                                                      
import urllib.request                                                           
import urllib.parse
import xml.etree.ElementTree as EL                                              
import time  

token = [0,0,0,0]
#hold = True
pw = False


def lesen():
    zbarcam=subprocess.Popen("zbarcam --raw --nodisplay /dev/video0", stdout=subprocess.PIPE, shell=True, preexec_fn=os.setsid)
    print("zbarcam erfolgreich gestartet...")
    while True:
        qrcodetext=zbarcam.stdout.readline()
        if qrcodetext!="":
            print("success")
            break
    os.killpg(zbarcam.pid, signal.SIGTERM)  # Prozess stoppen
    print("zbarcam erfolgreich gestoppt")
    return qrcodetext


def signal_handler(signal, frame):                                              
    if sys.version_info < (3,0):        
        # the python2 code forks
        os.kill(os.getppid(),9)                                                 
    os.kill(os.getpid(),9)                                    

#signal.signal(signal.SIGINT, signal_handler)


def update_pin_text(event):
    global pw
    global token
    if pw == True:
        event.chip.lcd.clear()
        event.chip.lcd.set_cursor(0, 0) 
        #if event.pin_num ==  0:
        #event.chip.lcd.write("Ready to scan!")   
        scan()
    else:
        event.chip.lcd.clear()
        event.chip.lcd.set_cursor(0, 0) 
        if event.pin_num ==  0:
            token[0] = token[0]+1
            if token[0]>9:
                token[0] = 0
            event.chip.lcd.write("Enter PIN")
            event.chip.lcd.set_cursor(0, 1) 
            event.chip.lcd.write(str(token))
        if event.pin_num ==  1:
            token[1] = token[1]+1
            if token[1]>9:
                token[1] = 0
            event.chip.lcd.write("Enter PIN")
            event.chip.lcd.set_cursor(0, 1) 
            event.chip.lcd.write(str(token))

        if event.pin_num ==  2:
            token[2] = token[2]+1
            if token[2]>9:
                token[2] = 0
            event.chip.lcd.write("Enter PIN")
            event.chip.lcd.set_cursor(0, 1) 
            event.chip.lcd.write(str(token))

        if event.pin_num ==  3:
            token[3] = token[3]+1
            if token[3]>9:
                token[3] = 0
            event.chip.lcd.write("Enter PIN")
            event.chip.lcd.set_cursor(0, 1) 
            event.chip.lcd.write(str(token))
        if event.pin_num ==  4:
            pw = True
            return str(token)





    
def scan():
    global token
    cad = pifacecad.PiFaceCAD()
    cad.lcd.backlight_on()
    cad.lcd.clear()
    cad.lcd.set_cursor(0,0)
    cad.lcd.write("Scanning....")
    result=lesen().strip()
    cad.lcd.clear()
    cad.lcd.set_cursor(0,0)
    cad.lcd.write("Waiting...")
    #print(result)
    data = urllib.parse.urlencode({'data' : result , 'token' : token})
    data = data.encode('ascii')
<<<<<<< HEAD
    url = "http://jovial-acronym-186111.appspot.com/attendance/student"
=======
    url = "http://attendancetracker-group66.appspot.com/attendance/take"
>>>>>>> e0ed9eb21d0cd325fe026e2f238b6eeab81af7d4
    with urllib.request.urlopen(url , data) as h:
        postMsg = h.read().decode('utf-8')
        #print(postMsg)
        cad.lcd.clear()
        cad.lcd.set_cursor(0,0)
        cad.lcd.write(postMsg)
        cad.lcd.set_cursor(0,1)
        cad.lcd.write("Press any Button")



def authenticate(cad):    
    #listener = pifacecad.SwitchEventListener(chip=cad)  
    #for i in range(8):
    #    listener.register(i, pifacecad.IODIR_FALLING_EDGE, update_auth) 
    #listener.activate() 
    cad.lcd.clear()    
    cad.lcd.set_cursor(0,0)
    cad.lcd.write("Enter PIN") 
    cad.lcd.set_cursor(0,1)
    cad.lcd.write(str(token)) 

def main():    
    signal.signal(signal.SIGINT, signal_handler)
    cad = pifacecad.PiFaceCAD()
    cad.lcd.backlight_on()
    cad.lcd.clear()    
    listener = pifacecad.SwitchEventListener(chip=cad)  
    for i in range(8):
        listener.register(i, pifacecad.IODIR_FALLING_EDGE, update_pin_text) 
    listener.activate() 
    token = authenticate(cad)
    while(pw == False):
        time.sleep(1)
    cad.lcd.clear() 
    cad.lcd.set_cursor(0,1)
    cad.lcd.write("Press any Button")


if __name__ == "__main__":
    main()
