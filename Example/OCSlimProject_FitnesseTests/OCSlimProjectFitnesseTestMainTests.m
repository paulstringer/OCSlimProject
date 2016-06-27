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

- (void)testInitialisesAndRunsFitnesseTestSuite {

    XCTAssertNotNil([[OCSlimProjectFitnesseTestsMain testRun] startDate]);
    
    XCTAssertNotEqual([[OCSlimProjectFitnesseTestsMain testRun] executionCount], 0);
    
}

- (void)tesFitnesseTestIsJunitAssert{
    
    XCTestCase *test = [self fitnesseTestCase];
    
    XCTAssertEqual([test class], [OCSlimProjectJUnitTestAsserter class]);
}

- (void)testFitnesseTestReadsDefaultReaderTestReportData {

    NSData *data = [[OCSlimFitnesseTestReportCenter defaultReader] read];
    
    OCSlimProjectJUnitTestAsserter *test = (OCSlimProjectJUnitTestAsserter *)[self fitnesseTestCase];
    
    XCTAssertTrue([test.data isEqualToData:data]);
    
}

#pragma mark - Test Helpers

- (XCTestCase *)fitnesseTestCase {
    
    XCTestSuite *suite = (XCTestSuite*)[[OCSlimProjectFitnesseTestsMain testRun] test];
    
    XCTestCase *test = [[suite tests] firstObject];
    
    return test;
    
}

@end
