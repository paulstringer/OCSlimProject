#import <XCTest/XCTest.h>
#import "OCSlimProjectFitnesseTestsMain.h"
#import "OCSlimProject_FitnesseTests-Swift.h"
#import "OCSlimProjectJUnitTestAsserter.h"

@interface OCSlimProjectFitnesseTestMainTests : XCTestCase

@property (nonatomic, strong) OCSlimProjectFitnesseTestsMain* main;
@property (nonatomic, strong) XCTestSuite *allTestsSuite;
@property (nonatomic, strong) XCTestSuite *fitnesseTestSuite;
@end

@implementation OCSlimProjectFitnesseTestMainTests

- (void)setUp {
    
    [super setUp];
    
    self.main = [[OCSlimProjectFitnesseTestsMain alloc] init];

    [self createAllTestsSuite];

}

- (void)testSuiteWillStartAddsFitnesseTestSuiteResult {
    
    NSString *path = [[[OCSlimProjectTestDataManager alloc] init] failedResultPath];
    
    [[self class] createFitnesseTestReportFileWithDataAtFilePath:path];
    
    [self.main testSuiteWillStart:self.allTestsSuite];
    
    XCTAssertEqual(self.fitnesseTestSuite.testCaseCount, 1);
}

- (void)testSuiteWillStartAddsFitnesseTestSuiteResultAsJunitAssert{
    
    NSString *path = [[[OCSlimProjectTestDataManager alloc] init] failedResultPath];
    
    [[self class] createFitnesseTestReportFileWithDataAtFilePath:path];
    
    [self.main testSuiteWillStart:self.allTestsSuite];
    
    XCTestCase *test = self.fitnesseTestSuite.tests.firstObject;
    
    XCTAssertEqual([test class], [OCSlimProjectJUnitTestAsserter class]);
}

- (void)testSuiteCreatesTestWithTestReportData {
    
    NSString *path = [[[OCSlimProjectTestDataManager alloc] init] failedResultPath];
    
    NSData * data = [[self class] createFitnesseTestReportFileWithDataAtFilePath:path];
    
    [self.main testSuiteWillStart:self.allTestsSuite];
    
    OCSlimProjectJUnitTestAsserter *test = self.fitnesseTestSuite.tests.firstObject;
    
    XCTAssertEqual(test.data, data);
    
}

- (void)tearDown {
    
    [super tearDown];
    
    [self.main testBundleDidFinish:[[NSBundle alloc] init]];
}


#pragma mark - Test Helpers

- (void)createAllTestsSuite {
    
    self.allTestsSuite = [OCSlimProjectFitnesseTestMainTests allTestsSuiteWithFitnesseTestSuite];
    
    self.fitnesseTestSuite = [OCSlimProjectFitnesseTestMainTests fitnesseTestSuiteInTestsSuite:self.allTestsSuite];
    
}
+ (XCTestSuite *)allTestsSuiteWithFitnesseTestSuite {
    
    XCTestSuite *allTestsSuite = [XCTestSuite defaultTestSuite];
    
    XCTestSuite *suite = [XCTestSuite testSuiteWithName:[OCSlimProjectFitnesseTestSuite suiteName]];
    
    [allTestsSuite addTest:suite];
    
    return allTestsSuite;
}

+ (XCTestSuite*)fitnesseTestSuiteInTestsSuite:(XCTestSuite*)allTestsSuite {
    
    for (XCTestSuite *suite in [allTestsSuite tests]) {
        
        if ([suite.name isEqualToString:[OCSlimProjectFitnesseTestSuite suiteName]]) {
            return suite;
        }
    }
    
    return nil;
}

+ (NSData *)createFitnesseTestReportFileWithDataAtFilePath:(NSString *)file {

    NSData *contents = [NSData dataWithContentsOfFile:file];
    
    OCSlimFitnesseTestReportReaderStub *reader = [[OCSlimFitnesseTestReportReaderStub alloc] initWithData:contents];
    
    [OCSlimFitnesseTestReportCenter setDefaultReader:reader];
    
    return contents;
}

@end
