#import <XCTest/XCTest.h>

@protocol OCSlimProjectAssertRecorder;

@interface OCSlimProjectJUnitTestAsserter : XCTestCase

- (nonnull id)initWithTestCaseName:(nonnull NSString *)name result:(BOOL)result;

- (nonnull id)initWithTestCaseName:(nonnull NSString *)name result:(BOOL)result assertRecorder:(nonnull id<OCSlimProjectAssertRecorder>)recorder;

- (void)run;

- (nonnull NSString *)testCaseName;

@end
