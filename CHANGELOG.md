1.3 (2016-09-06)
===

#####New Features

* XCTest Integration

	- Run Fitnesse Acceptance Tests with Xcode using the new Acceptance Unit Test Bundle Template.
	- See Fitnesse tests reports as regular XCTest cases.
	- Supports xcodebuild and xctool and works with popular CI systems such as Travis and Jenkins.
	
##### OCSlimProject Enhancements

* Fitnesse (version ) now included, no seperate download needed.

* Upgrade ios-sim to version 5.0.8, improves stability and removes errors.

* Support for macOS 10.11 and Xcode 8

* Improves project resource and script architecture to share resources between multiple targets.

* Improves project architecture to provide improved flexibility for future script changes.

##### LaunchFitnesse

* New Features

	* Adds --shutdown command. *Performs a clean shutdown of any running instances of Fitnesse.*

		```$ ./LaunchFitnesse --shutdown ```

	* Adds --test command. *Runs Tests specified by the Suite Name and redirects  output to a file.*

		```$ ./LaunchFitnesse --test <suitename> -b <filename>```

	* Adds --open command. *Opens Fitnesse in a Browser.*

		```$ ./LaunchFitnesse --open```
		
* Enhancements

	* LaunchFitnesse exits after launching, returning control to the user.

	* Detects existing versions of Fitnesse instead of attempting to launch a new instance
	
	* Reduces launch time of iPhone Simulator by recyling the last Simulator used by Xcode



