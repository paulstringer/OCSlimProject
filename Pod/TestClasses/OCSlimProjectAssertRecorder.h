#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@protocol OCSlimProjectAssertRecorder <NSObject>

- (void)recordFail;
- (void)recordPass;

@end

@interface OCSlimProjectXCTestAssertRecorder : XCTestCase <OCSlimProjectAssertRecorder>


@end

@interface OCSlimProjectAssertRecorderSpy : NSObject <OCSlimProjectAssertRecorder>

@property (nonatomic, assign) BOOL didRecordFail;
@property (nonatomic, assign) BOOL didRecordPass;

@end
