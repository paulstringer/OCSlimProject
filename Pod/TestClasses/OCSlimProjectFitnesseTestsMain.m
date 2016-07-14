#import "OCSlimProjectFitnesseTestsMain.h"
#import "OCSlimFitnesseTestReportReader.h"
#import "OCSlimProjectJUnitTestAsserter.h"


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
    
    self.bundleTestSuiteName = [[testBundle bundleURL] lastPathComponent];
    
    NSLog(@"Bundle Test Suite Name %@", self.bundleTestSuiteName);
    
}

- (void)testSuiteWillStart:(XCTestSuite *)testSuite {
    
    
    if ([[testSuite name] isEqualToString:self.bundleTestSuiteName]) {
    
        XCTestSuite *suite = [OCSlimProjectFitnesseTestsMain testSuite];
    
        [testSuite addTest:suite];
        
    }
    
}
- (void)testBundleDidFinish:(NSBundle *)testBundle {
    
    [[XCTestObservationCenter sharedTestObservationCenter] removeTestObserver:self];
    
}

#pragma mark - XCTestRun Setup

#pragma mark - Private

+ (XCTestSuite *)testSuite {
    
    
    NSData *data = [[OCSlimFitnesseTestReportCenter defaultReader] read];
    
    XCTestCase *test = [[OCSlimProjectJUnitTestAsserter alloc] initWitData:data];
    
    
    XCTestSuite *currentSuite = [XCTestSuite testSuiteWithName:@"AcceptanceTestSuite"];
    
    [currentSuite addTest:test];
    
    
    return currentSuite;

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
