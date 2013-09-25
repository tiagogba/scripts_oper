#!/bin/bash

start=$(date +%s)
echo $start

for ((i=1; i<10; i++))
do 
echo "hello"
done

end=$(date +%s)
echo $end
dif=$(($end - $start))
echo "tempo de exec é $dif"
