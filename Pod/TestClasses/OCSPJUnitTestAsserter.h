#import <XCTest/XCTest.h>

@protocol OCSPAssertRecorder;

@interface OCSPJUnitTestAsserter : XCTestCase

- (nonnull id)initWithTestCaseName:(nonnull NSString *)name result:(BOOL)result;

- (nonnull id)initWithTestCaseName:(nonnull NSString *)name result:(BOOL)result assertRecorder:(nonnull id<OCSPAssertRecorder>)recorder;

- (void)run;

- (nonnull NSString *)testCaseName;

@end
