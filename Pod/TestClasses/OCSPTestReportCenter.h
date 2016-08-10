#import <Foundation/Foundation.h>

@class OCSPJUnitXMLParser;
@class OCSPTestCaseReport;

@interface OCSPTestReportCenter : NSObject

@property (nonatomic, assign) BOOL disableFixForXcodeDisappearingTestCaseByAppendingDummyTest;

@property (nonatomic, readonly, nonnull) NSString *testSuiteName;

- (nonnull NSArray <OCSPTestCaseReport*>  *  )testCaseReports;

@end
