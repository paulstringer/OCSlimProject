#import <XCTest/XCTest.h>
#import "OCSPJUnitXMLParser.h"
#import "OCSlimProjectTestDataManager.h"

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
    
    NSData *data = [OCSlimProjectTestDataManager failedResultData];
    
    XCTAssertFalse([self.parser resultForTestSuiteXMLData:data]);
}

- (void) testSuiteJUnitXMLSuccessWillPass {
    
    NSData *data = [OCSlimProjectTestDataManager successResultData];
    
    XCTAssertTrue([self.parser resultForTestSuiteXMLData:data]);
    
}

- (void) testNumberOfTestCases {
    
    NSData *data = [OCSlimProjectTestDataManager successResultData];
    
    XCTAssertEqual([self.parser testCaseCountForXMLData:data], 1);
    
}


- (void) testNumberOfTestCasesWithMultipleTestCases {
    
    NSData *data = [OCSlimProjectTestDataManager successResultDataByAppendingHyphenatedFilenameModifier:@"3"];
    
    XCTAssertEqual([self.parser testCaseCountForXMLData:data], 3);
    
}

@end
