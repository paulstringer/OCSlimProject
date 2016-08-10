#import "OCSPTestSuite.h"
#import "OCSPAssertRecorder.h"
#import "OCSPJUnitXMLParser.h"
#import "OCSPPrincipalTestObserver.h"

@interface OCSPTestSuite ()
@property (nonatomic, strong) id<OCSPAssertRecorder> assertRecorder;
@property (nonatomic, strong) NSString *testName;
@property (nonatomic, assign) BOOL testResult;
@end

@implementation OCSPTestSuite

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
    
    if ( ![self isPass] ) {
        
        NSString *message = (self.errorMessage) ? self.errorMessage : @"Unspecified Acceptance Test Failure";
        
        [self.assertRecorder recordFailWithTestCase:self message:message];
        
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
    
    if (self.testName == nil) {
        
        self.testName = NSStringFromSelector(anInvocation.selector);
        
        NSArray *values = results[self.testName];
        
        self.testResult = [values[0] boolValue];
        
        self.errorMessage = (NSString*) values[1];
        
        self.assertRecorder = (NSString*) values[2];
        
    }
    
    if  ( anInvocation.selector == NSSelectorFromString(self.testName) ) {
        
        anInvocation.selector = @selector(run);
        
    }
    
    [anInvocation invokeWithTarget:self];
    
}

#pragma mark -- Experimental Dev

static NSMutableDictionary<NSString*,NSArray*> *results;

+ (void)initialize {
    
    [super initialize];
    
}

+ (NSArray *)testInvocations {
    
    NSMutableArray *invocations = [[NSMutableArray alloc] init];
    
    XCTestSuite *suite = [OCSPPrincipalTestObserver testSuite];
    
    NSMutableDictionary * allResults = [[NSMutableDictionary alloc] init];
    
    [[suite tests] enumerateObjectsUsingBlock:^(__kindof OCSPTestSuite * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray *values = @[@(obj.testResult), obj.errorMessage, obj.assertRecorder];
        
        allResults[NSStringFromSelector(obj.invocation.selector)] =  values;
        
        [invocations addObject:[obj invocation]];
        
    }];
    
    
    results = [[NSDictionary alloc] initWithDictionary:allResults];
    
    return invocations;

}

@end


