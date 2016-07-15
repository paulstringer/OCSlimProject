#import "OCSlimProjectJUnitTestAsserter.h"
#import "OCSlimProjectAssertRecorder.h"
#import "FitnesseTestSuiteXMLResultParser.h"

@interface OCSlimProjectJUnitTestAsserter ()
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) id<OCSlimProjectAssertRecorder> assertRecorder;
@property (nonatomic, strong) NSString *testName;
@end

@implementation OCSlimProjectJUnitTestAsserter

+ (void)initialize {
    
    [super initialize];
    
}
- (id)initWitData:(NSData *)data  {

    id<OCSlimProjectAssertRecorder> recorder = [[OCSlimProjectXCTestAssertRecorder alloc] init];
    
    return [self initWitData:data assertRecorder:recorder];
}

- (id)initWitData:(NSData *)data assertRecorder:(id<OCSlimProjectAssertRecorder>)recorder {
    
    return [self initWithName:@"Fitnesse.Suite" data:data assertRecorder:recorder];

}

- (id)initWithName:(NSString *)name data:(NSData *)data assertRecorder:(id<OCSlimProjectAssertRecorder>)recorder {
    
    if (self == [super initWithSelector:NSSelectorFromString(name)]) {
        _testName = name;
        _data = data;
        _assertRecorder = recorder;
    }
    
    return self;
    
    
}
- (void)run {
    
    FitnesseTestSuiteXMLResultParser *parser = [[FitnesseTestSuiteXMLResultParser alloc] init];
    
    BOOL result = [parser resultForTestSuiteXMLData:self.data];
    
    if ( !result ) {
        [self.assertRecorder recordFailWithTestCase:self];
    } else {
        [self.assertRecorder recordPassWithTestCase:self];
    }
}

#pragma mark - Arbitrary Test Name Forwarding Mechanism

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if ([self respondsToSelector:aSelector]) {
        return [[self class] instanceMethodSignatureForSelector:aSelector];
    } else {
        return [super methodSignatureForSelector:@selector(run)];
    }
    
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    if  ( anInvocation.selector == NSSelectorFromString(self.testName) ) {
        anInvocation.selector = @selector(run);
    }
    
    [anInvocation invokeWithTarget:self];
    
}
@end


