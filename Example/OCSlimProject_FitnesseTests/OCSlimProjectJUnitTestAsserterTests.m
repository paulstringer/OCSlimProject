#import <XCTest/XCTest.h>
#import "OCSlimProjectJUnitTestAsserter.h"
#import "OCSlimProject_FitnesseTests-Swift.h"

@interface OCSlimProjectJUnitTestAsserterTests : XCTestCase <XCTestObservation>
@property (nonatomic, strong) OCSlimProjectJUnitTestAsserter *asserter;
@property (nonatomic, strong) OCSlimProjectAssertRecorderSpy *recorderSpy;
@end

@implementation OCSlimProjectJUnitTestAsserterTests

- (void)setUp {
    
    self.recorderSpy = [[OCSlimProjectAssertRecorderSpy alloc] init];
    
}

- (void)tearDown {
    
}

- (void)testResultForXMLDataWithZeroFailures {
    
    NSData *data = [[[OCSlimProjectTestDataManager alloc] init] successResultData];
    
    [self runAsserterWithData:data];
    
    XCTAssertFalse(self.recorderSpy.didRecordFail);
    XCTAssertTrue(self.recorderSpy.didRecordPass);
    
}

- (void)testResultForXMLDataWithFailures {
    
    NSData *data = [[[OCSlimProjectTestDataManager alloc] init] failedResultData];
    
    [self runAsserterWithData:data];
    
    XCTAssertFalse(self.recorderSpy.didRecordPass);
    XCTAssertTrue(self.recorderSpy.didRecordFail);
    
}

- (void)testInvocationWillRunAssertions {
    
    OCSlimProjectJUnitTestAsserter *asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWitData:[NSData new] assertRecorder:self.recorderSpy];
    
    XCTAssertEqual(asserter.invocation.selector, @selector(run));
    
}

- (void)runAsserterWithData:(NSData*)data {
    
    self.asserter = [[OCSlimProjectJUnitTestAsserter alloc] initWitData:data assertRecorder:self.recorderSpy];
    
    [self.asserter run];
    
}

@end
