[motion@blpodmoa01 scripts]$ cat check_sessions.sh
##########################################################################
##                                                                      ##
## autor: Tiago Albuquerque & Marcelo Varge                                             ##
## date: 08/04/2014                                                     ##
## version: 1.1                                                         ##
## email:tiago.albuquerque.ext@dasa.com.br                              ##
## Geracao de grafico no centreon para current session application      ##
## Aceita argumentos                                                    ##
##                                                                      ##
##                                                                      ##
##########################################################################

while getopts i:u:p:t:m: OPCAO; do
    case "${OPCAO}" in
       i) IP="${OPTARG}" ;;
       u) USR="${OPTARG}" ;;
       p) PW="${OPTARG}" ;;
       t) TP="${OPTARG}" ;;
       m) INST="${OPTARG}" ;;
       \?) echo "Invalid option: -$OPTARG" >&2 ;;
    esac
done

HOME_SETENV="/opt/oracle/middleware/wlserver/server/bin/setWLSEnv.sh"
array01=()

fn_source(){
        source $HOME_SETENV 2&>1 /dev/null
        if [[ ! $? == 0 ]]
                then
                        echo "setWLSENV nao carregada"
                        exit 1
                fi
}

fn_check(){
        fn_source

        array01[0]="OK | "
        x=1

        for i in `seq -w 1 10`
        do
                re='^[0-9]+$'
                INSTANCIA=$INST$i
        #       array01[$x]="$INSTANCIA_session="
                #`echo $(echo appmotfrt01 | tail -c 6)_teste`
                array01[$x]=`echo $(echo $INSTANCIA | tail -c 6)_session\=`
                x=$[$x + 1]
                array01[$x]=`java weblogic.Admin -adminurl t3://$IP -username $USR -password $PW GET -pretty -type $TP -mbean "domain:ServerRuntime=$INSTANCIA,Name=$INSTANCIA"\_",Type=WebAppComponentRuntime,Location=$INSTANCIA,ApplicationRuntime=motion-app" | grep OpenSessionsCurrentCount | cut -d':' -f2 | sed 's/^ //g' 2> /dev/null`
                if [[ -z ${array01[$x]} ]];then
                        array01[$x]="null"
                fi
                x=$[$x + 1]
        done
}

fn_check

echo ${array01[@]} | sed 's/\= /\=/g' | sed 's/ /\;/3g'
exit 0
