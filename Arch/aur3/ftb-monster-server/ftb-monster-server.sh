#!/bin/bash

. /etc/conf.d/ftb-monster || exit 1

cd $_SRVDIR
case $1 in
	start)
		if screen -ls|grep $FTBUSER
		then
			echo "Server already appears to be started"
		else
			screen -dmS "$FTBUSER" su "$FTBUSER" -c "java -Xmx${MAXHEAP} -Xms${MINHEAP} -XX:PermSize=${PERMSIZE} -XX:ParallelGCThreads=${GCTHREADS} -jar ${_SRVDIR}/${SERVERJAR} nogui"
		fi
		;;
	stop)
		if screen -ls|grep $FTBUSER
		then
			screen -S "$FTBUSER" -X stuff 'say Server Shutting Down in 5 Seconds\n'
			sleep 5
			screen -S "$FTBUSR" -X stuff 'stop\n'
			expect -c "exec screen -x $FTBUSER ; wait ; exit"
		else
			echo "Server does not appear to be started"
		fi
		;;
	*)
		echo "Please specify either start or stop to start or stop the service"
		;;
esac
