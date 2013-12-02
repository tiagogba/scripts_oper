##########################################################
##                                                      ##
##              Script chek LostMulticast               ##
##              Date: 29/11/2013                        ##
##              Ver. 1.0                                ##
##              @Autor: Tiago Albuquerque               ##
##                                                      ##
##########################################################

import os

####Funcao para emissao de email utilizando mailx by UNIX
def sendMail(result):
   Message = result;
   cmd = "echo " + Message + " > rw_file"
   os.system(cmd)
   os.system('/bin/mailx -s  "ALERT: Lost Multicast  Exceeded Limit !!! " tiago.albuquerque.ext@dasa.com.br,willians.cavalcante@dasa.com.br < rw_file')


####Cria conexao com WLST altera para o modulo domainRuntime + ServerRuntimes
connect('user','password','t3://IP:PORT');
servers =  domainRuntimeService.getServerRuntimes();

####Verifica se existe servidores ativos
if (len(servers) > 0):
    for server in servers:
        srv = server.getName();
        if srv != 'masterserver':
            clus =  server.getClusterRuntime();
            lost = clus.getMulticastMessagesLostCount();
            if (lost > 5000 ):
                #print 'LostMulticast: ' + server.getName(), +lost;
                result = 'Servidor: '+ srv + '  LostMulticast: ' + str(lost);
                #print result
                sendMail(result);

