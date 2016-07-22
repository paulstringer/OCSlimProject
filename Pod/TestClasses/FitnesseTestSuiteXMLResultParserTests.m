#import <XCTest/XCTest.h>
#import "FitnesseTestSuiteXMLResultParser.h"
#import "OCSlimProjectTestDataManager.h"

@interface FitnesseTestSuiteXMLResultParserTests : XCTestCase

@property (nonatomic, strong) FitnesseTestSuiteXMLResultParser *parser;

@end

@implementation FitnesseTestSuiteXMLResultParserTests

- (void)setUp {
    [super setUp];
    
    self.parser = [[FitnesseTestSuiteXMLResultParser alloc] init];
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
