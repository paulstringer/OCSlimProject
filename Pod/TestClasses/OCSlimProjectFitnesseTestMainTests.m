#import <XCTest/XCTest.h>
#import "OCSlimProjectFitnesseTestsMain.h"

#import "OCSPTestReportReader.h"
#import "OCSPTestDataManager.h"
#import "OCSPTestCase.h"
#import "OCSPJUnitXMLParser.h"

@interface OCSlimProjectFitnesseTestMainTests : XCTestCase

@property (nonatomic, strong) OCSlimProjectFitnesseTestsMain* main;
@end

@implementation OCSlimProjectFitnesseTestMainTests

- (void)setUp {
    
    [super setUp];
    
    self.main = [[OCSlimProjectFitnesseTestsMain alloc] init];

}

- (void)testAcceptanceTestCasesAreJUnitAsserts{
    
    XCTestCase *test = [self acceptanceTestCase];
    
    XCTAssertEqual([test class], [OCSPTestCase class]);
}

- (void)testAcceptanceTestCasesUseTestReportData {

    NSUInteger testCaseCount = [self acceptanceTestSuite].testCaseCount;
    
    NSData *data = [[OCSPTestReportCenter defaultReader] read];
    
    OCSPJUnitXMLParser *parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [parser parse];
    
    XCTAssertEqual(testCaseCount, [parser testCaseCount]);
    
}

- (void)testSuiteWillStartWithBundlesTestSuiteDoesReceiveFitnesseTestSuite {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    [self.main testBundleWillStart:bundle];
    
    XCTestSuite *suite = [XCTestSuite testSuiteWithName:[[bundle bundleURL] lastPathComponent]];
    
    [self.main testSuiteWillStart:suite];
    
    XCTAssertEqual(1, suite.tests.count);
    
    XCTAssertEqual([[OCSlimProjectFitnesseTestsMain testSuite] name], [suite.tests.firstObject name]);
    
}


- (void)testSuiteWillStartWithNonBundleTestSuiteDoesNotReceiveFitnesseTests {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    [self.main testBundleWillStart:bundle];
    
    XCTestSuite *suite = [XCTestSuite testSuiteWithName:@""];
    
    [self.main testSuiteWillStart:suite];
    
    XCTAssertEqual(0, suite.testCaseCount);
    
}

#pragma mark - Individual Test Suite Result Reporting Tests

- (void)testFitnesseTestSuiteNumberOfTests {
    
    (void) [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReport];
    
    XCTestSuite *suite = [self acceptanceTestSuite];
    
    XCTAssertEqual(suite.testCaseCount, 1);
    
}

- (void)testFitnesseTestSuiteNumberOfTestsWithOtherTestReportData {
    
    (void) [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReportWithFilenameModifier:@"3"];
    
    XCTestSuite *suite = [self acceptanceTestSuite];
    
    XCTAssertEqual(suite.testCaseCount, 3);
}

- (void)testFitnesseTestSuiteTestCaseName {
    
    (void) [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReport];
    
    OCSPTestCase *testCase = [[[self acceptanceTestSuite] tests] firstObject];
    
    XCTAssertEqualObjects([testCase testCaseName], @"FakeTestCase0");
}

- (void)testFitnesseTestSuiteTestCaseNames {
    
    (void) [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReportWithFilenameModifier:@"3"];
    
    OCSPTestCase *testCase = [[[self acceptanceTestSuite] tests] lastObject];
    
    XCTAssertEqualObjects([testCase testCaseName], @"FakeTestCase2");
}

- (void)testAcceptanceTestSuiteResultsAccurate {
    
    (void) [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReport];
    
    OCSPTestCase *testCase = [[[self acceptanceTestSuite] tests] lastObject];
    
    XCTAssertTrue([testCase isPass]);
    
}

#pragma mark - Test Helpers


- (void)testStubCreatesTestReportsWithData {
    
    NSData *data = [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReport];
    
    XCTAssertTrue( [[[OCSPTestReportCenter defaultReader] read] isEqualToData:data]);
    
}


+ (NSData* )stubSuccessfulTestReport {
    
    return [self stubSuccessfulTestReportWithFilenameModifier:nil];
}

+ (NSData* )stubSuccessfulTestReportWithFilenameModifier:(NSString*)modifier {
 
    NSData *data = [OCSPTestDataManager successResultDataByAppendingHyphenatedFilenameModifier:modifier];
    
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


- (OCSPTestCase *)acceptanceTestCase {

    XCTestSuite *suite = [self acceptanceTestSuite];

    XCTestCase *test = [[suite tests] firstObject];

    return (OCSPTestCase*) test;

}

@end
