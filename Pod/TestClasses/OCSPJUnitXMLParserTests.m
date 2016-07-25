#import <XCTest/XCTest.h>
#import "OCSPJUnitXMLParser.h"
#import "OCSPTestDataManager.h"

@interface OCSPJUnitXMLParserTests : XCTestCase

@property (nonatomic, strong) OCSPJUnitXMLParser *parser;

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

#pragma mark - Test Case Name Tests

- (void)testTestCaseNameAtIndex {
    
    NSData *data = [OCSPTestDataManager successResultDataByAppendingHyphenatedFilenameModifier:@"3"];
    
    self.parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [self.parser parse];
    
    XCTAssertEqualObjects([self.parser testNameForTestCaseAtIndex:0], @"OCSlimProjectExamplePage.TestPage0");
    XCTAssertEqualObjects([self.parser testNameForTestCaseAtIndex:1], @"OCSlimProjectExamplePage.TestPage1");
    XCTAssertEqualObjects([self.parser testNameForTestCaseAtIndex:2], @"OCSlimProjectExamplePage.TestPage2");
    
    
}


- (void)testTestCaseNameAtIndexOutOfRange {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    [self setupParserWithData:data];
    
    XCTAssertNil([self.parser testNameForTestCaseAtIndex:1]);
    
    
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

#pragma mark - Test Automators

- (void)setupParserWithData:(NSData*)data {
    
    self.parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [self.parser parse];
    
}

@end
