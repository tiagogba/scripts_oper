#!/bin/sh

# Valor esperado (4 nos no cluster)
TTCL="4"

# Lista de servidores
SRVS="10.128.16.202 \
      10.128.16.204 \
      10.128.16.200 \
      10.128.16.203 "

# funcao principal que executa o twiddle, busca os nos do Cluster
fn_exec_twid()
  {
   # Valor de nos no cluster
   URL="http://srvhost:8080/jmx-console/HtmlAdaptor?action=inspectMBean&name=jboss%3Aservice%3DClusterAM"

   TTND=$(curl -s $URL | grep 10.128 |head -n1 | cut -d "[" -f2 | sed 's/://g;s/,//g;s/1099//g;s/\[//g;s/ /\n/g;s/\]//g'| wc -l)
   # lista de nos no cluster
   NOS=$(curl -s $URL | grep 10.128 |head -n1 | cut -d "[" -f2 | sed 's/://g;s/,//g;s/1099//g;s/\[//g;s/ /\n/g;s/\]//g')

   # validacao de quem esta no cluster
   if [ $TTND -lt $TTCL ]
      then
          STATUS="2"

          for srvs in `echo $SRVS`
             do
               echo $NOS | grep $srvs
               if [ `echo $?` != 0 ]
                  then
                      # Caso nao encontre o servidor, vai mostrar quem esta fora
                      case $srvs in

                           10.128.16.202) NOME="a1-irmao3"
                           ;;

                           10.128.16.204) NOME="a1-irmao5"
                           ;;

                           10.128.16.200) NOME="a1-irmao1"
                           ;;

                           10.128.16.203) NOME="a1-irmao4"

                      esac
               fi
             done


      else
          STATUS="0"
          NOME="OK"
   fi
  }

# funcao que executa o envio para o quebec-api
fn_send_xml()
  {
   # Executando a funcao principal
   fn_exec_twid

   # Variaveis para envio Quebec-api
   service="jboss_cluster_am"
   item="cluster"
   monitor="jboss_cluster_am"
   value="$NOME"
   timestamp=`date +%s`
   match="false"
   status="$STATUS"

   /export/scripts/send-xml.pl -i $item -m $monitor -v "$value" -s $service -u $status -a $match
  }

fn_send_xml
