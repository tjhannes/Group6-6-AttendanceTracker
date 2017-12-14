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


def lesen():
    zbarcam=subprocess.Popen("zbarcam --raw --nodisplay /dev/video2", stdout=subprocess.PIPE, shell=True, preexec_fn=os.setsid)
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
    event.chip.lcd.clear()
    event.chip.lcd.set_cursor(0, 0) 
    #if event.pin_num ==  0:
    #event.chip.lcd.write("Ready to scan!")   
    scan()

    
def scan():
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
    data = urllib.parse.urlencode({'d' : result})
    data = data.encode('ascii')
    url = "http://attendancetracker-group66.appspot.com/attendance/take"
    with urllib.request.urlopen(url , data) as h:
        postMsg = h.read().decode('utf-8')
        #print(postMsg)
        cad.lcd.clear()
        cad.lcd.set_cursor(0,0)
        cad.lcd.write(postMsg)
        cad.lcd.set_cursor(0,1)
        cad.lcd.write("Press any Button")

def main():    
    signal.signal(signal.SIGINT, signal_handler)
    cad = pifacecad.PiFaceCAD()
    cad.lcd.backlight_on()
    cad.lcd.clear()
    cad.lcd.set_cursor(0,1)
    listener = pifacecad.SwitchEventListener(chip=cad)  
    for i in range(8):
        listener.register(i, pifacecad.IODIR_FALLING_EDGE, update_pin_text) 
    listener.activate() 
    cad.lcd.write("Press any Button")


if __name__ == "__main__":
    main()
