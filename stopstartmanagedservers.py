#!/usr/bin/env python

'''
      DASA - Diagnostico das americas
      Script - Para e reinicia os servidor WebLogic
      na QueueEntrada
      Autor: Tiago Albuquerque
      Data: 17/02/2016
'''

import sys,os,urllib2
from urllib2 import URLError
import time as systime

list = sys.argv[1:]
listaSrv = []

connect('usuario','senha','IP')
domainRuntime()

def executa():
        for arg in list:
                try:
                        server = '/ServerLifeCycleRuntimes/' + arg
                        cd(server)
                        state = cmo.getState()
                        if state == 'RUNNING':
                                print '******************************************************************************************************************* '
                                print '******************************************************************************************************************* '
                                print 'Status do servidor....' + arg + ' = ' + state
                                print 'Servidor sendo reinciado....'
                                print '******************************************************************************************************************* '
                                shutdown(arg,force='true')
                                print '******************************************************************************************************************* '
                                print 'aguardando...'
                                systime.sleep(20)
                                print '******************************************************************************************************************* '
                                print 'Servidor em shutdown' + '  ' + arg + ' = ' + state
                                print '******************************************************************************************************************* '
                                print 'Servidor reiniciando....'
                                print '******************************************************************************************************************* '
                                start(arg)
                                print 'Status do servidor....' + arg + ' = ' + state
                                print 'aguardando para testar....'
                                systime.sleep(10)
                        else:
                                print 'aguardando...'
                                systime.sleep(20)
                                print '******************************************************************************************************************* '
                                print arg
                                start(arg)
                except:
                        print '******************************************************************************************************************* '
                        print 'Reiniciando novamente....'
                        systime.sleep(20)
                        print '******************************************************************************************************************* '
                        print state
                        print '******************************************************************************************************************* '
                        start(arg)
                        print '******************************************************************************************************************* '
                        print 'Status do servidor....' + arg + ' = ' + state
                        pass
                        if state != 'RUNNING':
                                cleanStage()
                                start(arg)
executa()
