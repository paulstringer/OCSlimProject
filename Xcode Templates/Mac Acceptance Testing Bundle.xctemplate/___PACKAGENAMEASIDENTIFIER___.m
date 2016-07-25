//
//  ___FILENAME___
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import <XCTest/XCTest.h>

#if __has_include(<OCSlimProjectTestBundleSupport/OCSlimProjectFitnesseTestsMain.h>)
#else
#pragma GCC error "'OCSlimProjectTestBundleSupport' pod not found. Add \" 'OCSlimProjectTestBundleSupport' \" to this test targets pod configuration."
#endif


@interface OCSPTestCase : XCTestCase

@end

@implementation OCSPTestCase

/**
 
 XCTest bundles require that atleast one XCTestCase class exists within the target for it to be valid. This test case must remain part of your target for the bundle to be a valid XCTest bundle. It is not intended that you add additional tests to this class but feel free to disable them.
 
 */

- (void)testDoNotRemoveThisClassFromTestTarget {

    XCTAssertTrue(YES, @"Removal of this XCTestCase file will likely result in an invalid XCTest bundle. A valid XCTestBundle requires atleast one real XCTestCase class to be part of the target for it to run.");
    
}

@end
