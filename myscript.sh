
#!/bin/sh

if [ $# -eq 0 ]
then
    ps -ao tty --no-header | sort | uniq
else    
    ps -t $1 -o pid,tty,comm --no-header
    echo `last | grep $1 | head -1 | awk -F ' ' '{print $1}'`
    while [ $# -ne 0 ]
    do
        if who | grep -q $1
        then
            echo "vartotojas prisijunges"
            user=`who | grep $1 | awk -F ' ' '{print $1}'`
            ip=`who | grep $user | awk -F ' ' '{print $NF}' | sort | uniq`
            echo $ip
            if echo $ip | grep -q "(158.129"
            then
                echo "ip adresas vidinis"
            else
                echo "ip adresas ne  vidinis"
            fi
            
            if ps -u $user | grep -q $1
            then
                echo "vartotojas turi procesu susijusiu su siuo terminalu"
            else
                echo "vartotojas neturi procesu susijusiu su siuo terminalu"
            fi
        else
            echo "vartotojas neprisijunges"
        fi
        shift 1
    done
fi

