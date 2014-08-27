#!/bin/bash

ASADMIN_HOME="/opt/oracle/glassfish/bin"
PASS="/home/nagios/pass"


CURRENT_COUNT=$($ASADMIN_HOME/asadmin --user admin --passwordfile $PASS get --monitor server.applications.nomedaaplicacao.server.activesessionscurrent-current | grep server.application | cut -d '=' -f 2 | sed -e 's/^[ \t]*//')

echo "OK | servidor=$CURRENT_COUNT"
