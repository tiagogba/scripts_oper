#!/bin/bash 


##########################################################
##							##
##							##
##		Autor: Tiago Albuquerque		##
##		Script de verificacao da chegada	##
##		chargeback				##
##		Solicitante: Artur Diniz Samora		##
##		ver. 1.2				##
##							##
##							##		
##########################################################								


##Bloco Visa Config Quebec
ITEMV="ChgBackImporterVisa"
SERVICEV="ChgBackImporterVisa"
MONITORV="ChgBackImporterVisa"
MATCHV="false"
SENDXMLV=/export/scripts/send-xml.pl

##Bloco redecard Config Quebec
ITEMR="ChgBackImporterRedecard"
SERVICER="ChgBackImporterRedecard"
MONITORR="ChgBackImporterRedecard"
MATCHR="false"
SENDXMLR=/export/scripts/send-xml.pl


##DIR
DIR_VISA="/export/chargeback-importer/processados/visa/retorno"
DIR_RED="/export/chargeback-importer/processados/retorno"

##Binarios
FINDBIN=$(which find)
DATEBIN=$(which date)
HOSTNAME=`$(which hostname)`
WCBIN=$(which wc)

##EXEC
BIN_VISA=$($FINDBIN $DIR_VISA -amin -300 -type f | $WCBIN -l)
BIN_RED=$($FINDBIN $DIR_RED -amin -300 -type f | $WCBIN -l)

##HORA
DATA=$(date +%H%M)

##Funcao xml visa
function send_xml_visa {
$SENDXMLV -i $ITEMV -m $MONITORV -v "$VALUEV" -s $SERVICEV -u $STATUSV -a $MATCHV
}

##Funcao xml redecard
function send_xml_redecard {
$SENDXMLR -i $ITEMR -m $MONITORR -v "$VALUER" -s $SERVICER -u $STATUSR -a $MATCHR
}

function check_visa {
if [ $DATA -gt 1645 ] && [ $DATA -lt 2145 ]
then
	echo "esta no range"
	if [ $BIN_VISA -ne 0 ]
		then
			echo "recebemos arquivos"
			VALUEV="OK"
                     	STATUSV="0"
                     	send_xml_visa
		else
		     echo "Arq VISA n recebido, encaminhar incidente p/ billing"
                     VALUEV="Arq VISA n recebido, encaminhar incidente p/ billing"
                     STATUSV="2"
                     send_xml_visa
	fi 

else
	echo "checkfake"
        VALUEV="OK"
        STATUSV="0"
        send_xml_visa
fi
}


function check_redecard {
if [ $DATA -gt 1645 ] && [ $DATA -lt 2145 ]
then
        echo "esta no range"
        if [ $BIN_RED -ne 0 ]
                then
                        echo "recebemos arquivos"
                        VALUEV="OK"
                        STATUSV="0"
                        send_xml_visa
                else
                     echo "Arq VISA n recebido, encaminhar incidente p/ billing"
                     VALUEV="Arq VISA n recebido, encaminhar incidente p/ billing"
                     STATUSV="2"
                     send_xml_visa
        fi 

else
        echo "checkfake"
        VALUEV="OK"
        STATUSV="0"
        send_xml_visa
fi
}


##Invoke da funcao check
check_visa


