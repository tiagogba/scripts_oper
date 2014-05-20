#!/usr/bin/env python
# -*- coding: UTF-8 -*-

__author__ = "Tiago Albuquerque, Marcelo Varge"
__copyright__ = "Copyright 2014, The Cogent Project"
__credits__ = ["Tiago Albuquerque","Matthew Wakefield"]
__license__ = "GPL"
__version__ = "1.0.1"
__maintainer__ = "Tiago Albuquerque"
__email__ = "tiago.albuquerque.ext@dasa.com.br"
__status__ = "Production"
__homolog__ = "Python 2.6.6"

#Import modules
import os
import sys
import urllib2
from urllib2 import URLError

#Array servers list
list = ['server:8080','server:9090','server:9191']

#Start array list null
listaSrv = []


#Function TestUrl and http code response
def TestUrl():
    for arg in list:
            try:
               rep = urllib2.urlopen('http://' + arg ).getcode()
            except urllib2.HTTPError, err:
               if err.code == 404:
                   listaSrv.append(arg + '=' + "Page not found!")
               elif err.code == 403:
                   listaSrv.append(arg + '=' + "Access denied!")
               elif err.code == 503:
                   listaSrv.append(arg + '=' + str(err.code))
            except urllib2.URLError, err:
               listaSrv.append(arg + '=' + str(err.reason))
            except httplib.HTTPException, err:
               listaSrv.append(arg + '=' + str(err.reason))

#Function TestArray and send string for nagios
def TestArray():
    if listaSrv:
        listaSrv.insert(0,'CRITICAL: ')
        srvTesta = ';'.join(listaSrv)
        os.system('echo "' + srvTesta + '"')
        os._exit(2)
    else:
        listaSrv.insert(0,'OK')
        srvTesta = ' ;'.join(listaSrv)
        os.system('echo ' + srvTesta)
        os._exit(0)

TestUrl()
TestArray()
