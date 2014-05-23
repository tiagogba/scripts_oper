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






connect('system','MotionD@','t3://10.122.18.11:7000')
domainRuntime()

for arg in list:
        try:
                entrada='ServerRuntimes/' + arg + '/JMSRuntime/' + arg +'.jms/JMSServers/' + arg.upper() + '/Destinations/' + 'MotionModule!' + arg.upper() + '@QueueEntrada'
                cd(entrada)
                Qtd = int(cmo.getMessagesCurrentCount())
                listMsg.append(arg + '=' + `Qtd`)
        except:
                listMsg.append(arg + '=' + 'Null')

imprimeLista = '; '.join(listMsg)
print 'OK |' + imprimeLista
