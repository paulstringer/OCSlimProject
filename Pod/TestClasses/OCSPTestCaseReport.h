#import <Foundation/Foundation.h>

@interface OCSPTestCaseReport : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) BOOL passed;

@property (nonatomic, strong) NSString *errorMessage;

@end


@protocol OCSPTestCaseReportCenter

@required
- (NSArray <OCSPTestCaseReport *> *) testCaseReports;

@end

