#import "OCSlimProjectFitnesseTestsMain.h"
#import "OCSPTestReportReader.h"
#import "OCSPTestSuite.h"
#import "OCSPJUnitXMLParser.h"
#import "OCSPLocalizedMessageTable.h"

@interface OCSlimProjectFitnesseTestsMain ()

@property (nonatomic, strong) NSString *bundleTestSuiteName;

@end

@implementation OCSlimProjectFitnesseTestsMain

- (id)init {
    
    if (self == [super init]) {
        
        [[XCTestObservationCenter sharedTestObservationCenter] addTestObserver:self];
       
    }
    
    return self;
}

#pragma mark - XCTestObservation

- (void)testBundleWillStart:(NSBundle *)testBundle {
    
    [self registerHostTestBundle:testBundle];
    
}

- (void)testSuiteWillStart:(XCTestSuite *)testSuite {
    
    if ( [self isHostTestSuite:testSuite] ) {
    
        XCTestSuite *acceptanceTestSuite = [OCSlimProjectFitnesseTestsMain testSuite];
        
        [self applyDisappearingTestCaseUIFix:acceptanceTestSuite];
    
        [testSuite addTest:acceptanceTestSuite];
        
    }
    
}

- (void)testBundleDidFinish:(NSBundle *)testBundle {
    
    [[XCTestObservationCenter sharedTestObservationCenter] removeTestObserver:self];
    
}

#pragma mark - Private

#pragma mark - Identifing Target Test Bundle

- (void)registerHostTestBundle:(NSBundle *)bundle {
    
    self.bundleTestSuiteName = [[bundle bundleURL] lastPathComponent];

}

- (BOOL)isHostTestSuite:(XCTestSuite *)suite {
    
    return [[suite name] isEqualToString:self.bundleTestSuiteName];
}

#pragma mark - Test Suite Building

+ (XCTestSuite *)testSuite {
    
    OCSPJUnitXMLParser *parser = [self testReportParsed];
    
    
    NSString *testSuiteName = [parser testSuiteName];
    
    XCTestSuite *acceptanceTestSuite = [XCTestSuite testSuiteWithName:testSuiteName];
    
    
    for (int i = 0; i < [parser testCaseCount]; i++ ) {
    
        XCTestCase *testCase = [self testCaseForIndex:i parser:parser];

        [acceptanceTestSuite addTest:testCase];
        
    }
    
    
    [self addExceptionParseReportTestCases:parser testSuite:acceptanceTestSuite];
    
    return acceptanceTestSuite;

}

#pragma mark Test Suite Building Helpers

+ (XCTestCase *)testCaseForIndex:(NSUInteger)i parser:(OCSPJUnitXMLParser *)parser {
    
    NSString *testCaseName = [parser testNameForTestCaseAtIndex:i];
    
    BOOL result = [parser testResultForTestCaseAtIndex:i];
    
    
    OCSPTestSuite *testCase = [[OCSPTestSuite alloc] initWithTestCaseName:testCaseName result:result];
    
    
    NSString *testPageErrorMessage = [parser testErrorMessageForTestCaseAtIndex:i];
    
    NSString *message = [OCSPLocalizedMessageTable localizedTestPageMessageWithUnderlyingMessage:testPageErrorMessage];
    
    [testCase setErrorMessage:message];
    
    
    return testCase;
    
}

+ (void)addExceptionParseReportTestCases:(OCSPJUnitXMLParser *)parser testSuite:(XCTestSuite *) suite {
    
    OCSPTestSuite *reportingTestCase = nil;
    
    NSString *message = nil;
    
    if ( parser.parseErrorOccured == YES ) {
        
        reportingTestCase = [[OCSPTestSuite alloc] initWithTestCaseName:@"TestSuiteReportXMLParsingSucceeded" result:NO];
        
        message = [OCSPLocalizedMessageTable localizedTestSuiteParsingErrorMessage];
        
    } else if ( parser.parsingSucceeded == NO) {
      
        reportingTestCase = [[OCSPTestSuite alloc] initWithTestCaseName:@"TestSuiteReportDataExists" result:NO];
        
        message = [OCSPLocalizedMessageTable localizedTestSuiteReportDataNotFound];
        
    } else if ( [self testSuiteIsEmpty:parser] ) {
        
        NSString *testCaseName = [NSString stringWithFormat:@"%@TestCaseCountGreaterThanZero", [parser testSuiteName]];
        
        reportingTestCase = [[OCSPTestSuite alloc] initWithTestCaseName:testCaseName result:NO];
        
        message = [OCSPLocalizedMessageTable localizedEmptyTestSuiteMessageWithSuiteName:[parser testSuiteName]];
        
    } else if ( [self testSuiteFailedToRun:parser] ) {
        
        NSString *testCaseName = [NSString stringWithFormat:@"%@ErrorCountEqualsZero", [parser testSuiteName]];
        
        reportingTestCase = [[OCSPTestSuite alloc] initWithTestCaseName:testCaseName result:NO];
        
        message = [OCSPLocalizedMessageTable localizedTestSuiteErrorsOccurredMessageWithCount:parser.testSuiteErrorCount];
        
    }
    
    [reportingTestCase setErrorMessage:message];
    
    [suite addTest:reportingTestCase];
    
}

+ (BOOL)testSuiteIsEmpty:(OCSPJUnitXMLParser *)parser {
    
    return parser.parsingSucceeded == YES && [parser testCaseCount] == 0 && [parser testSuiteErrorCount] == 0;
    
}

+ (BOOL)testSuiteFailedToRun:(OCSPJUnitXMLParser *)parser {
    
    BOOL errorsOccuredOutsideOfTests = parser.testSuiteErrorCount > parser.testCaseCount;
    
    return parser.parsingSucceeded == YES && errorsOccuredOutsideOfTests;
    
}

+ (OCSPJUnitXMLParser *)testReportParsed {
    
    NSData *data = [[OCSPTestReportCenter defaultReader] read];
    
    OCSPJUnitXMLParser *parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [parser parse];
    
    return parser;
}

#pragma mark - Xcode XCTest Rerpoting Fix


- (void)applyDisappearingTestCaseUIFix:(XCTestSuite*)suite {
    
    
    if (!self.disableFixForXcodeDisappearingTestCaseByAppendingDummyTest) {
        
        NSString *testCaseName = [suite.name stringByAppendingString:@".TearDown"];
        
        OCSPTestSuite *test = [[OCSPTestSuite alloc] initWithTestCaseName:testCaseName result:YES];
        
        [suite addTest:test];
        
    }
    
    
}

@end

