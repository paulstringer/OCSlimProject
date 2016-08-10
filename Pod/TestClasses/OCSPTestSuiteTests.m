#import <XCTest/XCTest.h>
#import "OCSPTestSuiteTestable.h"
#import "OCSPAssertRecorder.h"
#import "OCSPTestDataManager.h"
#import "OCSPLocalizedMessageTable.h"

@interface OCSPTestSuiteTests : XCTestCase <XCTestObservation>
@property (nonatomic, strong) OCSPAssertRecorderSpy *recorderSpy;
@end

@implementation OCSPTestSuiteTests

- (void)setUp {
    
    self.recorderSpy = [OCSPTestSuiteTestable assertRecorder];
    
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

- (void)testNilErrorMessageForFailureResult {
    
    OCSPTestSuite *asserter = [[OCSPTestSuiteTestable alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    [asserter run];
    
    XCTAssertEqualObjects(self.recorderSpy.didRecordFailMessage, @"Unspecified Acceptance Test Failure");
}


- (void)testGivenErrorMessageForFailureResult {
    
    OCSPTestSuite *asserter = [[OCSPTestSuiteTestable alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    asserter.errorMessage = @"ERROR";
    
    [asserter run];
    
    XCTAssertEqualObjects(self.recorderSpy.didRecordFailMessage, @"ERROR");
}

- (void)testInvocationWillRunAssertions {
    
    OCSPTestSuite *asserter = [[OCSPTestSuiteTestable alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    [asserter forwardInvocation:asserter.invocation];
    
    XCTAssertEqual(asserter.invocation.selector, @selector(run));
    
}

- (void)testInvocationRunsAssertion {
    
    OCSPTestSuite *asserter = [[OCSPTestSuiteTestable alloc] initWithTestCaseName:@"AnyTestName" result:NO assertRecorder:self.recorderSpy];
    
    [asserter.invocation invokeWithTarget:asserter];
    
    XCTAssertTrue(self.recorderSpy.didRecordFail);
    
}

- (void)testSelectorMethodNameEqualsTestCaseName {
    
    OCSPTestSuite *asserter = [[OCSPTestSuite alloc] initWithTestCaseName:@"Salami" result:NO];
    
    XCTAssertEqualObjects(NSStringFromSelector(asserter.invocation.selector), @"Salami");

    
}

- (void)testInitWithFailedResult {
    
    OCSPTestSuite *testCase = [[OCSPTestSuiteTestable alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    [testCase run];
    
    XCTAssertTrue(self.recorderSpy.didRecordFail);
}

- (void)testInitWithSuccessResult {
    
    OCSPTestSuite *testCase = [[OCSPTestSuiteTestable alloc] initWithTestCaseName:@"" result:YES assertRecorder:self.recorderSpy];
    
    [testCase run];
    
    XCTAssertTrue(self.recorderSpy.didRecordPass);
}

- (void)testInitWithTestCaseName {
    
    OCSPTestSuite *testCase = [[OCSPTestSuite alloc] initWithTestCaseName:@"TestPage0" result:NO];
    
    XCTAssertTrue([[testCase name] containsString:@"TestPage0"]);
    
    XCTAssertEqualObjects([testCase testCaseName], @"TestPage0");
}

#pragma mark - Test Invocations Tests

- (void)testInvocationsCountEqualsNumberOfResults {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    createDefaultTestReportReaderWithData(data);
    
    NSArray *invocations = [OCSPTestSuiteTestable testInvocations];
    
    XCTAssertEqual(invocations.count, 1);
    
}

- (void)testInvocationsCountEqualsNumberOfResultsWithOtherReportData {

    NSData *data = [OCSPTestDataManager successResultDataByAppendingHyphenatedFilenameModifier:@"3"];
    
    createDefaultTestReportReaderWithData(data);

    NSArray *invocations = [OCSPTestSuiteTestable testInvocations];

    XCTAssertEqual(invocations.count, 3);
}

- (void)testInvocationSelectorNameEqualsPageName {

    NSData *data = [OCSPTestDataManager successResultData];
    
    createDefaultTestReportReaderWithData(data);

    NSInvocation *inv = [[OCSPTestSuiteTestable testInvocations] firstObject];

    XCTAssertEqualObjects(NSStringFromSelector(inv.selector), @"OCSlimProjectExampleSuite_TestPage0");
}

- (void)testForwardInvocationForSuccessReport {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    createDefaultTestReportReaderWithData(data);
    
    [self runInvocation];
    
    XCTAssertTrue(self.recorderSpy.didRecordPass);
    
}

- (void)testForwardInvocationForFailReport {
    
    NSData *data = [OCSPTestDataManager failedResultData];
    
    createDefaultTestReportReaderWithData(data);
    
    [self runInvocation];
    
    XCTAssertTrue(self.recorderSpy.didRecordFail);
    
}

- (void)testGivenErrorMessageForFailureReport{
    
    NSData *data = [OCSPTestDataManager failedResultData];
    
    createDefaultTestReportReaderWithData(data);
    
    [self runInvocation];
    
    XCTAssertEqualObjects(self.recorderSpy.didRecordFailMessage, [OCSPLocalizedMessageTable localizedTestPageMessageWithUnderlyingMessage:@"1 errors"]);
}

#pragma mark - Test Automators

- (void)runAsserterWithResult:(BOOL)result {
    
    OCSPTestSuite *testSuite = [[OCSPTestSuiteTestable alloc] initWithTestCaseName:@"" result:result assertRecorder:self.recorderSpy];
    
    [testSuite run];
    
}

- (void)runInvocation {
    
    NSInvocation *inv = [[OCSPTestSuiteTestable testInvocations] firstObject];
    
    OCSPTestSuiteTestable *testCase = [OCSPTestSuiteTestable testCaseWithInvocation:inv];
    
    [testCase forwardInvocation:inv];
}

@end
