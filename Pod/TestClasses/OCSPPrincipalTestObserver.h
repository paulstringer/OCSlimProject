#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "OCSPTestCaseReport.h"


@interface OCSPPrincipalTestObserver : NSObject <XCTestObservation, OCSPTestCaseReportCenter>

+ (XCTestSuite *)testSuite __attribute__((deprecated));

- (NSArray <OCSPTestCaseReport*> * )testCaseReports;

@property (nonatomic, assign) BOOL disableFixForXcodeDisappearingTestCaseByAppendingDummyTest;

@end
