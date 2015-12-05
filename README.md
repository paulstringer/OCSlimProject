# CocoaSlim

[![CI Status](http://img.shields.io/travis/Paul Stringer/CocoaSlim.svg?style=flat)](https://travis-ci.org/Paul Stringer/CocoaSlim)
[![Version](https://img.shields.io/cocoapods/v/CocoaSlim.svg?style=flat)](http://cocoapods.org/pods/CocoaSlim)
[![License](https://img.shields.io/cocoapods/l/CocoaSlim.svg?style=flat)](http://cocoapods.org/pods/CocoaSlim)
[![Platform](https://img.shields.io/cocoapods/p/CocoaSlim.svg?style=flat)](http://cocoapods.org/pods/CocoaSlim)

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

## Installation

CocoaSlim is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CocoaSlim"
```

## Author

Paul Stringer, paul.stringer@crowdmix.me

## License

CocoaSlim is available under the MIT license. See the LICENSE file for more info.


----------


# Slim-iOS-TestRunner
Scripts and Project templates to help build your iOS Acceptance Tests using Fitnesse.

# Acknowledgements
The owner of this repository takes no credit for the contents herein. This is just convienience pulling together of several scripts and tools to make running iOS apps with Fitnesse simpler.

ios-sim
Created by: Phonegap, http://qualitycoding.org/
https://github.com/phonegap/ios-sim

exportenv.sh
Created by: Jon Reid, http://phonegap.com
https://github.com/jonreid/XcodeCoverage

RunTestsTargetWithSlimPort
Created by: Erik Meyer, https://blog.8thlight.com/eric-meyer/archive.html
https://github.com/ericmeyer/ObjectiveCSlim

Xcode Templates
Created by: Paul Stringer, http://stringerstheory.net
https://github.com/paulstringer/Slim-iOS-TestRunner

--

How to Use
==========

* Run ```$ make``` to add Templates for creating Acceptance Test targets within Xcode
* Add a new 'Acceptance Testing' target to your Project using the 'iOS Acceptance Test' template under iOS -> Test
* Using CocoaPods link the cslim Pod to your Acceptance Tests target
 
    ```
    target 'AcceptanceTests' do
        pod 'cslim', :git => 'https://github.com/paulstringer/cslim.git', :branch => 'ocslim'
    end
	```

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
