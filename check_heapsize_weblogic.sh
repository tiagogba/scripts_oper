##########################################################################
##                                                                      ##
## autor: Tiago Albuquerque & Marcelo Varge                             ##
## date: 08/04/2014                                                     ##
## version: 1.1                                                         ##
## email:tiago.albuquerque.ext@dasa.com.br                              ##
## Geracao de grafico no centreon para current session application      ##
## Aceita argumentos                                                    ##
##                                                                      ##
##                                                                      ##
##########################################################################

while getopts fbi:u:p:t:m: OPCAO; do
    case "${OPCAO}" in
       i) IP="${OPTARG}" ;;
       u) USR="${OPTARG}" ;;
       p) PW="${OPTARG}" ;;
       t) TP="${OPTARG}" ;;
       m) INST="${OPTARG}" ;;
       f) FRONT=1 ;;
       b) BACK=1 ;;
       \?) echo "Invalid option: -$OPTARG" >&2 ;;
    esac
done

HOME_SETENV="/opt/bea/wlserver_10.0/server/bin/setWLSEnv.sh"
array01=()

fn_source(){
        source $HOME_SETENV 2&>1 /dev/null
        if [[ ! $? == 0 ]]
                then
                        echo "setWLSENV nao carregada"
                        exit 1
                fi
}

fn_check_back(){
        fn_source

        array01[0]="OK | "
        x=1

        for i in `seq -w 1 10`
        do
                re='^[0-9]+$'
                INSTANCIA=$INST$i
                array01[$x]=`echo $(echo $INSTANCIA | tail -c 6)_heapsize_free_back\=`
                x=$[$x + 1]
                #"master:ServerRuntime=appmotfrt$i,Name=appmotfrt$i,Type=JVMRuntime,Location=appmotfrt$i"; done | grep HeapFreeCurrent
                array01[$x]=`java weblogic.Admin -adminurl t3://$IP -username $USR -password $PW GET -pretty -type $TP -mbean "master:ServerRuntime=$INSTANCIA,Name=$INSTANCIA,Type=JVMRuntime,Location=$INSTANCIA" | grep HeapFreeCurrent | cut -d':' -f2 | sed 's/^ //g' 2> /dev/null`
                if [[ -z ${array01[$x]} ]];then
                        array01[$x]="null"
                fi
                x=$[$x + 1]
        done
}


fn_check_front(){
        fn_source

        array01[0]="OK | "
        x=1

        for i in `seq -w 1 10`
        do
                re='^[0-9]+$'
                INSTANCIA=$INST$i
                array01[$x]=`echo $(echo $INSTANCIA | tail -c 6)_heapsize_free_front\=`
                x=$[$x + 1]
                array01[$x]=`java weblogic.Admin -adminurl t3://$IP -username $USR -password $PW GET -pretty -type $TP -mbean "master:ServerRuntime=$INSTANCIA,Name=$INSTANCIA,Type=JVMRuntime,Location=$INSTANCIA" | grep HeapFreeCurrent | cut -d':' -f2 | sed 's/^ //g' 2> /dev/null`
                if [[ -z ${array01[$x]} ]];then
                        array01[$x]="null"
                fi
                x=$[$x + 1]
        done
}






fn_main(){
if [[ $FRONT -eq 1 ]];then
        echo executa checa_front
        fn_check_front
fi
if [[ $BACK -eq 1 ]];then
        echo executa checa_back
        fn_check_back
fi
}


fn_main

echo ${array01[@]} | sed 's/\= /\=/g' | sed 's/ /\;/3g'
exit 0
