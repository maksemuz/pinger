#!/usr/bin/env bash

stp=0
count=0
wait=1
while stp==0; do
	/sbin/ping -q -c 1 -W 10 192.168.13.1 > /dev/null
	ping_err=$?
	if [ $ping_err -ne 0 ]  ; then
		count=$[$count+1]
		/bin/echo $count
		#echo $ping_err
		if [ $count -eq 5 ]; then
			/usr/sbin/networksetup -setairportpower en0 off; /bin/sleep $wait; /usr/sbin/networksetup -setairportpower en0 on
		fi
	fi
	if [ $ping_err -eq 0 ]  ; then
		#echo "c3 =" $count
		count=0
		#echo "c2 =" $count
	fi
	#echo "c=" $count
	/bin/sleep 0.1
	#echo "------"
done
