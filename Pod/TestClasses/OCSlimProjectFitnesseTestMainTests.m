#import <XCTest/XCTest.h>
#import "OCSlimProjectFitnesseTestsMain.h"
#import "OCSlimProjectJUnitTestAsserter.h"
#import "OCSlimFitnesseTestReportReader.h"
#import "OCSlimProjectTestDataManager.h"

@interface OCSlimProjectFitnesseTestMainTests : XCTestCase

@property (nonatomic, strong) OCSlimProjectFitnesseTestsMain* main;
@end

@implementation OCSlimProjectFitnesseTestMainTests

- (void)setUp {
    
    [super setUp];
    
    self.main = [[OCSlimProjectFitnesseTestsMain alloc] init];

}

- (void)testFitnesseTestIsJunitAssert{
    
    XCTestCase *test = [self fitnesseTestCase];
    
    XCTAssertEqual([test class], [OCSlimProjectJUnitTestAsserter class]);
}

- (void)testFitnesseTestReadsDefaultReaderTestReportData {

    NSData *data = [[OCSlimFitnesseTestReportCenter defaultReader] read];
    
    OCSlimProjectJUnitTestAsserter *test = (OCSlimProjectJUnitTestAsserter *)[self fitnesseTestCase];
    
    XCTAssertTrue([test.data isEqualToData:data]);
    
}

- (void)testSuiteWillStartWithBundlesTestSuiteDoesReceiveFitnesseTests {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    [self.main testBundleWillStart:bundle];
    
    XCTestSuite *suite = [XCTestSuite testSuiteWithName:[[bundle bundleURL] lastPathComponent]];
    
    [self.main testSuiteWillStart:suite];
    
    XCTAssertEqual(1, suite.testCaseCount);
    
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

- (void)testDataManagerCreatingTestReportsWithDataWorks {
    
    NSData *data = [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReport];
    
    XCTAssertTrue( [[[OCSlimFitnesseTestReportCenter defaultReader] read] isEqualToData:data]);
    
}

- (void)testFitnesseTestSuiteNumberOfTests {
    
    (void) [OCSlimProjectFitnesseTestMainTests stubSuccessfulTestReportWithFilenameModifier:@"3"];
    
    XCTestSuite *suite = [self fitnesseTestSuite];
    
    XCTAssertEqual(suite.testCaseCount, 3);
    
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

- (XCTestSuite *)fitnesseTestSuite {
    
    XCTestSuite *hostTestSuite = [self hostTestSuite];
    
    return (XCTestSuite*) [[hostTestSuite tests] firstObject];
    
}


- (XCTestCase *)fitnesseTestCase {

    XCTestSuite *suite = [self fitnesseTestSuite];

    XCTestCase *test = [[suite tests] firstObject];

    return test;

}

@end
