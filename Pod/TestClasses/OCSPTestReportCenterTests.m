#import <XCTest/XCTest.h>
#import "OCSPTestReportCenter.h"

#import "OCSPTestReportReader.h"
#import "OCSPJUnitXMLParser.h"

#import "OCSPTestDataManager.h"
#import "OCSPTestCaseReport.h"
#import "OCSPLocalizedMessageTable.h"


@interface OCSPTestReportCenterTests : XCTestCase

@property (nonatomic, strong) OCSPTestReportCenter *center;

@end

@implementation OCSPTestReportCenterTests


- (void)setUp {

    self.center = [[OCSPTestReportCenter alloc] init];
    
    self.center.xcodeFixDisappearingTestCaseByAppendingDummyTest = YES;
    
    self.center.xctoolCompatibilityDisabled = YES;
    
}


- (void)testTestCasesReportsAreUsingDefaultTestReportData {
    
    NSUInteger count = self.center.testCaseReports.count;
    
    NSData *data = [[OCSPTestReportReader defaultReader] read];
    
    OCSPJUnitXMLParser *parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [parser parse];
    
    XCTAssertEqual(count, [parser testCaseCount]);
    
}

- (void)testSuiteName {
    
    (void) [[self class] stubSuccessfulTestReport];
    
    XCTAssertEqualObjects([self.center testSuiteName], @"OCSlimProjectExampleSuite");
    
}

- (void)testTestCaseReportName {
    
    (void) [[self class] stubSuccessfulTestReport];
    
    OCSPTestCaseReport *report = [self acceptanceTestCaseReport];
    
    XCTAssertEqualObjects(report.name, @"OCSlimProjectExampleSuite.TestPage0");
}


- (void)testTestCaseReportNameReplacesDotsXCToolCompatibility {
    
    (void) [[self class] stubSuccessfulTestReport];
    
    self.center.xctoolCompatibilityDisabled = NO;
    
    OCSPTestCaseReport *report = [self acceptanceTestCaseReport];
    
    XCTAssertEqualObjects(report.name, @"OCSlimProjectExampleSuite_TestPage0");
}


- (void)testTestReportResultsSuccess {
    
    (void) [[self class] stubSuccessfulTestReport];
    
    OCSPTestCaseReport *report = [self acceptanceTestCaseReport];
    
    XCTAssertTrue(report.passed);
    
}

- (void)testTestReportResultsFail {
    
    (void) [[self class] stubFailedTestReport];
    
    OCSPTestCaseReport *report = [self acceptanceTestCaseReport];
    
    XCTAssertFalse(report.passed);
    
}

- (void)testFailingTestCaseReportNonNilErrorMessage {
    
    (void) [[self class] stubFailedTestReport];
    
    OCSPTestCaseReport *report = [self acceptanceTestCaseReport];
    
    XCTAssertNotNil(report.errorMessage);
}

- (void)testFailingTestCaseReportErrorMessage {
    
    (void) [[self class] stubFailedTestReport];
    
    OCSPTestCaseReport *report = [self acceptanceTestCaseReport];
    
    XCTAssertEqualObjects([OCSPLocalizedMessageTable localizedTestPageMessageWithUnderlyingMessage:@"1 errors"], report.errorMessage);
}

- (void)testTestReportsAddsExtraTest {
    
    (void) [[self class] stubFailedTestReport];
    
    self.center.xcodeFixDisappearingTestCaseByAppendingDummyTest = NO;
    
    NSArray *reports = [self.center testCaseReports];
    
    OCSPTestCaseReport *lastTestReport = reports.lastObject;
    
    XCTAssertEqual(reports.count, 2);
    
    XCTAssertTrue(lastTestReport.passed);
    
    XCTAssertEqualObjects(lastTestReport.name, @"tearDown");
    
}

#pragma mark - Test Report Tests

- (void)testNumberOfTestCaseReports {
    
    (void) [[self class] stubSuccessfulTestReport];
    
    NSArray *results = [self.center testCaseReports];
    
    XCTAssertEqual(results.count, 1);
    
}

- (void)testNumberOfTestCaseReportsWithOtherTestReportData {
    
    (void) [[self class] stubSuccessfulTestReportWithFilenameModifier:@"3"];
    
    NSArray *results = [self.center testCaseReports];
    
    XCTAssertEqual(results.count, 3);
}

#pragma mark - Test Helpers

- (OCSPTestCaseReport *)acceptanceTestCaseReport {

    return [[self.center testCaseReports] firstObject];
}

//- (void)testStubCreatesTestReportsWithData {
//    
//    NSData *data = [[self class] stubSuccessfulTestReport];
//    
//    XCTAssertTrue( [[[OCSPTestReportReader defaultReader] read] isEqualToData:data]);
//    
//}

+ (NSData* )stubSuccessfulTestReport {
    
    return [self stubSuccessfulTestReportWithFilenameModifier:nil];
}

+ (NSData* )stubFailedTestReport {
    
    return [self stubFailedTestReportWithFilenameModifier:nil];
    
}
//
//+ (NSData* )stubErrorTestReport {
//    
//    NSData *data = [OCSPTestDataManager errorResultData];
//    
//    return [self stubTestReportWithData:data];
//    
//}
//
+ (NSData* )stubSuccessfulTestReportWithFilenameModifier:(NSString*)modifier {
    
    NSData *data = [OCSPTestDataManager successResultDataByAppendingHyphenatedFilenameModifier:modifier];
    
    return [self stubTestReportWithData:data];
    
}
//
+ (NSData* )stubFailedTestReportWithFilenameModifier:(NSString*)modifier {
    
    NSData *data = [OCSPTestDataManager failedResultDataByAppendingHyphenatedFilenameModifier:modifier];
    
    return [self stubTestReportWithData:data];
    
}

+ (NSData *)stubTestReportWithData:(NSData*)data {
    
    NSParameterAssert(data);
    
    createDefaultTestReportReaderWithData(data);
    
    return data;
    
}


@end
