#import <XCTest/XCTest.h>

@interface OCSPTestCase : XCTestCase

@end

@implementation OCSPTestCase

- (void)testDoNotRemoveThisClassFromTestTarget {
    
    XCTAssertTrue(YES, @"Removal of this XCTestCase file will likely result in an invalid XCTest bundle. A valid XCTestBundle requires atleast one real XCTestCase class to be part of the target for it to run. (Feel free to disable this test after reading this message)");
    
}

@end
