#!/bin/sh
TW="/opt/jboss-4.2.3.GA/bin/twiddle.sh"
MBEAN="eventprocessor.selfTest:custom=SelfTestJMX"
ATTRIB="validateAMADM"
item="eventprocessor"
monitor="SelfTestJMX"
service="validateAMADM"
match="false"
send="/export/scripts/send-xml.pl"

fn_send_xml(){
$send -i $item -m $monitor -v "$value" -s $service -u $status -a $match
}

fc_check(){
CHECK_SELF=`$TW -s srvhost invoke $MBEAN $ATTRIB | sed 's/<[^>]*>//g' | cut -d ":" -f3 | sed 's/ //g'`



if [ $CHECK_SELF = OK ]
    then
        value="OK"
        status="0"
    else
        value="CRITICAL"
        status="1"
fi
fn_send_xml
}
fc_check
