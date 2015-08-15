#
#   Copyright 2014 Jonathan M. Reid. See LICENSE.txt
#   Created by: Jon Reid, http://qualitycoding.org/
#   Source: https://github.com/jonreid/XcodeCoverage
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export | egrep '(INSTALL_DIR)|(PRODUCT_NAME)|(TARGET_BUILD_DIR)|(EXECUTABLE_FOLDER_PATH)' > ${DIR}/env.sh
