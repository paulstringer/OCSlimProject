#import <XCTest/XCTest.h>
#import "OCSPTestCase.h"
#import "OCSPAssertRecorder.h"
#import "OCSPTestDataManager.h"

@interface OCSPTestCaseTests : XCTestCase <XCTestObservation>
@property (nonatomic, strong) OCSPAssertRecorderSpy *recorderSpy;
@end

@implementation OCSPTestCaseTests

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

- (void)testNilErrorMessageForFailureResult {
    
    OCSPTestCase *asserter = [[OCSPTestCase alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
//    asserter.errorMessage = @"ERROR";
    
    [asserter run];
    
    XCTAssertEqualObjects(self.recorderSpy.didRecordFailMessage, @"Unspecified Acceptance Test Failure");
}


- (void)testGivenErrorMessageForFailureResult {
    
    OCSPTestCase *asserter = [[OCSPTestCase alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    asserter.errorMessage = @"ERROR";
    
    [asserter run];
    
    XCTAssertEqualObjects(self.recorderSpy.didRecordFailMessage, @"ERROR");
}

- (void)testInvocationWillRunAssertions {
    
    OCSPTestCase *asserter = [[OCSPTestCase alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    [asserter forwardInvocation:asserter.invocation];
    
    XCTAssertEqual(asserter.invocation.selector, @selector(run));
    
}

- (void)testInvocationRunsAssertion {
    
    OCSPTestCase *asserter = [[OCSPTestCase alloc] initWithTestCaseName:@"AnyTestName" result:NO assertRecorder:self.recorderSpy];
    
    [asserter.invocation invokeWithTarget:asserter];
    
    XCTAssertTrue(self.recorderSpy.didRecordFail);
    
}

- (void)testSelectorMethodNameEqualsTestCaseName {
    
    OCSPTestCase *asserter = [[OCSPTestCase alloc] initWithTestCaseName:@"Salami" result:NO];
    
    XCTAssertEqualObjects(NSStringFromSelector(asserter.invocation.selector), @"Salami");

    
}

- (void)testInitWithFailedResult {
    
    OCSPTestCase *testCase = [[OCSPTestCase alloc] initWithTestCaseName:@"" result:NO assertRecorder:self.recorderSpy];
    
    [testCase run];
    
    XCTAssertTrue(self.recorderSpy.didRecordFail);
}

- (void)testInitWithSuccessResult {
    
    OCSPTestCase *testCase = [[OCSPTestCase alloc] initWithTestCaseName:@"" result:YES assertRecorder:self.recorderSpy];
    
    [testCase run];
    
    XCTAssertTrue(self.recorderSpy.didRecordPass);
}

- (void)testInitWithTestCaseName {
    
    OCSPTestCase *testCase = [[OCSPTestCase alloc] initWithTestCaseName:@"TestPage0" result:NO];
    
    XCTAssertTrue([[testCase name] containsString:@"TestPage0"]);
    
    XCTAssertEqualObjects([testCase testCaseName], @"TestPage0");
}


#pragma mark - Test Automators

- (void)runAsserterWithResult:(BOOL)result {
    
    OCSPTestCase *asserter = [[OCSPTestCase alloc] initWithTestCaseName:@"" result:result assertRecorder:self.recorderSpy];
    
    [asserter run];
    
}


@end
