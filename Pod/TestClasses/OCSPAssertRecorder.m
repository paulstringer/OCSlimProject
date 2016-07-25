#import "OCSPAssertRecorder.h"

@implementation OCSPXCAssertRecorder

- (void)recordFailWithTestCase:(XCTestCase *)test message:(NSString *)message{
    
    _XCTPrimitiveFail(test, @"Fitnesse acceptance test page failed with message '%@'", message);
    
}

- (void)recordPassWithTestCase:(XCTestCase *)test {
    
    _XCTPrimitiveAssertTrue(test, YES, @"");
    
}

@end

@implementation OCSPAssertRecorderSpy

- (void)recordFailWithTestCase:(XCTestCase *)test message:(NSString *)message{
    
    self.didRecordFailMessage = message;
    self.didRecordFail = true;
    
}

- (void)recordPassWithTestCase:(XCTestCase*)testCase {
    
    self.didRecordPass = true;
    
}

@end
