#import <XCTest/XCTest.h>
#import "OCSPJUnitXMLParser.h"
#import "OCSPTestDataManager.h"

@interface OCSPJUnitXMLParserTests : XCTestCase

@property (nonatomic, strong) OCSPJUnitXMLParser *parser;
@property (nonatomic, strong) NSError *parsingError;
@end

@implementation OCSPJUnitXMLParserTests

- (void)setUp {
    
    [super setUp];
    
    self.parser = [[OCSPJUnitXMLParser alloc] init];
    
}

- (void)tearDown {
    self.parser = nil;
    
    [super tearDown];
}

- (void) testSuiteNameNotEmpty {
    
    XCTAssertNotNil(self.parser.testSuiteName);
    
    XCTAssertNotEqualObjects(@"", self.parser.testSuiteName);
    
}

- (void) testSuiteJUnitXMLFailureWillFail {
    
    NSData *data = [OCSPTestDataManager failedResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertFalse([self.parser result]);
}

- (void) testSuiteJUnitXMLSuccessWillPass {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertTrue([self.parser result]);
    
}

- (void) testSuiteJUnitXMLSuccessParsingSucceeded {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertTrue([self.parser parsingSucceeded]);
    
}

#pragma mark - Number Of Test Cases Tests

- (void) testNumberOfTestCases {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertEqual([self.parser testCaseCount], 1);
    
}


- (void) testNumberOfTestCasesWithMultipleTestCases {
    
    NSData *data = [OCSPTestDataManager successResultDataByAppendingHyphenatedFilenameModifier:@"3"];
    
    [self setupParserWithData:data];
    
    XCTAssertEqual([self.parser testCaseCount], 3);
    
}

#pragma mark - Test Suite and Case name tests

- (void)testSuiteName {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertEqualObjects([self.parser testSuiteName], @"OCSlimProjectExampleSuite");
}

- (void)testTestCaseNameAtIndex {
    
    NSData *data = [OCSPTestDataManager successResultDataByAppendingHyphenatedFilenameModifier:@"3"];
    
    [self setupParserWithData:data];
    
    XCTAssertEqualObjects([self.parser testNameForTestCaseAtIndex:0], @"OCSlimProjectExampleSuite.TestPage0");
    XCTAssertEqualObjects([self.parser testNameForTestCaseAtIndex:1], @"OCSlimProjectExampleSuite.TestPage1");
    XCTAssertEqualObjects([self.parser testNameForTestCaseAtIndex:2], @"OCSlimProjectExampleSuite.TestPage2");
    
    
}

- (void)testTestCaseNameAtIndexOutOfRange {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertNil([self.parser testNameForTestCaseAtIndex:1]);

}

- (void)testErrorMessageAtIndexForPass {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertNil([self.parser testErrorMessageForTestCaseAtIndex:0]);
    
}

- (void)testErrorMessageAtIndexForFail {
    
    NSData *data = [OCSPTestDataManager failedResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertEqualObjects([self.parser testErrorMessageForTestCaseAtIndex:0], @"1 errors");
    
}


- (void)testErrorMessageAtIndexesForFail {
    
    NSData *data = [OCSPTestDataManager failedResultDataByAppendingHyphenatedFilenameModifier:@"3"];
    
    [self setupParserWithData:data];
    
    XCTAssertEqualObjects([self.parser testErrorMessageForTestCaseAtIndex:0], @"1 errors");
    
    XCTAssertEqualObjects([self.parser testErrorMessageForTestCaseAtIndex:1], @"2 errors");
    
    XCTAssertEqualObjects([self.parser testErrorMessageForTestCaseAtIndex:2], @"3 errors");
    
}


#pragma mark - Test Result Tests

- (void)testResultAtIndexWithSuccessfulResults {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertTrue([self.parser testResultForTestCaseAtIndex:0]);
    
}

- (void)testResultAtIndexWithFailedResults {
    
    NSData *data = [OCSPTestDataManager failedResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertFalse([self.parser testResultForTestCaseAtIndex:0]);
    
}

#pragma mark - Test XML Errors

- (void)testErrorsReportedGivenNotFoundData {
    
    NSData *data = [OCSPTestDataManager failedResultDataByAppendingHyphenatedFilenameModifier:@"NotFound"];
    
    [self setupParserWithData:data];
    
    XCTAssertTrue(self.parser.parseErrorOccured);
}

- (void)testSuiteNameGivenNotFoundData {
    
    NSData *data = [OCSPTestDataManager failedResultDataByAppendingHyphenatedFilenameModifier:@"NotFound"];
    
    [self setupParserWithData:data];
    
    XCTAssertNotNil(self.parser.testSuiteName);
}

- (void)testSuiteNameGivenNilData {
    
    [self setupParserWithData:nil];
    
    XCTAssertNotNil(self.parser.testSuiteName);
}

- (void)testSuiteParsingSucceededGivenNilData {
    
    [self setupParserWithData:nil];
    
    XCTAssertFalse(self.parser.parsingSucceeded);
    
}
#pragma mark - Test Automators

- (void)setupParserWithData:(NSData*)data {
    
    self.parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [self.parser parse];
    
}

@end
