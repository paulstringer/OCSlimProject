#import <XCTest/XCTest.h>
#import "OCSlimProjectJUnitTestAsserter.h"
#import "OCSlimProjectAssertRecorder.h"
#import "OCSlimProjectTestDataManager.h"

@interface OCSlimProjectJUnitTestAsserterTests : XCTestCase <XCTestObservation>
@property (nonatomic, strong) OCSlimProjectAssertRecorderSpy *recorderSpy;
@end

@implementation OCSlimProjectJUnitTestAsserterTests

- (void)setUp {
    
    self.recorderSpy = [[OCSlimProjectAssertRecorderSpy alloc] init];
    
}

- (void)tearDown {
    
    self.recorderSpy = nil;
    
}

- (void)testResultForXMLDataWithZeroFailures {
    
    [self runAsserterWithResult:YES];
    
    XCTAssertFalse(self.recorderSpy.didRecordFail);
    XCTAssertTrue(self.recorderSpy.didRecordPass);
    
}

- (void)testResultForXMLDataWithFailures {

    [self runAsserterWithResult:NO];
    
    XCTAssertFalse(self.recorderSpy.didRecordPass);
    XCTAssertTrue(self.recorderSpy.didRecordFail);
    
}

- (void)testInvocationWillRunAssertions {
    
    OCSlimProjectJUnitTestAsserter *asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    [asserter forwardInvocation:asserter.invocation];
    
    XCTAssertEqual(asserter.invocation.selector, @selector(run));
    
}

- (void)testInvocationRunsAssertion {
    
//    NSData *data = [OCSlimProjectTestDataManager failedResultData];
    
    OCSlimProjectJUnitTestAsserter *asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWithTestCaseName:@"AnyTestName" result:NO assertRecorder:self.recorderSpy];
    
//    OCSlimProjectJUnitTestAsserter *asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWithTestCaseName:@"ArbitraryTestName" data:data assertRecorder:self.recorderSpy];
    
    [asserter.invocation invokeWithTarget:asserter];
    
    XCTAssertTrue(self.recorderSpy.didRecordFail);
    
}

- (void)testSelectorMethodNameEqualsTestCaseName {
    
    OCSlimProjectJUnitTestAsserter *asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWithTestCaseName:@"Salami" result:NO];
    
    XCTAssertEqualObjects(NSStringFromSelector(asserter.invocation.selector), @"Salami");

    
}

- (void)testInitWithFailedResult {
    
    OCSlimProjectJUnitTestAsserter *testCase = [[OCSlimProjectJUnitTestAsserter alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    [testCase run];
    
    XCTAssertTrue(self.recorderSpy.didRecordFail);
}

- (void)testInitWithSuccessResult {
    
    OCSlimProjectJUnitTestAsserter *testCase = [[OCSlimProjectJUnitTestAsserter alloc] initWithTestCaseName:@"" result:YES assertRecorder:self.recorderSpy];
    
    [testCase run];
    
    XCTAssertTrue(self.recorderSpy.didRecordPass);
}

- (void)testInitWithTestCaseName {
    
    OCSlimProjectJUnitTestAsserter *testCase = [[OCSlimProjectJUnitTestAsserter alloc] initWithTestCaseName:@"Salami" result:NO];
    
    XCTAssertTrue([[testCase name] containsString:@"Salami"]);
}

#pragma mark - Test Automators

- (void)runAsserterWithResult:(BOOL)result {
    
    OCSlimProjectJUnitTestAsserter *asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWithTestCaseName:@"" result:result assertRecorder:self.recorderSpy];
    
    [asserter run];
    
}


@end
