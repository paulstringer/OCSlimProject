#import <XCTest/XCTest.h>
#import "OCSlimProjectJUnitTestAsserter.h"
#import "OCSlimProjectAssertRecorder.h"
#import "OCSlimProjectTestDataManager.h"

@interface OCSlimProjectJUnitTestAsserterTests : XCTestCase <XCTestObservation>
@property (nonatomic, strong) OCSlimProjectJUnitTestAsserter *asserter;
@property (nonatomic, strong) OCSlimProjectAssertRecorderSpy *recorderSpy;
@end

@implementation OCSlimProjectJUnitTestAsserterTests

- (void)setUp {
    
    self.recorderSpy = [[OCSlimProjectAssertRecorderSpy alloc] init];
    
}

- (void)tearDown {
    
}

- (void)testResultForXMLDataWithZeroFailures {
    
    NSData *data = [OCSlimProjectTestDataManager successResultData];
    
    [self runAsserterWithData:data];
    
    XCTAssertFalse(self.recorderSpy.didRecordFail);
    XCTAssertTrue(self.recorderSpy.didRecordPass);
    
}

- (void)testResultForXMLDataWithFailures {
    
    NSData *data = [OCSlimProjectTestDataManager failedResultData];
    
    [self runAsserterWithData:data];
    
    XCTAssertFalse(self.recorderSpy.didRecordPass);
    XCTAssertTrue(self.recorderSpy.didRecordFail);
    
}

- (void)testInvocationWillRunAssertions {
    
    OCSlimProjectJUnitTestAsserter *asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWitData:[NSData data] assertRecorder:self.recorderSpy];
    
    [asserter forwardInvocation:asserter.invocation];
    
    XCTAssertEqual(asserter.invocation.selector, @selector(run));
    
}

- (void)testInvocationRunsAssertion {
    
    NSData *data = [OCSlimProjectTestDataManager failedResultData];
    
    OCSlimProjectJUnitTestAsserter *asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWithName:@"ArbitraryTestName" data:data assertRecorder:self.recorderSpy];
    
    [asserter.invocation invokeWithTarget:asserter];
    
    XCTAssertTrue(self.recorderSpy.didRecordFail);
    
}

- (void)testSelectorMethodNameEqualsTestName {
    
    OCSlimProjectJUnitTestAsserter *asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWithName:@"Salami" data:[NSData new] assertRecorder:self.recorderSpy];
    
    XCTAssertEqualObjects(NSStringFromSelector(asserter.invocation.selector), @"Salami");

    
}

- (void)runAsserterWithData:(NSData*)data {
    
    self.asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWitData:data assertRecorder:self.recorderSpy];
    
    [self.asserter run];
    
}

@end
