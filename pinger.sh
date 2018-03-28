#!/usr/bin/env bash

stp=0
count=0			# count of lost ICMP packets
wait=2			# seconds to wait
pcount=6 		# ping counts
target='127.0.0.1' 	#target to ping, usually default gateway
while stp==0; do
	/sbin/ping -q -c 1 -W 10 $target > /dev/null
	ping_err=$?
	if [ $ping_err -ne 0 ]  ; then
		count=$[$count+1]
		/bin/echo $count
		#echo $ping_err
		if [ $count -eq $pcount ]; then
			/usr/sbin/networksetup -setairportpower en0 off; /bin/sleep $wait; /usr/sbin/networksetup -setairportpower en0 on
		fi
	fi
	if [ $ping_err -eq 0 ]  ; then
		count=0
	fi
	
	/bin/sleep 0.1
	
done
