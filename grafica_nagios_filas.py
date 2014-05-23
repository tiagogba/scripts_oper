#!/usr/bin/env python
#--*--encode=utf-8--*--
list = sys.argv[1:]
listMsg = []

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
