#!/usr/bin/env python

import commands

output = commands.getoutput("free -g | grep Swap: | awk '{print $3}'")
if (output >= 2):
The system is going down for halt NOW!o'
        stopstart = commands.getoutput('killall -9 java; /etc/init.d/tomcat start')
else:
        exit
