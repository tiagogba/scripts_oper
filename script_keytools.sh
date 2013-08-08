#!/bin/bash

# monitora a validade do PFX do HSBC
# Quando for vencer, eh necessario gerar outro PFX com o certificado do psgw

# *** ATENCAO *** ATENCAO *** ATENCAO ***
# A variavel DOMINIO sera alterado na proxima criacao do pfx
# Precisa ajustar o script

# variaveis

KEYTOOL=/usr/java/jre/bin/keytool
KEYSTORE=/opt/UOLI/webapps/bpag-core/WEB-INF/Key_Repos/hsbc.pfx
DOMINIO=psgw.uol.com.br
THRESHOLD=20

# Variaveis para envio Quebec-api
HOST=`hostname -s`
SERVICE="valida-pfx_bcor"
ITEM="pfx"
MONITOR="pfx_bcor"
MATCH="false"
PASS="changeit"

# main

VALIDADE=$(echo $PASS |$KEYTOOL -v -list -storetype pkcs12 -keystore $KEYSTORE | grep -A3 CN=$DOMINIO | grep -i valid | awk -F "until: " '{print $2}'"")


# Transforma em timestamp e ve qts dias faltam

VENCIMENTO=$(date -d "$VALIDADE" +"%s")
HOJE=$(date +"%s")

DFALTANTES=$(echo "($VENCIMENTO - $HOJE)/60/60/24" | bc)

# Valida o threshold e envia para o quebec

if [ $THRESHOLD -gt $DFALTANTES ]; then
        STATUS=2
        MSG="Necessario gerar um novo PFX para o HSBC"
else
        STATUS=0
        MSG="OK"
fi

# ENVIA PARA QUEBEC-API
/export/scripts/send-xml.pl -h $HOST -i $ITEM -m $MONITOR -v "$MSG" -s $SERVICE -u $STATUS -t $MATCH
