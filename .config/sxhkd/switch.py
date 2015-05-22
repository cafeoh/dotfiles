#!/usr/bin/python

import os
import time

small=10
big=150
steps=3

#print os.popen('bspc config -m VGA1 window_gap').read()
cur = int(os.popen('bspc config -d ^1 window_gap').read().strip())
new = big

if(cur==big): new=small

for i in range(steps):
    val = cur+(new-cur)/(steps/(i+1.))
    for m in os.popen('bspc query -M'):
        os.popen('bspc config -m %s window_gap %d'%(m.strip(),val)).read()
        #time.sleep(0.05)
