#!/usr/bin/env python

#################################################################
##      DASA - Diagnostico das americas                        ##
##      Script - Checa status 200 nos servidores do pclin      ##
##      Autor: Tiago Albuquerque                               ##
##      Data: 10/05/2014                                       ##
#################################################################

import sys

list = sys.argv[1:]

connect('usuario','senha','IP')
domainRuntime()
listaSrv = []

def executa():
    for arg in list:
        try:
            server='ServerRuntimes/' + arg + '/JMSRuntime/' + arg +'.jms/JMSServers/' + arg.upper() + '/Destinations/' + 'MotionModule!' + arg.upper() + '@QueueEntrada'
            cd(server)
            consumer = cmo.getConsumersTotalCount()
            consu = int(consumer)
            if consu != 2:
               listaSrv.append(arg + '=' + `consu`)
        except:
            listaSrv.append(arg + '=' + 'null')
            pass
    testaSrv = len(listaSrv)
    if testaSrv != 0:
        listaSrv.insert(0,'CRITICAL')
        imprimeLista = '; '.join(listaSrv)
        print imprimeLista
    else:
        listaSrv.insert(0,'OK')
        imprimeLista = ' '.join(listaSrv)
        print imprimeLista

executa()
