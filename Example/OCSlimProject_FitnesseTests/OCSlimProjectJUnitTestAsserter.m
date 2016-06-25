#import "OCSlimProjectJUnitTestAsserter.h"
#import "OCSlimProject_FitnesseTests-Swift.h"

@interface OCSlimProjectJUnitTestAsserter ()
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) id<OCSlimProjectAssertRecorder> assertRecorder;
@end

@implementation OCSlimProjectJUnitTestAsserter

- (id)initWitData:(NSData *)data  {

    id<OCSlimProjectAssertRecorder> recorder = [[OCSlimProjectXCTestAssertRecorder alloc] init];
    
    return [self initWitData:data assertRecorder:recorder];
}

- (id)initWitData:(NSData *)data assertRecorder:(id<OCSlimProjectAssertRecorder>)recorder {
    
    if (self == [super initWithSelector:@selector(run)]) {
        _data = data;
        _assertRecorder = recorder;
    }
    
    return self;
}

- (void)run {
    
    FitnesseTestSuiteXMLResultParser *parser = [[FitnesseTestSuiteXMLResultParser alloc] init];
    
    BOOL result = [parser resultForTestSuiteXMLData:self.data];
    
    if ( !result ) {
        [self.assertRecorder recordFail];
    } else {
        [self.assertRecorder recordPass];
    }
}

@end
