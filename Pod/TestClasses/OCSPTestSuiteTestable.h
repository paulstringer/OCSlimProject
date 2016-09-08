#import <Foundation/Foundation.h>
#import "OCSPTestSuite.h"

@class OCSPAssertRecorderSpy;

@interface OCSPTestSuiteTestable : OCSPTestSuite

+ (OCSPAssertRecorderSpy *)assertRecorder;

@end
