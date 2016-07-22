#import "OCSPJUnitTestAsserter.h"
#import "OCSPAssertRecorder.h"
#import "OCSPJUnitXMLParser.h"

@interface OCSPJUnitTestAsserter ()
@property (nonatomic, strong) id<OCSPAssertRecorder> assertRecorder;
@property (nonatomic, strong) NSString *testName;
@property (nonatomic, assign) BOOL testResult;
@end

@implementation OCSPJUnitTestAsserter

- (id)initWithTestCaseName:(NSString *)name result:(BOOL)result {
    
    id<OCSPAssertRecorder> recorder = [[OCSPXCAssertRecorder alloc] init];
    
    return [self initWithTestCaseName:name result:result assertRecorder:recorder];
}


- (nonnull id)initWithTestCaseName:(nonnull NSString *)name result:(BOOL)result assertRecorder:(nonnull id<OCSPAssertRecorder>)recorder {
    
    if (self == [super initWithSelector:NSSelectorFromString(name)] ) {
        _testName = name;
        _testResult = result;
        _assertRecorder = recorder;
    }
    
    return self;
}

- (void)run {
    
    if ( self.testResult == NO ) {
        [self.assertRecorder recordFailWithTestCase:self];
    } else {
        [self.assertRecorder recordPassWithTestCase:self];
    }
}

- (NSString *)testCaseName {
    
    NSString *name = [[self name] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]];
    
    return [[name componentsSeparatedByString:@" "] lastObject];
    
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


