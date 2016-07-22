#import "OCSlimProjectFitnesseTestsMain.h"
#import "OCSlimFitnesseTestReportReader.h"
#import "OCSlimProjectJUnitTestAsserter.h"
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
    
    XCTestCase *testCase = [[OCSlimProjectJUnitTestAsserter alloc] initWitData:data];
    
    
    XCTestSuite *acceptanceTestSuite = [XCTestSuite testSuiteWithName:@"AcceptanceTestSuite"];
    
    OCSPJUnitXMLParser *parser = [[OCSPJUnitXMLParser alloc] init];
    
    
    for (int i = 0; i < [parser testCaseCountForXMLData:data]; i++ ) {
    
        [acceptanceTestSuite addTest:testCase];
        
    }
    
    
    return acceptanceTestSuite;

}

#pragma mark - Dynamic Test Case Helpers

//+ (void)addFitnesseTestWithSelector:(SEL)selector arg:(BOOL)assert toSuite:(XCTestSuite *)suite {
//    NSInvocation *invocation = [self invocationWithSelector:@selector(example:)];
//    [invocation setArgument:&assert atIndex:2];
//    [OCSlimProjectFitnesseTestsMain addFitnesseTestWithInvocation:invocation toSuite:suite];
//}
//
//+ (void)addFitnesseTestWithSelector:(SEL)selector toSuite:(XCTestSuite *)suite {
//    NSInvocation *invocation = [self invocationWithSelector:selector];
//    [OCSlimProjectFitnesseTestsMain addFitnesseTestWithInvocation:invocation toSuite:suite];
//}
//
//+ (void)addFitnesseTestWithInvocation:(NSInvocation *)invocation toSuite:(XCTestSuite *)suite {
//    XCTestCase *test = [[OCSlimProjectFitnesseTest alloc] initWithInvocation:invocation];
//    [suite addTest:test];
//}
//
//+ (NSInvocation *)invocationWithSelector:(SEL)selector {
//    NSMethodSignature *signature = [OCSlimProjectFitnesseTest instanceMethodSignatureForSelector:selector];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    [invocation setSelector:selector];
//    return invocation;
//}

@end


//            NSData *data = [[OCSlimFitnesseTestReportCenter defaultReader] read];

//            NSInvocation *invocation = [FitnesseTestSuiteXMLResultParser instanceMethodSignatureForSelector:@selector(assertResultWithJUnitTestSuiteData:)];
//
//            [invocation setArgument:&data atIndex:2];
//
//            [invocation retainArguments];
//
//            FitnesseTestSuiteXMLResultParser *test = [[FitnesseTestSuiteXMLResultParser alloc] initWithInvocation:invocation];
//
//            [(XCTestSuite*) suite addTest:test];


//            [OCSlimProjectFitnesseTestsMain addDummyFitnesseTestsToSuite:(XCTestSuite*)suite];
