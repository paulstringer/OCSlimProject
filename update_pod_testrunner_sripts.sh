#!/bin/sh

####################################
# Command Line Argument Processing #
####################################
ACTION=UPDATE-POD-INSTALL

while [ "$1" != "" ]; do

    case $1 in
		
		-i | --install )		shift
								ACTION=UPDATE-POD-INSTALL
                                ;;
								
		-r | --update-reverse )	shift
								ACTION=COPY-FROM-LOCAL-POD-INSTALL
								;;
		
		esac
		shift
done

case "$ACTION" in

	UPDATE-POD-INSTALL) 
		cp Pod/Support/iOS/* Example/Pods/OCSlimProject/Pod/Support/iOS
		cp Pod/Support/OSX/* Example/Pods/OCSlimProject/Pod/Support/OSX
		;;
		
	COPY-FROM-LOCAL-POD-INSTALL)
		cp Example/Pods/OCSlimProject/Pod/Support/iOS/* Pod/Support/iOS
		cp Example/Pods/OCSlimProject/Pod/Support/OSX/* Pod/Support/OSX
		;;
		
esac
