# OCSlimProject

[![CI Status](http://img.shields.io/travis/paulstringer/OCSlimProject.svg?style=flat)](https://travis-ci.org/paulstringer/OCSlimProject)
[![Version](https://img.shields.io/cocoapods/v/OCSlimProject.svg?style=flat)](http://cocoapods.org/pods/OCSlimProject)
[![License](https://img.shields.io/cocoapods/l/OCSlimProject.svg?style=flat)](http://cocoapods.org/pods/OCSlimProject)
[![Platform](https://img.shields.io/cocoapods/p/OCSlimProject.svg?style=flat)](http://cocoapods.org/pods/OCSlimProject)


###OCSlimProject is a lightweight Xcode project template and CocoaPod for creating fast, rock solid, automated tests on iOS and OS X using [Fitnesse](http://fitnesse.org). Fitnesse is a fully integrated standalone wiki and acceptance testing framework ideal for ATDD or BDD software development.


### Usage

To run the example CocoaPod project, clone the repo, and run `pod install` from the Example directory first.

### Requirements
- Xcode 7
- CocoaPods
- [Java 1.8](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html) (required for Fitnesse)

### Installation

OCSlimProject is available to your own projects through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
platform :ios, 9.0
pod 'OCSlimProject'
```

## Installing the Xcode Templates


###OCSlimProject uses Xcode templates to simplify the integration between your App and Fitnesse. Downloading the templates is the first step to getting started.

* Download [OCSlimProject](http://paulstringer.github.io/OCSlimProject/) from GitHub

* Run ```$ make```. This adds the Xcode project templates for creating Acceptance Test targets within Xcode (iOS & OS X). These are installed at ~/Library/Developer/Xcode/Templates/Test  (e.g.  unaffected by Xcode updates or new versions)

* Look under the Test section of Xcode's New Target setup. In both iOS and OS X you should see the addition of two new types of testing target:
	* Acceptance Tests
	
	> This target builds an iOS/OS X Application for Acceptance Testing your App using the Fitnesse framework. Requires a project that uses CocoaPods.
	
	* Acceptance Unit Tests Bundle

	> This target builds an iOS/OS X unit test bundle that generates results from your Acceptance Tests target using Fitnesse and then reports them within Xcode using the XCTest framework.
	
## How to Add 'Acceptance Tests' Targets to your Project

###OCSlimProject works by creating a special flavour of your app, one that contains just your apps business logic + simple 'fixtures' which is another word for glue code you write in Swift or Obj-C that provides the entry point for Fitnesse to poke your code. 

###Creating an 'Acceptance Tests' target is the next step in your setup. Following this step your ready to begin writing and automating acceptance tests with Fitnesse.

* Add an 'AcceptanceTests' target to your Project using the 'Acceptance Tests' templates installed under 'Test' templates. (Templates are installed for both iOS and OS X.)

* Using CocoaPods link OCSlimProject to your 'AcceptanceTests' target with the following Podfile entry
    
	```
    target 'AcceptanceTests' do
        platform :ios, 9.0
	    pod 'OCSlimProject'
    end
	```
* Run either ```pod install``` or ```pod update``` as needed

* Build the 'AcceptanceTests' target to generate the Application (repeat this after each code change)

* Launch Fitnesse by running the script ```./LaunchFitnesse``` that's generated automatically in your project's root directory

* Follow the prompt to download [Java 1.8](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html) if needed.

* Copy the folder at OCSlimProject/Example/FitNesseRoot/OCSlimProjectExamplePage into your project's own FitNesseRoot folder

* With Fitnesse running, check out the [example](http://localhost:8080/OCSlimProjectExamplePage) you just copied.

* You're ready to begin writing [Acceptance tests and Fixtures](http://stringerstheory.net/acceptance-testing-with-ios/)  in Obj-C or Swift and automating them with Fitnesse.


## Integrating with XCTest using 'Acceptance Unit Tests Bundle'

###OCSlimProject integrates seamlessly into your development and CI worfklows by supporting XCTest. Quickly run and see reports of your Acceptance Tests within Xcode or with xcodebuild.

* Add an 'AcceptanceUnitTests' target to your Project using the 'Acceptance Unit Test Bundle' template available under 'Test' templates. (Templates are installed for both iOS and OS X.)

* Enter 'OCSlimProjectExamplePage' as the 'Fitnesse Suite Page Name' in the template settings following our earlier example.

* Edit your Podfile and add the following Podfile entry
    
	```
    target 'AcceptanceUnitTests' do
        platform :ios, 9.0
        pod 'OCSlimProjectTestBundleSupport'
    end
	```
* Run ```pod update```

* Add your 'AcceptanceTests' target as a 'Target Dependancy' of this new target in Build Phases. This ensures that that is built prior to the tests being run and ensure your results are based on the latest code.

* Hit CMD-U to verify your Acceptance Tests run.

### Finally 

* Add the 'AcceptanceUnitTest' target to the test phase of any schemes where you want the Acceptance Tests to be run as part of your regular CMD-U develop and test workflow. E.g. Add 'AcceptanceUnitTest' to the test phase of your apps target to have acceptance tests run at the same time as running your regular unit tests.
	
*The template you choose initially should match the original platform of the Acceptance Test target. E.g. if you have an iOS Acceptance Tests app, use the iOS Acceptance Unit Test Bundle*
 

--- 

# Acknowledgements
The owner of this repository takes no credit for the following included resources (except for the ones credited to the owner). This is a convienient lightweight wrapper either inspired by or using these resources together with some project glue. The aim has been to automate the process of setting up Xcode projects so as to more easily be able to use 'ocslim' and integrate with Fitnesse. 

### Fitnesse
Created by: Fitnesse.org

<http://fitnesse.org>

### OCSlim, RunTestsTargetWithSlimPort
Created by: Erik Meyer, 8th Light 

<https://github.com/ericmeyer/ObjectiveCSlim>

<https://github.com/dougbradbury/cslim/tree/ocslim>

### ios-sim
Created by: Phonegap

<https://github.com/phonegap/ios-sim>

### exportenv.sh
Created by: Jon Reid

<https://github.com/jonreid/XcodeCoverage>

### Xcode Project Templates, OCSlimProjectTestBundleSupport, LaunchFitnesse
Created by: Paul Stringer

<https://github.com/paulstringer/OCSlimProject>


### License
OCSlimProject is available under the MIT license. See the LICENSE file for more info.
