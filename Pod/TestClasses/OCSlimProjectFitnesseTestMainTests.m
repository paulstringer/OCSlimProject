#import <XCTest/XCTest.h>
#import "OCSlimProjectFitnesseTestsMain.h"

#import "OCSlimFitnesseTestReportReader.h"
#import "OCSlimProjectTestDataManager.h"
#import "OCSPJUnitTestAsserter.h"
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
    
    XCTAssertEqual([test class], [OCSPJUnitTestAsserter class]);
}

- (void)testAcceptanceTestCasesUseTestReportData {

    NSUInteger testCaseCount = [self acceptanceTestSuite].testCaseCount;
    
    NSData *data = [[OCSlimFitnesseTestReportCenter defaultReader] read];
    
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

#pragma mark - Individual Test Suite Result Reporting

- (void)testDataManagerCreatingTestReportsWithData {
    
    NSData *data = [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReport];
    
    XCTAssertTrue( [[[OCSlimFitnesseTestReportCenter defaultReader] read] isEqualToData:data]);
    
}

- (void)testFitnesseTestSuiteNumberOfTests {
    
    (void) [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReport];
    
    XCTestSuite *suite = [self acceptanceTestSuite];
    
    XCTAssertEqual(suite.testCaseCount, 1);
    
}

- (void)testFitnesseTestSuiteNumberOfTestsWithMultipleTestCaseData {
    
    (void) [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReportWithFilenameModifier:@"3"];
    
    XCTestSuite *suite = [self acceptanceTestSuite];
    
    XCTAssertEqual(suite.testCaseCount, 3);
}

- (void)testFitnesseTestSuiteTestCaseName {
    
    OCSPJUnitTestAsserter *testCase = [self acceptanceTestCase];
    
    XCTAssertEqualObjects([testCase testCaseName], @"FakeTestCase0");
}

- (void)testFitnesseTestSuiteTestCaseNames {
    
    (void) [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReportWithFilenameModifier:@"3"];
    
    OCSPJUnitTestAsserter *testCase = [[[self acceptanceTestSuite] tests] lastObject];
    
    XCTAssertEqualObjects([testCase testCaseName], @"FakeTestCase2");
}

#pragma mark - Test Helpers

+ (NSData* )stubSuccessfulTestReport {
    
    return [self stubSuccessfulTestReportWithFilenameModifier:nil];
}

+ (NSData* )stubSuccessfulTestReportWithFilenameModifier:(NSString*)modifier {
 
    NSData *data = [OCSlimProjectTestDataManager successResultDataByAppendingHyphenatedFilenameModifier:modifier];
    
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


- (OCSPJUnitTestAsserter *)acceptanceTestCase {

    XCTestSuite *suite = [self acceptanceTestSuite];

    XCTestCase *test = [[suite tests] firstObject];

    return (OCSPJUnitTestAsserter*) test;

}

@end
