#import "OCSPTestSuiteTestable.h"
#import "OCSPPrincipalTestObserver.h"
#import "OCSPAssertRecorder.h"
#import "OCSPTestReportCenter.h"

@implementation OCSPTestSuiteTestable

+ (OCSPAssertRecorderSpy *)assertRecorder {
    
    static OCSPAssertRecorderSpy *assertRecorderSpy = nil;
    
    if (assertRecorderSpy == nil) {
        
        assertRecorderSpy = [[OCSPAssertRecorderSpy alloc] init];
        
    } else {
        
        assertRecorderSpy.didRecordPass = NO;
        assertRecorderSpy.didRecordFail = NO;
        
    }
    
    return assertRecorderSpy;
    
}

+ (OCSPTestReportCenter *) reportCenter {
    
    OCSPTestReportCenter *center = [[OCSPTestReportCenter alloc] init];
    
    center.disableFixForXcodeDisappearingTestCaseByAppendingDummyTest = YES;
    
    return center;
    
}


@end
