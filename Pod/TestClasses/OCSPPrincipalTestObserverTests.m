#import <XCTest/XCTest.h>
#import "OCSPPrincipalTestObserver.h"

#import "OCSPTestReportReader.h"
#import "OCSPTestDataManager.h"
#import "OCSPTestSuite.h"
#import "OCSPJUnitXMLParser.h"
#import "OCSPLocalizedMessageTable.h"

@interface OCSPPrincipalTestObserverTests : XCTestCase

@property (nonatomic, strong) OCSPPrincipalTestObserver* main;
@end

@implementation OCSPPrincipalTestObserverTests

- (void)setUp {
    
    [super setUp];
    
    self.main = [[OCSPPrincipalTestObserver alloc] init];

    self.main.disableFixForXcodeDisappearingTestCaseByAppendingDummyTest = YES;
}

- (void)testAcceptanceTestCasesAreJUnitAsserts{
    
    XCTestCase *test = [self acceptanceTestCase];
    
    XCTAssertEqual([test class], [OCSPTestSuite class]);
}

- (void)testAcceptanceTestCasesUseTestReportData {

    NSUInteger testCaseCount = [self acceptanceTestSuite].testCaseCount;
    
    NSData *data = [[OCSPTestReportCenter defaultReader] read];
    
    OCSPJUnitXMLParser *parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [parser parse];
    
    XCTAssertEqual(testCaseCount, [parser testCaseCount]);
    
}

- (void)testSuiteWillStartWithBundlesTestSuiteContainsAcceptanceTestSuite {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    [self.main testBundleWillStart:bundle];
    
    XCTestSuite *suite = [XCTestSuite testSuiteWithName:[[bundle bundleURL] lastPathComponent]];
    
    [self.main testSuiteWillStart:suite];
    
    XCTAssertEqual(1, suite.tests.count);
    
    XCTAssertEqualObjects([[OCSPPrincipalTestObserver testSuite] name], [suite.tests.firstObject name]);
    
}


- (void)testSuiteWillStartWithNonBundleTestSuiteDoesNotReceiveFitnesseTests {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    [self.main testBundleWillStart:bundle];
    
    XCTestSuite *suite = [XCTestSuite testSuiteWithName:@""];
    
    [self.main testSuiteWillStart:suite];
    
    XCTAssertEqual(0, suite.testCaseCount);
    
}

#pragma mark - Individual Test Suite Result Reporting Tests

- (void)testAcceptanceTestSuiteNumberOfTests {
    
    (void) [[self class] stubSuccessfulTestReport];
    
    XCTestSuite *suite = [self acceptanceTestSuite];
    
    XCTAssertEqual(suite.testCaseCount, 1);
    
}

- (void)testAcceptanceTestSuiteNumberOfTestsWithOtherTestReportData {
    
    (void) [[self class] stubSuccessfulTestReportWithFilenameModifier:@"3"];
    
    XCTestSuite *suite = [self acceptanceTestSuite];
    
    XCTAssertEqual(suite.testCaseCount, 3);
}


- (void)testAcceptanceTestSuiteNameEqualsSuiteName {
    
    NSData *data = [[self class] stubSuccessfulTestReport];
    
    XCTestSuite *suite = [self acceptanceTestSuite];
    
    OCSPJUnitXMLParser* parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [parser parse];
    
    XCTAssertEqualObjects(suite.name, [parser testSuiteName]);
    
}

- (void)testAcceptanceTestSuiteTestCaseName {
    
    (void) [[self class] stubSuccessfulTestReport];
    
    OCSPTestSuite *testCase = [[[self acceptanceTestSuite] tests] firstObject];
    
    XCTAssertEqualObjects([testCase testCaseName], @"OCSlimProjectExampleSuite.TestPage0");
}

- (void)testAcceptanceTestSuiteTestCaseNames {
    
    (void) [[self class] stubSuccessfulTestReportWithFilenameModifier:@"3"];
    
    OCSPTestSuite *testCase = [[[self acceptanceTestSuite] tests] lastObject];
    
    XCTAssertEqualObjects([testCase testCaseName], @"OCSlimProjectExampleSuite.TestPage2");
}

- (void)testAcceptanceTestCaseNameNameDoesNotRemoveTestSuiteComponent {
    
    (void) [[self class] stubSuccessfulTestReport];
    
    OCSPTestSuite *testCase = [[[self acceptanceTestSuite] tests] firstObject];
    
    XCTAssertTrue([[testCase name] containsString:@"."]);
}


- (void)testAcceptanceTestSuiteResultsAccurate {
    
    (void) [[self class] stubSuccessfulTestReport];
    
    OCSPTestSuite *testCase = [[[self acceptanceTestSuite] tests] lastObject];
    
    XCTAssertTrue([testCase isPass]);
    
    
    (void) [[self class] stubFailedTestReport];
    
    testCase = [[[self acceptanceTestSuite] tests] lastObject];
    
    XCTAssertFalse([testCase isPass]);
    
}

- (void)testFailingAcceptanceTestCasesNonNilErrorMessage {
    
    (void) [[self class] stubFailedTestReport];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    XCTAssertNotNil(testCase.errorMessage);
}

- (void)testFailingAcceptanceTestCaseErrorMessage {
    
    (void) [[self class] stubFailedTestReport];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];

    XCTAssertEqualObjects([OCSPLocalizedMessageTable localizedTestPageMessageWithUnderlyingMessage:@"1 errors"], testCase.errorMessage);    
}

#pragma mark - Report Empty Test Suites as Failing Test

- (void)testReportDataWithZeroTestsReturnsSingleTest {
    
    (void) [[self class]  stubSuccessfulTestReportWithFilenameModifier:@"Empty"];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    XCTAssertNotNil(testCase);
}


- (void)testReportDataWithZeroTestsReturnsFail {
    
    (void) [[self class]  stubSuccessfulTestReportWithFilenameModifier:@"Empty"];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    XCTAssertFalse([testCase isPass]);
}

- (void)testReportDataWithZeroTestsReturnsInformativeTestName {
    
    (void) [[self class]  stubSuccessfulTestReportWithFilenameModifier:@"Empty"];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    XCTAssertEqualObjects(@"EmptyPageTestCaseCountGreaterThanZero", [testCase testCaseName]);
}

- (void)testReportDataWithZeroTestsReturnsInformativeError {
    
    (void) [[self class]  stubSuccessfulTestReportWithFilenameModifier:@"Empty"];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    NSString *errorMsg = [OCSPLocalizedMessageTable localizedEmptyTestSuiteMessageWithSuiteName:@"EmptyPage"];
    
    NSString *message = [NSString stringWithFormat:errorMsg, @"EmptyPage", nil];
    
    XCTAssertEqualObjects(message, [testCase errorMessage]);
}

- (void)testReportDataNotFoundReturnsFail {
    
    (void) [[self class]  stubFailedTestReportWithFilenameModifier:@"NotFound"];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    XCTAssertFalse([testCase isPass]);
}

- (void)testReportDataNotFoundReturnsInformativeTestName {
    
    (void) [[self class]  stubFailedTestReportWithFilenameModifier:@"NotFound"];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    XCTAssertEqualObjects([testCase testCaseName], @"TestSuiteReportXMLParsingSucceeded");
}

- (void)testReportDataNotFoundTestsReturnsInformativeError {
    
    (void) [[self class]  stubFailedTestReportWithFilenameModifier:@"NotFound"];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    NSString *message = [OCSPLocalizedMessageTable localizedTestSuiteParsingErrorMessage];
    
    XCTAssertEqualObjects(message, [testCase errorMessage]);
}

- (void)testReportDataNotFoundNumberOfTestsEqualsOne {
    
    (void) [[self class]  stubFailedTestReportWithFilenameModifier:@"NotFound"];
    
    XCTAssertEqual([[self acceptanceTestSuite] testCaseCount], 1);
    
}

- (void)testReportDataNilNumberOfTestsEqualsOne {
    
    createDefaultTestReportReaderWithData(nil);
    
    XCTAssertEqual([[self acceptanceTestSuite] testCaseCount], 1);
    
}

- (void)testReportDataNilReturnsInformativeTestName {
    
    createDefaultTestReportReaderWithData(nil);
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];

    XCTAssertEqualObjects([testCase testCaseName], @"TestSuiteReportDataExists");
}

- (void)testReportDataNilReturnsInformativeErrorMessage {
    
    createDefaultTestReportReaderWithData(nil);
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    NSString *errorMessage = [OCSPLocalizedMessageTable localizedTestSuiteReportDataNotFound];
    
    XCTAssertEqualObjects([testCase errorMessage], errorMessage);
}


- (void)testReportSuiteWithErrorsReturnsFailingTestCase {
    
    (void) [[self class]  stubErrorTestReport];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    XCTAssertFalse([testCase isPass]);
    
}

- (void)testReportSuiteWithErrorsReturnsInformativeName {
    
    (void) [[self class]  stubErrorTestReport];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];
    
    XCTAssertEqualObjects([testCase testCaseName], @"OCSlimProjectExampleSuiteErrorCountEqualsZero");
    
}

- (void)testReportSuiteWithErrorsReturnsInformativeErrorMessage {
    
    (void) [[self class]  stubErrorTestReport];
    
    OCSPTestSuite *testCase = [self acceptanceTestCase];

    NSString *errorMessage = [OCSPLocalizedMessageTable localizedTestSuiteErrorsOccurredMessageWithCount:1];

    XCTAssertEqualObjects([testCase errorMessage], errorMessage);
    
}

- (void)testReportSuiteWithErrorsCausedByExceptionsDoesNotAddFailingReportTest {
    
    (void) [[self class]  stubFailedTestReportWithFilenameModifier:@"Exceptions"];
    
    XCTestSuite *suite = [self acceptanceTestSuite];
    
    XCTAssertEqual(suite.testCaseCount, 1);
    
}


#pragma mark - Fix disappearing last test case issue. Xcode hides the last test result. To prevent this a last test is added after adding tests from the test report file. That fake test is then the one to disappear.

- (void)testAcceptanceTestSuiteAddsExtraTest {
    
    (void) [[self class] stubFailedTestReport];
    
    self.main.disableFixForXcodeDisappearingTestCaseByAppendingDummyTest = NO;
    
    XCTestSuite *suite = [self acceptanceTestSuite];
    
    XCTAssertEqual(suite.testCaseCount, 2);
    
    OCSPTestSuite *testCase = (OCSPTestSuite*) suite.tests.lastObject;
    
    XCTAssertTrue([testCase isPass]);
    
    XCTAssertEqualObjects([testCase testCaseName], @"OCSlimProjectExampleSuite.TearDown");
    
}

#pragma mark - Test Helpers

- (void)testStubCreatesTestReportsWithData {
    
    NSData *data = [[self class] stubSuccessfulTestReport];
    
    XCTAssertTrue( [[[OCSPTestReportCenter defaultReader] read] isEqualToData:data]);
    
}


+ (NSData* )stubSuccessfulTestReport {
    
    return [self stubSuccessfulTestReportWithFilenameModifier:nil];
}

+ (NSData* )stubFailedTestReport {
    
    return [self stubFailedTestReportWithFilenameModifier:nil];
    
}

+ (NSData* )stubErrorTestReport {
    
    NSData *data = [OCSPTestDataManager errorResultData];
    
    return [self stubTestReportWithData:data];
    
}

+ (NSData* )stubSuccessfulTestReportWithFilenameModifier:(NSString*)modifier {
 
    NSData *data = [OCSPTestDataManager successResultDataByAppendingHyphenatedFilenameModifier:modifier];
    
    return [self stubTestReportWithData:data];

}

+ (NSData* )stubFailedTestReportWithFilenameModifier:(NSString*)modifier {
    
    NSData *data = [OCSPTestDataManager failedResultDataByAppendingHyphenatedFilenameModifier:modifier];
    
    return [self stubTestReportWithData:data];
    
}

+ (NSData *)stubTestReportWithData:(NSData*)data {
    
    NSParameterAssert(data);
    
    createDefaultTestReportReaderWithData(data);
    
    return data;
    
}

#pragma mark - Test Suite Extraction

- (XCTestSuite *)hostTestSuite {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    [self.main testBundleWillStart:bundle];
    
    XCTestSuite *hostTestSuite = [XCTestSuite testSuiteWithName:[[bundle bundleURL] lastPathComponent]];
    
    [self.main testSuiteWillStart:hostTestSuite];
    
    return hostTestSuite;
    
}

- (XCTestSuite *)acceptanceTestSuite {
    
    XCTestSuite *hostTestSuite = [self hostTestSuite];
    
    return (XCTestSuite*) [[hostTestSuite tests] firstObject];
    
}


- (OCSPTestSuite *)acceptanceTestCase {

    XCTestSuite *suite = [self acceptanceTestSuite];

    XCTestCase *test = [[suite tests] firstObject];

    return (OCSPTestSuite*) test;

}

@end
