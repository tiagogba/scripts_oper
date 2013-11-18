#!/bin/bash


##################################################################
##              Scrip de inicializacao do Introscope            ##
##                      Vers. 1.0                               ##
##                  Autor: Tiago Albuqueruqe                    ##
##                      13/11/2013                              ##
##                                                              ##
##################################################################



# chkconfig: 2345 95 20
# description: Script de inicializao do Webview intro
# processname: WebView

. /etc/rc.d/init.d/functions

HOME_INTRO="/em/Introscope9.5.0.0"
NAME="Introscope"
BIN="Introscope_WebView"
PID=$(ps -ef | grep Introscope_WebView |grep -v grep | awk '{print $2}')

# Start the service Introscope_WebView
start() {
        if [ "`ps -ef | grep Introscope_WebView |grep -v grep`" != "" ]
                then
                        echo "WebView Started"
                else
                        $HOME_INTRO/$BIN >/dev/null 2>&1 &
                        PID=$( ps -ef | grep Introscope_WebView |grep -v grep | awk '{print $2}')
                        echo "WebView Stated PID: $PID"
        fi
}


status(){
        if [ "`ps -ef | grep Introscope_WebView |grep -v grep`" != "" ]
                 then
                        echo "Process runnig PID: $PID"
                else
                         echo "WebView not stated"
        fi
}

# Restart the service Introscope_WebView
stop(){
        if [ "`ps -ef | grep Introscope_WebView |grep -v grep`" != "" ]
        then
        kill `ps -ef | grep Introscope_WebView |grep -v grep | awk '{print $2}'`
        echo "WebView Stopped"
        else
        echo "nao existe processo ativo"
        fi

}



### function main ###
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  status)
        status Introscope_WebView
        ;;
  restart|reload|coldrestart)
        stop
        start
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|reload|status}"
        exit 1
esac
exit 0
