#import "OCSlimProjectFitnesseTestsMain.h"
#import "OCSlimProject_FitnesseTests-Swift.h"
#import "OCSlimProjectJUnitTestAsserter.h"

@implementation OCSlimProjectFitnesseTestsMain

- (id)init {
    
    if (self == [super init]) {
        
        [[XCTestObservationCenter sharedTestObservationCenter] addTestObserver:self];
        
    }
    
    return self;
}


#pragma mark - XCTestObservation

- (void)testSuiteWillStart:(XCTestSuite *)testSuite {
    
    NSString *testSuiteName = [OCSlimProjectFitnesseTest testSuiteName];
    
    for (XCTest *suite in [testSuite tests]) {
        
        if ([suite.name isEqualToString:testSuiteName]) {
            
            XCTestCase *test = [self test];
            
            [(XCTestSuite*)suite addTest:test];
            
        }
    }
}

- (void)testBundleDidFinish:(NSBundle *)testBundle {
    
    [[XCTestObservationCenter sharedTestObservationCenter] removeTestObserver:self];
    
}

#pragma mark - Private

- (XCTestCase *)test {
    
    NSData *data = [[OCSlimFitnesseTestReportCenter defaultReader] read];
    
    XCTestCase *test = [[OCSlimProjectJUnitTestAsserter alloc] initWitData:data];
    
    return test;

}

#pragma mark - Dynamic Test Case Helpers

+ (void)addDummyFitnesseTestsToSuite:(XCTestSuite *)suite {
    
    // Example Standard Test Invocations
    [OCSlimProjectFitnesseTestsMain addFitnesseTestWithSelector:@selector(exampleFail) toSuite:suite];
    [OCSlimProjectFitnesseTestsMain addFitnesseTestWithSelector:@selector(examplePass) toSuite:suite];
    
    // Example Test Invocations With Arguments
    [OCSlimProjectFitnesseTestsMain addFitnesseTestWithSelector:@selector(exampleAssert:) arg:YES toSuite: suite];
    [OCSlimProjectFitnesseTestsMain addFitnesseTestWithSelector:@selector(exampleAssert:) arg:NO toSuite: suite];
}

+ (void)addFitnesseTestWithSelector:(SEL)selector arg:(BOOL)assert toSuite:(XCTestSuite *)suite {
    NSInvocation *invocation = [self invocationWithSelector:@selector(example:)];
    [invocation setArgument:&assert atIndex:2];
    [OCSlimProjectFitnesseTestsMain addFitnesseTestWithInvocation:invocation toSuite:suite];
}

+ (void)addFitnesseTestWithSelector:(SEL)selector toSuite:(XCTestSuite *)suite {
    NSInvocation *invocation = [self invocationWithSelector:selector];
    [OCSlimProjectFitnesseTestsMain addFitnesseTestWithInvocation:invocation toSuite:suite];
}

+ (void)addFitnesseTestWithInvocation:(NSInvocation *)invocation toSuite:(XCTestSuite *)suite {
    XCTestCase *test = [[OCSlimProjectFitnesseTest alloc] initWithInvocation:invocation];
    [suite addTest:test];
}

+ (NSInvocation *)invocationWithSelector:(SEL)selector {
    NSMethodSignature *signature = [OCSlimProjectFitnesseTest instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    return invocation;
}

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
