#!/bin/sh

CSRF_TOKEN=$(cat ~/.config/syncthing/csrftokens.txt)

syncthing &

# wait for service to start
retries=5
while ! curl -s -L -k -X GET -H "X-CSRF-Token-UDCNU:$CSRF_TOKEN" "http://localhost:8384/rest/system/ping"
do
    sleep 1
	if test $retries -eq 0; then
                echo "Syncthing is not running, exiting"
		exit 100
	fi
	retries=$((retries-1))
done

# force rescan
curl -s -L -k -X POST -H "X-CSRF-Token-UDCNU:$CSRF_TOKEN" "http://localhost:8384/rest/db/scan"

# wait for completion
while
	sleep 5
do
	if ! curl -s -L -k -X GET -H "X-CSRF-Token-UDCNU:$CSRF_TOKEN" \
		"http://localhost:8384/rest/system/ping"
	then
                echo "Syncthing is not running, exiting"
		exit 101
	fi

	if ! curl -s -L -k -X GET -H "X-CSRF-Token-UDCNU:$CSRF_TOKEN" \
		"http://localhost:8384/rest/system/connections" \
		| grep -q '"connected":.*true'
	then
                echo "No devices connected, exiting"
                syncthing cli operations shutdown
		exit 102
	fi

	if curl -s -L -k -X GET -H "X-CSRF-Token-UDCNU:$CSRF_TOKEN" \
		"http://127.0.0.1:8384/rest/db/status?folder=default" \
                | grep -q '"state": "idle"'
	then
                echo "Everything up to date"
                syncthing cli operations shutdown
		break
	fi
done
