#!/bin/bash
SLIM_PORT=$1
TEST_RUNNER_SCRIPT=%s
ENV_FILE_PATH=%s
ERROR_LOG_FILE=%s

$TEST_RUNNER_SCRIPT $ENV_FILE_PATH $SLIM_PORT 2> >(tee $ERROR_LOG_FILE >&2)

ERROR_LOG_NO_WHITESPACE=$(more "$ERROR_LOG_FILE" | sed 's/ *$//')

log() {
	echo "[OCSP_RUN] INFO: $1"
}

error() {
	>&2 echo "[OCSP_RUN] ERROR: $1"
	exit 1
}

if [ -z "$ERROR_LOG_NO_WHITESPACE" ]; then 
	rm $ERROR_LOG_FILE
	log "Slim Test System Exited OK"
	exit 0
else
	error "Slim Test System Exited Abnormally With Reported Errors"
fi