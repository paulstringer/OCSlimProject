#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface OCSPPrincipalTestObserver : NSObject <XCTestObservation>

+ (XCTestSuite *)testSuite;

@property (nonatomic, assign) BOOL disableFixForXcodeDisappearingTestCaseByAppendingDummyTest;

@end
