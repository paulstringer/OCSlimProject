#import <XCTest/XCTest.h>
#import "OCSlimProjectFitnesseTestsMain.h"
#import "OCSlimProject_FitnesseTests-Swift.h"
#import "OCSlimProjectJUnitTestAsserter.h"

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

- (void)testSuiteWillStartWithBundeTestSuiteNameReceivesFitnesseTests {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    [self.main testBundleWillStart:bundle];
    
    XCTestSuite *suite = [XCTestSuite testSuiteWithName:[[bundle bundleURL] lastPathComponent]];
    
    [self.main testSuiteWillStart:suite];
    
    XCTAssertEqual(1, suite.testCaseCount);
    
}


- (void)testSuiteWillStartWithNonBundleTestSuiteNameDoesNotAddFitnesseTests {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    [self.main testBundleWillStart:bundle];
    
    XCTestSuite *suite = [XCTestSuite testSuiteWithName:@""];
    
    [self.main testSuiteWillStart:suite];
    
    XCTAssertEqual(0, suite.testCaseCount);
    
}

#pragma mark - Test Helpers

- (XCTestCase *)fitnesseTestCase {
    
    XCTestSuite *suite = [OCSlimProjectFitnesseTestsMain testSuite];
    
    XCTestCase *test = [[suite tests] firstObject];
    
    return test;
    
}

@end
