#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@protocol OCSlimProjectAssertRecorder <NSObject>

- (void)recordFailWithTestCase:(XCTestCase* _Nonnull)test;
- (void)recordPassWithTestCase:(XCTestCase* _Nonnull)test;

@end

@interface OCSlimProjectXCTestAssertRecorder : XCTestCase <OCSlimProjectAssertRecorder>


@end

@interface OCSlimProjectAssertRecorderSpy : NSObject <OCSlimProjectAssertRecorder>

@property (nonatomic, assign) BOOL didRecordFail;
@property (nonatomic, assign) BOOL didRecordPass;

@end
