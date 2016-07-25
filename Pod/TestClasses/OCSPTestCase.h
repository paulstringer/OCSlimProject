#import <XCTest/XCTest.h>

@protocol OCSPAssertRecorder;

@interface OCSPTestCase : XCTestCase

@property (nonatomic, readonly, getter=isPass) BOOL testResult;

@property (nonatomic, strong) NSString * errorMessage;

- (nonnull id)initWithTestCaseName:(nonnull NSString *)name result:(BOOL)result;

- (nonnull id)initWithTestCaseName:(nonnull NSString *)name result:(BOOL)result assertRecorder:(nonnull id<OCSPAssertRecorder>)recorder;

- (nonnull NSString *)testCaseName;

- (void)run;

@end
