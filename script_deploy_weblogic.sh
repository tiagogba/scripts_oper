#!/bin/bash

#################################

clear # Clear the screen

echo "##### Deployment Homologacao ####"
echo "#################################"
echo "[1]deploy"
echo "[2]undeploy"
echo "[3]sair"

read aplicacao

case "$aplicacao" in

        "1" )
                echo -n "Nome do deploy:"
                read deploy
                echo -n "Nome do pacote:"
                read pacote
                echo -n "diretorio:"
                read diretorio

                cd /opt/works/deploy/$diretorio
                source /opt/oracle/wlserver_12.1/server/bin/setWLSEnv.sh
                java weblogic.Deployer -adminurl t3://10.21.201.225:7000 -username system -password Inova2012 -name $deploy -deploy $pacote -targets ClusterInova
        ;;

        "2" )
                echo -n "Nome do deploy:"
                read deploy
                source /opt/oracle/wlserver_12.1/server/bin/setWLSEnv.sh
                java weblogic.Deployer -adminurl t3://10.21.201.225:7000 -username system -password Inova2012 -name $deploy -undeploy
        ;;

        *) exit

esac
