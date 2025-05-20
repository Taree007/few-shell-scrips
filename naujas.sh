#!/bin/sh


echo "Argumentu kiekis: $#"



if [ $# -eq 0 ]
then
    user=`who am i | awk -F ' ' '{print $1}'`
    echo "$user"
    who | grep $user | awk -F ' ' '{print $2}'
    
else
    maxprocess=0
    for user in $@
    do
        if [ `ps -U $user --no-header -o sz | sort | tail -1` -gt $maxprocess ]
        then
            maxprocess=`ps -U $user --no-header -o sz | sort | tail -1`
            maxuser=$user
        fi
        if last --since today | grep -q $user    
        then
            echo `last -s today | grep $user | grep -v "still logged in" | wc -l`
        else
            echo `last $user | head -1 | awk -F ' ' '{print $4, $5, $6, $7}'`
            last $user | grep -E 'Sat|Sun' | head -5
        fi
    done
    echo "Didziausias procesas: $maxuser"
fi