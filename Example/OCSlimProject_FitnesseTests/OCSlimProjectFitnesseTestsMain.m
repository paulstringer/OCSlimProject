#import "OCSlimProjectFitnesseTestsMain.h"
#import <XCTest/XCTest.h>
#import "OCSlimProject_FitnesseTests-Swift.h"

@interface OCSlimProjectFitnesseTestsMain () <XCTestObservation>

@end

@implementation OCSlimProjectFitnesseTestsMain

- (id)init {
    
    if (self == [super init]) {
        
        [[XCTestObservationCenter sharedTestObservationCenter] addTestObserver:self];
        
    }
    
    return self;
}

#pragma mark - XCTestObservation

- (void)testSuiteWillStart:(XCTestSuite *)testSuite {
    
    NSString *testSuiteName = NSStringFromClass([OCSlimProjectFitnesseTest class]).pathExtension;
    
    for (XCTest *suite in [testSuite tests]) {
        
        if ([suite.name isEqualToString:testSuiteName]) {
            
            [OCSlimProjectFitnesseTestsMain addFitnesseTestsToSuite:(XCTestSuite*)suite];
            
        }
    }
}

#pragma mark - Dynamic Test Case Helpers

+ (void)addFitnesseTestsToSuite:(XCTestSuite *)suite {
    
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
