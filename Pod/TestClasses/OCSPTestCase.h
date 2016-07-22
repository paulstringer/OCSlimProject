#import <XCTest/XCTest.h>

@protocol OCSPAssertRecorder;

@interface OCSPTestCase : XCTestCase

- (nonnull id)initWithTestCaseName:(nonnull NSString *)name result:(BOOL)result;

- (nonnull id)initWithTestCaseName:(nonnull NSString *)name result:(BOOL)result assertRecorder:(nonnull id<OCSPAssertRecorder>)recorder;

- (void)run;

- (nonnull NSString *)testCaseName;

@end
