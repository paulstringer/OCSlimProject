#!/bin/sh

################################################################
# DEV TOOL FOR UPDATING POD SUPPORT SCRIPTS DURING DEVELOPMENT #
################################################################

POD_SUPPORT_PATH=Pod/Support
POD_LOCAL_INSTALL_SUPPORT_PATH=Example/Pods/OCSlimProject/Pod/Support


# Subroutines

copyFromPodSourceToLocalInstall() {
	copy $POD_SUPPORT_PATH $POD_LOCAL_INSTALL_SUPPORT_PATH
	exit 0
}

copyFromLocalInstallToPodSource() {
	copy $POD_LOCAL_INSTALL_SUPPORT_PATH $POD_SUPPORT_PATH 
	exit 0
}

copy() {
	echo "Copying OCSlimProject Pod support files from location $1 -> $2"
	cp $1/iOS/* $2/iOS
	cp $1/OSX/* $2/OSX
}

# Main

while [ "$1" != "" ]; do

    case $1 in
		
		-i | --install )		copyFromPodSourceToLocalInstall
                                ;;
								
		-r | --update-reverse )	copyFromLocalInstallToPodSource
								;;
		
		esac
		shift
done

# Default behaviour if no arg provided

copyFromPodSourceToLocalInstall
