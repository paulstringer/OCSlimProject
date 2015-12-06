# OCSlimProject

[![CI Status](http://img.shields.io/travis/Paul Stringer/OCSlimProject.svg?style=flat)](https://travis-ci.org/Paul Stringer/OCSlimProject)
[![Version](https://img.shields.io/cocoapods/v/CocoaSlim.svg?style=flat)](http://cocoapods.org/pods/OCSlimProject)
[![License](https://img.shields.io/cocoapods/l/CocoaSlim.svg?style=flat)](http://cocoapods.org/pods/OCSlimProject)
[![Platform](https://img.shields.io/cocoapods/p/CocoaSlim.svg?style=flat)](http://cocoapods.org/pods/OCSlimProject)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

If you see the following error,

    Update all pods
    Updating local specs repositories
    Analyzing dependencies
    Fetching podspec for `CocoaSlim` from `../`
    Fetching podspec for `cslim` from `../../ObjectiveCSlim/cslim`
    [!] No podspec found for `cslim` in `../../ObjectiveCSlim/cslim`

then you must clone [ObjectiveCSlim](https://github.com/ericmeyer/ObjectiveCSlim.git) and 
try again. You must clone ObjectiveCSlim beside Slim-iOS-TestRunner:

	.
    ├── ObjectiveCSlim
    └── Slim-iOS-TestRunner
    
## Requirements
- Xcode 7
- Java 6 (required for Fitnesse)


## Installation

OCSlimProject is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "OCSlimProject"
```

## Author

Paul Stringer, paulstringer@mac.com

## License

OCSlimProject is available under the MIT license. See the LICENSE file for more info.


----------


# OCSlimProject
A lightweight Project Template and scripts to help you get setup writing fast, rock solid, non UI based Acceptance Tests using [Fitnesse](http://fitnesse.org).

# Acknowledgements
The owner of this repository takes no credit for the following included resources (except for the ones credited to the owner). This is a convienient lightweight wrapper around these resources together with some project glue automating the process of creating 'ocslim' based Apps  for use with Fitnesse.

### ios-sim

Created by: Phonegap, http://qualitycoding.org/
https://github.com/phonegap/ios-sim

### exportenv.sh

Created by: Jon Reid, http://phonegap.com
https://github.com/jonreid/XcodeCoverage

### RunTestsTargetWithSlimPort

Created by: Erik Meyer, https://blog.8thlight.com/eric-meyer/archive.html
https://github.com/ericmeyer/ObjectiveCSlim

### Xcode Project Templates, LaunchFitnesse
Created by: Paul Stringer, http://stringerstheory.net
https://github.com/paulstringer/Slim-iOS-TestRunner

--

How to Use
==========

* Run ```$ make```. This adds the OCSlimProject Template for creating Acceptance Test targets within Xcode
* Add an 'Acceptance Testing' target to your Project using the 'iOS Acceptance Test' template under iOS -> Test
* With CocoaPods link OCSlimProject to your Acceptance Tests target
    
	```
    target 'AcceptanceTests' do
	    pod 'OCSlimProject'
    end
	```
<<<<<<< HEAD

* Download [Fitnesse](http://www.fitnesse.org/FitNesseDownload) to the same root of your project location
* Copy the files from ./Scripts to the root of your Xcode project. 
* Start the Fitnesse server using the included script ./StartFitnesse
* Edit the [Root page](http://localhost:8080/root) and add the following:
   
    ```
    !define TEST_SYSTEM {slim}
    !define TEST_RUNNER {!-./RunTestsTargetWithSlimPort-!}
    !define SLIM_VERSION {0.0}
    !define COMMAND_PATTERN {%m}
    ```

* Add a new Test page and run the Test
* You're project is now ready to start writing [Acceptance tests and Fixtures](http://stringerstheory.net/acceptance-testing-with-ios/) using Fitnesse.
=======
    
* Build the project to create the Application (repeat this after code changes)
* Launch Fitnesse by running the script ./LaunchFitnesse
* Follow the prompt to download [Fitnesse](http://www.fitnesse.org/FitNesseDownload) to the  root of your project
* With Fitnesse running, check out the [example](http://localhost:8080/CocoaSlimExamplePage) provided in Fitnesse.
* You're now ready to start writing [Acceptance tests and Fixtures](http://stringerstheory.net/acceptance-testing-with-ios/)  in Obj-C or Swift and excercising them with Fitnesse.

Gotchas
=====

* Return values from Swift fixtures must be explicitly returned as NSString and not String.
* Likewise all input values must be explicitly of String types and converted as needed by your fixtures.
>>>>>>> 58edd77122b103c7e49d8451548d1f2f0a27492f
