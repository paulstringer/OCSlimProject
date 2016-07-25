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
        
        OCSPTestCase *test = [[OCSPTestCase alloc] initWithTestCaseName:@"TearDown" result:YES];
        
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

    
    XCTestSuite *acceptanceTestSuite = [XCTestSuite testSuiteWithName:@"AcceptanceTestSuite"];
    
    OCSPJUnitXMLParser *parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [parser parse];
    
    
    for (int i = 0; i < [parser testCaseCount]; i++ ) {
    
        NSString *fitnesseTestPageName = [parser testNameForTestCaseAtIndex:i];
        
        NSString *testCaseName = [OCSlimProjectFitnesseTestsMain testNameByRemovingSuiteNameComponent:fitnesseTestPageName];
        
        BOOL result = [parser testResultForTestCaseAtIndex:i];
        
        XCTestCase *testCase = [[OCSPTestCase alloc] initWithTestCaseName:testCaseName result:result];
        
        [acceptanceTestSuite addTest:testCase];
        
    }
    
    
    return acceptanceTestSuite;

}

+ (NSString *)testNameByRemovingSuiteNameComponent:(NSString *)testName {
    
    NSInteger indexOfPageName = [testName rangeOfString:@"."].location;
    
    if (indexOfPageName != NSNotFound) {
        return [testName substringFromIndex:indexOfPageName + 1];
    } else {
        return testName;
    }
    
}

@end

