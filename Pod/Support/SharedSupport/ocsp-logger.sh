#!/bin/sh

ACTION=LOG_PATH

function main() {

    if [ "$ACTION" == "LOG_PATH" ]; then
	    local LOGDIR="Logs"
	    local LOGPATH="$(pwd)/$LOGDIR"
	    local LOGFILENAME="$(date +%Y%m%d-%H%M%S).log"
	    local LOGFILE="$LOGPATH/$LOGFILENAME"
	    mkdir -p $LOGPATH
        echo "$LOGFILE"
    fi

}

main