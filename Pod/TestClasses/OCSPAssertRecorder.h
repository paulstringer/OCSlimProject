#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@protocol OCSPAssertRecorder <NSObject>

- (void)recordFailWithTestCase:(XCTestCase* _Nonnull)test;
- (void)recordPassWithTestCase:(XCTestCase* _Nonnull)test;

@end

@interface OCSPXCAssertRecorder : XCTestCase <OCSPAssertRecorder>


@end

@interface OCSPAssertRecorderSpy : NSObject <OCSPAssertRecorder>

@property (nonatomic, assign) BOOL didRecordFail;
@property (nonatomic, assign) BOOL didRecordPass;

@end
