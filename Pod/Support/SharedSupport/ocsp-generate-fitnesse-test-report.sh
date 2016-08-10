FITNESSE_SUITE_NAME=$1
TEST_REPORT_FILE_PATH=$2

function main {
	echo "[OCSP_TEST] Fitnesse Test Suite=$FITNESSE_SUITE_NAME"	
	echo "[OCSP_TEST] Destination Report File Path=$TEST_REPORT_FILE_PATH"
	${PROJECT_DIR}/LaunchFitnesse -d "${PROJECT_DIR}" -b "$TEST_REPORT_FILE_PATH" --verbose --test "$FITNESSE_SUITE_NAME" >&1 
}

main
					