PID=$$

CheckLock()
   {
     if [ -e $LOCK ]
        then
            ps -p `echo $PID` | grep [0-9]
            if [ $? -eq 0 ]
                then
                    echo "[$(date +%F-%T)] Arquivo de lock existe, saindo" >> $LOGS
                    exit 0
            fi
        else
            echo $PID > $LOCK
     fi
   }
 
