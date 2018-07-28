#!/bin/sh

################################################################
# DEV TOOL FOR UPDATING POD SUPPORT SCRIPTS DURING DEVELOPMENT #
################################################################

POD_SUPPORT_PATH=Pod/Support
POD_LOCAL_INSTALL_SUPPORT_PATH=Example/Pods/OCSlimProject/Pod/Support

while [ "$1" != "" ]; do

    case $1 in
		
		-i | --install )		copy $POD_SUPPORT_PATH POD_LOCAL_INSTALL_SUPPORT_PATH
                                ;;
								
		-r | --update-reverse )	copy POD_LOCAL_INSTALL_SUPPORT_PATH $POD_SUPPORT_PATH 
								;;
		
		esac
		shift
done


copy() {
	cp $1/iOS/* $2/iOS
	cp $1/OSX/* $2/OSX
}