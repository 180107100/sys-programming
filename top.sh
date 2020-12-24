#!/bin/bash
Sort(){ for line in "${!array[@]}"; do echo $line' - '${array[$line]}$'\n';done | sort -rn -k3 | head -$n;}
Sum(){ s=0;for line in $sorted; do
n=$(echo "$line" | rev | cut -d' ' -f 1 | rev)
s=$(($s + $n));done
counter=1;for line in $sorted; do
n=$(echo "$line" | rev | cut -d' ' -f 1 | rev)
if [[ $s == 0 ]] ;then percent='0.00000'
else percent=$(echo "scale=5; $n / $s" | bc);percent=$(echo "scale=3 ; $percent*100+0.05" | bc); fi
echo $counter. $line' - '${percent::-4}'%'
counter=$(($counter + 1));done;}
IFS=$'\n';declare -A array;n=$1;
for line in $(cat $2);do
referrer=$(echo $(echo "$line" | cut -d' '  -f 11) | cut -d'"' -f 2);byte=$(echo $line| cut -d' '  -f 10)
if [ "$referrer" == "-" ] || [ "$referrer" == "" ];then continue;fi; 
if [ $byte == - ];then byte=0;fi
if [ ${array[$referrer]+_} ];then array[$referrer]=$((${array[$referrer]} + $byte))
else array[$referrer]=$byte;fi;done
sorted=$(Sort ${array[@]} $n);Sum $sorted