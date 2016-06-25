#import <XCTest/XCTest.h>
#import "OCSlimProjectFitnesseTestsMain.h"
#import "OCSlimProject_FitnesseTests-Swift.h"
#import "OCSlimProjectJUnitTestAsserter.h"

@interface OCSlimProjectFitnesseTestMainTests : XCTestCase

@property (nonatomic, strong) OCSlimProjectFitnesseTestsMain* main;
@property (nonatomic, strong) XCTestSuite *fitnesseTestSuiteContainer;
@property (nonatomic, strong) XCTestSuite *fitnesseTestSuite;
@end

@implementation OCSlimProjectFitnesseTestMainTests

- (void)setUp {
    
    [super setUp];
    
    self.main = [[OCSlimProjectFitnesseTestsMain alloc] init];
    
    self.fitnesseTestSuiteContainer = [OCSlimProjectFitnesseTestMainTests wrappedFitnesseTestSuite];
    
    self.fitnesseTestSuite = [OCSlimProjectFitnesseTestMainTests unwrappedFitnesseTestSuite:self.fitnesseTestSuiteContainer];
}

- (void)testSuiteWillStartAddsFitnesseTestSuiteResult {
    
    NSString *path = [[[OCSlimProjectTestDataManager alloc] init] failedResultPath];
    [[self class] createFitnesseTestReportFileWithDataAtFilePath:path];
    
    [self.main testSuiteWillStart:self.fitnesseTestSuiteContainer];
    
    XCTAssertEqual(self.fitnesseTestSuite.testCaseCount, 1);
}

- (void)testSuiteWillStartAddsFitnesseTestSuiteResultAsJunitAssert{
    
    NSString *path = [[[OCSlimProjectTestDataManager alloc] init] failedResultPath];
    
    [[self class] createFitnesseTestReportFileWithDataAtFilePath:path];
    
    [self.main testSuiteWillStart:self.fitnesseTestSuiteContainer];
    
    XCTestCase *test = self.fitnesseTestSuite.tests.firstObject;
    
    XCTAssertEqual([test class], [OCSlimProjectJUnitTestAsserter class]);
}

- (void)testSuiteCreatesTestWithTestReportData {
    
    NSString *path = [[[OCSlimProjectTestDataManager alloc] init] failedResultPath];
    
    NSData * data = [[self class] createFitnesseTestReportFileWithDataAtFilePath:path];
    
    [self.main testSuiteWillStart:self.fitnesseTestSuiteContainer];
    
    OCSlimProjectJUnitTestAsserter *test = self.fitnesseTestSuite.tests.firstObject;
    
    XCTAssertEqual(test.data, data);
    
}

- (void)tearDown {
    
    [super tearDown];
    
    [self.main testBundleDidFinish:[[NSBundle alloc] init]];
}


#pragma mark - Test Helpers

+ (XCTestSuite *)wrappedFitnesseTestSuite {
    
    XCTestSuite *parentSuite = [XCTestSuite defaultTestSuite];
    
    XCTestSuite *suite = [XCTestSuite testSuiteWithName:[OCSlimProjectFitnesseTest testSuiteName]];
    
    [parentSuite addTest:suite];
    
    return parentSuite;
}

+ (XCTestSuite*)unwrappedFitnesseTestSuite:(XCTestSuite*)parentSuite {
    
    for (XCTestSuite *suite in [parentSuite tests]) {
        
        if ([suite.name isEqualToString:[OCSlimProjectFitnesseTest testSuiteName]]) {
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
