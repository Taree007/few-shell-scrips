#!/bin/sh


if [ $# -eq 0 ]
then
	ps -A | awk '{ if( $2 ~ /pts/) {print $2}}' | sort | uniq
	exit 0
fi

for term in $*
do	
	echo '---------------------------'
	echo "Visi su terminalu $term susije procesai:"
	ps -A | grep -w $term | awk '{ print $1, $2, $4}'
	
	user=`last | grep $term | head -n 1 | awk '{print $1}'`
	echo "Su terminalu $term susijes vartotojas: $user"

	logins=`who | grep $user | awk '{print $5}'`
	echo 'Jo IP adresai yra:'
	for ip in $logins
	do
		ipPart=`echo $ip | awk -F . '{print $1$2}'`
		if [ $ipPart = '(158129' ]
		then
			echo "$ip - vidinis IP"
		else
			echo $ip
		fi
	done

	isOn=`who | grep $term | awk '{if( $1 == "'$user'") {print $0}}' | wc -l`
	
	if [ $isOn -gt 0 ]
	then
		echo "Sis vartotojas TURI aktyviu sesiju susijusiu su terminalu $term (pagal who rezultatus)"
	else
		echo "Sis vartotojas NETURI aktyviu sesiju susijusiu su terminalu $term (pagal who rezultatus)"
	fi
done

