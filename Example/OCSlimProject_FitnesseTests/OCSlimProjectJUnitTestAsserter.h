#import <XCTest/XCTest.h>

@protocol OCSlimProjectAssertRecorder;

@interface OCSlimProjectJUnitTestAsserter : XCTestCase

@property (nonatomic, readonly, nonnull) NSData *data;

- (nonnull id)initWitData:(nonnull NSData *)data;

- (nonnull id)initWitData:(nonnull NSData *)data assertRecorder:(nonnull id<OCSlimProjectAssertRecorder>)recorder;

- (void)run;

@end
