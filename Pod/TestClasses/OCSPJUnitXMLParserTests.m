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

- (void)testTestCaseNameAtIndex {
    
    NSData *data = [OCSPTestDataManager successResultDataByAppendingHyphenatedFilenameModifier:@"3"];
    
    self.parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [self.parser parse];
    
    XCTAssertEqualObjects([self.parser testCaseNameForTestCaseAtIndex:0], @"FakeTestCase0");
    XCTAssertEqualObjects([self.parser testCaseNameForTestCaseAtIndex:1], @"FakeTestCase1");
    XCTAssertEqualObjects([self.parser testCaseNameForTestCaseAtIndex:2], @"FakeTestCase2");
    
    
}


- (void)testTestCaseNameAtIndexOutOfRange {
    
    NSData *data = [OCSPTestDataManager successResultData];
    
    self.parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [self.parser parse];
    
    XCTAssertNil([self.parser testCaseNameForTestCaseAtIndex:1]);
    
    
}

#pragma mark - Test Automators

- (void)setupParserWithData:(NSData*)data {
    
    self.parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [self.parser parse];
    
}

@end
