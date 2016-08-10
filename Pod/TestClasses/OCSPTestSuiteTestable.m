#import "OCSPTestSuiteTestable.h"
#import "OCSPPrincipalTestObserver.h"
#import "OCSPAssertRecorder.h"

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

+ (id<OCSPTestCaseReportCenter>) reportCenter {
    
    OCSPPrincipalTestObserver *center = [[OCSPPrincipalTestObserver alloc] init];
    
    center.disableFixForXcodeDisappearingTestCaseByAppendingDummyTest = YES;
    
    return center;
    
}
@end
