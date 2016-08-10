#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface OCSPPrincipalTestObserver : NSObject <XCTestObservation>

- (XCTestSuite *)testSuite __attribute__((deprecated));

@property (nonatomic, assign) BOOL disableFixForXcodeDisappearingTestCaseByAppendingDummyTest;

@end
