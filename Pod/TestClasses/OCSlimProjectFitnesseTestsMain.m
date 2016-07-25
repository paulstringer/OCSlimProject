#import "OCSlimProjectFitnesseTestsMain.h"
#import "OCSPTestReportReader.h"
#import "OCSPTestCase.h"
#import "OCSPJUnitXMLParser.h"

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
        
        [self applyDisappearingTestCaseFix:acceptanceTestSuite];
    
        [testSuite addTest:acceptanceTestSuite];
        
    }
    
}

- (void)applyDisappearingTestCaseFix:(XCTestSuite*)suite {
    
    
    if (!self.disableFixForXcodeDisappearingTestCaseByAppendingDummyTest) {
        
        NSString *testCaseName = [suite.name stringByAppendingString:@".TearDown"];
        
        OCSPTestCase *test = [[OCSPTestCase alloc] initWithTestCaseName:testCaseName result:YES];
        
        [suite addTest:test];
        
    }
    
    
}
- (void)testBundleDidFinish:(NSBundle *)testBundle {
    
    [[XCTestObservationCenter sharedTestObservationCenter] removeTestObserver:self];
    
}

#pragma mark - Don't Peek!

- (void)registerHostTestBundle:(NSBundle *)bundle {
    
    self.bundleTestSuiteName = [[bundle bundleURL] lastPathComponent];

}

- (BOOL)isHostTestSuite:(XCTestSuite *)suite {
    
    return [[suite name] isEqualToString:self.bundleTestSuiteName];
}

+ (XCTestSuite *)testSuite {
    
    
    NSData *data = [[OCSPTestReportCenter defaultReader] read];

    OCSPJUnitXMLParser *parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [parser parse];
    
    
    NSString *testSuiteName = [parser testSuiteName];
    
    XCTestSuite *acceptanceTestSuite = [XCTestSuite testSuiteWithName:testSuiteName];
    
    
    
    for (int i = 0; i < [parser testCaseCount]; i++ ) {
    
        NSString *testCaseName = [parser testNameForTestCaseAtIndex:i];
        
        BOOL result = [parser testResultForTestCaseAtIndex:i];
        
        XCTestCase *testCase = [[OCSPTestCase alloc] initWithTestCaseName:testCaseName result:result];
        
        [acceptanceTestSuite addTest:testCase];
        
    }
    
    
    return acceptanceTestSuite;

}

@end

