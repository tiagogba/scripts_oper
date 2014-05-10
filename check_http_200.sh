#/bin/sh

#################################################################
##      DASA - Diagnostico das americas                        ##
##      Script - Checa status 200 nos servidores do pclin      ##
##      Autor: Tiago Albuquerque                               ##
##      Data: 25/02/2014                                       ##
#################################################################



fn_maketemp(){
ARQUIVO="/tmp/temp_$NOME"
REMOVE=$(rm -rf $ARQUIVO)
}

fn_valida(){
$REMOVE
for i  in `seq -w 1 10`
do
        CMD=$(curl -sL -w "%{http_code} %{url_effective}\\n" "$NOME$i.dasacorp.com.br:80$i/pclin"  | sed 's/<[^>]\+>//g' | tail -n1 | awk {'print $1}')
        if [ $CMD != 200  ]
        then
                echo "$NOME$i" >> $ARQUIVO
#       else
#               echo "OK"
        fi
done
}

fn_check(){

fn_maketemp
fn_valida

if [ -f $ARQUIVO ]
        then
#               echo -e "existem servidores com problema\n"
#               cat $ARQUIVO | sed 's/\n/\ -\ /g'
                echo Servidores com erro: `sed -e :a -e '$!N; s/\n/\; /; ta' $ARQUIVO`
                exit 2
        else
                echo "OK"
                exit 0
fi
}

if [ -z $1 ];then
        echo "Sintaxe: $0 [apppclbck | apppclfrt]"
        exit 1
else
        NOME=$1
        fn_check
fi
