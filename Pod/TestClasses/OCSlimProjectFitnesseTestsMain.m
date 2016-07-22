#import "OCSlimProjectFitnesseTestsMain.h"
#import "OCSlimFitnesseTestReportReader.h"
#import "OCSPJUnitTestAsserter.h"
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
    
        XCTestSuite *fitnesseTestSuite = [OCSlimProjectFitnesseTestsMain testSuite];
    
        [testSuite addTest:fitnesseTestSuite];
        
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
    
    
    NSData *data = [[OCSlimFitnesseTestReportCenter defaultReader] read];

    
    XCTestSuite *acceptanceTestSuite = [XCTestSuite testSuiteWithName:@"AcceptanceTestSuite"];
    
    OCSPJUnitXMLParser *parser = [[OCSPJUnitXMLParser alloc] initWithXMLData:data];
    
    [parser parse];
    
    
    for (int i = 0; i < [parser testCaseCount]; i++ ) {
    
        NSString *name = [parser testCaseNameForTestCaseAtIndex:i];
        
        XCTestCase *testCase = [[OCSPJUnitTestAsserter alloc] initWithTestCaseName:name result:NO];
        
        [acceptanceTestSuite addTest:testCase];
        
    }
    
    
    return acceptanceTestSuite;

}


@end

