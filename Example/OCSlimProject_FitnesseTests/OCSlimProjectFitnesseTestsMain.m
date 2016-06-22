#import "OCSlimProjectFitnesseTestsMain.h"
#import <XCTest/XCTest.h>

@interface OCSlimProjectFitnesseTestsMain () <XCTestObservation>

@end

@implementation OCSlimProjectFitnesseTestsMain

- (id)init {
    
    if (self == [super init]) {
        
        [[XCTestObservationCenter sharedTestObservationCenter] addTestObserver:self];
        
    }
    
    return self;
}

- (void)testSuiteWillStart:(XCTestSuite *)testSuite {
  
    NSLog(@"Tests Will Start %@", testSuite);
    
}

@end
