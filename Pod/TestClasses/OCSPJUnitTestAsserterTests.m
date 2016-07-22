#import <XCTest/XCTest.h>
#import "OCSPJUnitTestAsserter.h"
#import "OCSPAssertRecorder.h"
#import "OCSlimProjectTestDataManager.h"

@interface OCSPJUnitTestAsserterTests : XCTestCase <XCTestObservation>
@property (nonatomic, strong) OCSPAssertRecorderSpy *recorderSpy;
@end

@implementation OCSPJUnitTestAsserterTests

- (void)setUp {
    
    self.recorderSpy = [[OCSPAssertRecorderSpy alloc] init];
    
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
    
    OCSPJUnitTestAsserter *asserter = [[OCSPJUnitTestAsserter alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    [asserter forwardInvocation:asserter.invocation];
    
    XCTAssertEqual(asserter.invocation.selector, @selector(run));
    
}

- (void)testInvocationRunsAssertion {
    
//    NSData *data = [OCSlimProjectTestDataManager failedResultData];
    
    OCSPJUnitTestAsserter *asserter = [[OCSPJUnitTestAsserter alloc] initWithTestCaseName:@"AnyTestName" result:NO assertRecorder:self.recorderSpy];
    
//    OCSlimProjectJUnitTestAsserter *asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWithTestCaseName:@"ArbitraryTestName" data:data assertRecorder:self.recorderSpy];
    
    [asserter.invocation invokeWithTarget:asserter];
    
    XCTAssertTrue(self.recorderSpy.didRecordFail);
    
}

- (void)testSelectorMethodNameEqualsTestCaseName {
    
    OCSPJUnitTestAsserter *asserter = [[OCSPJUnitTestAsserter alloc] initWithTestCaseName:@"Salami" result:NO];
    
    XCTAssertEqualObjects(NSStringFromSelector(asserter.invocation.selector), @"Salami");

    
}

- (void)testInitWithFailedResult {
    
    OCSPJUnitTestAsserter *testCase = [[OCSPJUnitTestAsserter alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    [testCase run];
    
    XCTAssertTrue(self.recorderSpy.didRecordFail);
}

- (void)testInitWithSuccessResult {
    
    OCSPJUnitTestAsserter *testCase = [[OCSPJUnitTestAsserter alloc] initWithTestCaseName:@"" result:YES assertRecorder:self.recorderSpy];
    
    [testCase run];
    
    XCTAssertTrue(self.recorderSpy.didRecordPass);
}

- (void)testInitWithTestCaseName {
    
    OCSPJUnitTestAsserter *testCase = [[OCSPJUnitTestAsserter alloc] initWithTestCaseName:@"Salami" result:NO];
    
    XCTAssertTrue([[testCase name] containsString:@"Salami"]);
}

#pragma mark - Test Automators

- (void)runAsserterWithResult:(BOOL)result {
    
    OCSPJUnitTestAsserter *asserter = [[OCSPJUnitTestAsserter alloc] initWithTestCaseName:@"" result:result assertRecorder:self.recorderSpy];
    
    [asserter run];
    
}


@end
