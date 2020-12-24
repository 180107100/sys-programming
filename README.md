### spfinal solution

***
* Name: Dana Aldabergenova
* Email: 180107100@sdu.stu.edu.kz
* Variant: [1](../variants/variant01.md)
* Solution: [./top](./top)
***
## Sort function
***
* ```Sort(){ for line in "${!array[@]}"; do echo $line' - '${array[$line]}$'\n';done | sort -rn -k3 | head -$n;}``` : Parse array and sort output in the end using ```sort```. ```-k3``` means sort by third element. In our case it is value in key-value pair. ```head -$n``` returns only first *n* lines of output
***
## Sum function
***
* ```Sum(){ s=0;for line in $sorted; do```: declare ```s```, that will store summation. Start parsing result of ```sort``` function.
* ```n=$(echo "$line" | rev | cut -d' ' -f 1 | rev)```: cut the last part of ```cut```, that is number of bytes. ```rev``` will help take the last part of separation 
* ```s=$(($s + $n));done``` : update value of ```s``` by adding ```n```
* ```counter=1;for line in $sorted; do``` : declare ```counter``` variable. Start parsing result of ```sort``` function.
* ```n=$(echo "$line" | rev | cut -d' ' -f 1 | rev)``` : cut the last part of ```cut```, that is number of bytes. ```rev``` will help take the last part of separation 
* ```if [[ $s == 0 ]] ;then percent='0.00000'``` : checking value of ```s```. If it is equal to zero *0*, then set *"0.00000"* to percent. It will prevent error while dividing ```n``` by ```s```.
* ```else percent=$(echo "scale=5; $n / $s" | bc);percent=$(echo "scale=3 ; $percent*100+0.05" | bc); fi``` : else calculate ```$n/$s``` ratio and multiply by 100 to get percent. Rounding is standard.
* ```echo $counter. $line' - '${percent::-4}'%'``` : show result. ```percent::-4``` will remove last 4 characters from ```percent```
* ```counter=$(($counter + 1));done;}``` : update value of ```counter``` by 1 and close loop.
## Main part
* ```IFS=$'\n';declare -A array;n=$1;``` : set ```$'\n'``` to ```IFS```. Declare array for storing referrers and bytes. decalre. Assign first argument to ```n``` variable
* ```for line in $(cat $2);do``` : start parsing content of the file. Content of file is taken with ```cat``` from second argument.
* ```referrer=$(echo $(echo "$line" | cut -d' '  -f 11) | cut -d'"' -f 2);byte=$(echo $line| cut -d' '  -f 10)``` : referrer: set 11th part of ```cut``` function and remove first and last quotes. bytes: set 11th part of ```cut``` function and remove first
* ```if [ "$referrer" == "-" ] || [ "$referrer" == "" ];then continue;fi; ``` : if ```referrer``` is equal to *"-"* *""*, then skip remaining part of loop using ```continue``` keyword.
* ```if [ $byte == - ];then byte=0;fi``` : if ```bytes``` is equal to *"-"*, then set 0 to ```bytes```
* ```if [ ${array[$referrer]+_} ];then array[$referrer]=$((${array[$referrer]} + $byte))``` : if array contains ```referrer``` then update value by adding ```bytes```
* ```else array[$referrer]=$byte;fi;done``` : else set value as ```bytes```
* ```sorted=$(Sort ${array[@]} $n);Sum $sorted:``` : save sorted output in ```sorted``` variable and pass it to ```Sum``` function