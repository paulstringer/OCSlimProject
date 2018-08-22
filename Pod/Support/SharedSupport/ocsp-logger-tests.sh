#!/bin/sh
source '../../../assert.sh/assert.sh'

LOGPATH=$(./ocsp-logger.sh new-log-file)
LOGBASENAME=$(basename $LOGPATH)
LOGDIR=$(dirname $LOGPATH)

assert_not_empty "$LOGPATH"
[ "$?" == 1 ] && log_failure "new-log-file should not be empty"

test -d "$LOGDIR"
assert_eq 0 $?
[ "$?" == 1 ] && log_failure "new-log-file '$LOGDIR' is not a valid directory"

expected="slim_system.log"
assert_eq "$LOGBASENAME" "$expected"
[ "$?" == 1 ] && log_failure "new-log-file '$LOGBASENAME' is not the expected '$expected' filename"



