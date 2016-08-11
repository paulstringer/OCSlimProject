FITNESSE_SUITE_NAME=$1
TEST_REPORT_FILE_PATH=$2
TEST_RUNNER_ERROR_LOGFILE=${PROJECT_DIR}/OCSlimProjectTestRunner-Error.log
RETURN_CODE=0
function main {
	echo "[OCSP_TEST] Fitnesse Test Suite=$FITNESSE_SUITE_NAME"	
	echo "[OCSP_TEST] Destination Report File Path=$TEST_REPORT_FILE_PATH"
	${PROJECT_DIR}/LaunchFitnesse -d "${PROJECT_DIR}" -b "$TEST_REPORT_FILE_PATH" --verbose --test "$FITNESSE_SUITE_NAME" >&1 
}

function report_errors {

	if [ -f "$TEST_RUNNER_ERROR_LOGFILE" ]; then
		echo "[OCSP_TEST] FATAL: Errors Occured, Aborting..."
		>&2 echo "$(<$TEST_RUNNER_ERROR_LOGFILE)"
		RETURN_CODE=1
	fi
}

main
report_errors
exit $RETURN_CODE