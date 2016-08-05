#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface OCSPTestSuiteBuilder : NSObject <XCTestObservation>

+ (XCTestSuite *)testSuite;

@property (nonatomic, assign) BOOL disableFixForXcodeDisappearingTestCaseByAppendingDummyTest;

@end
