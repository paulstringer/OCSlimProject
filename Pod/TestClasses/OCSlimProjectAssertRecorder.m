#import "OCSlimProjectAssertRecorder.h"

@implementation OCSlimProjectXCTestAssertRecorder

- (void)recordFail {
    
    XCTFail(@"Fitnesse Test Failed");
}

- (void)recordPass {
    
    XCTAssertTrue(YES);
    
}

@end

@implementation OCSlimProjectAssertRecorderSpy

- (void)recordFail {
    
    self.didRecordFail = true;
    
}

- (void)recordPass {
    
    self.didRecordPass = true;
    
}

@end
