#import "OCSPJUnitXMLParser.h"

@interface OCSPJUnitXMLParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) NSUInteger testCaseCount;
@property (nonatomic, assign) NSUInteger failedTestSuiteCount;
@property (nonatomic, strong) NSMutableArray<NSString *> *testCaseNames;

@end

@implementation OCSPJUnitXMLParser

- (id)initWithXMLData:(nonnull NSData *) data {
    
    if (self == [super init]) {
    
        _data = data;
        
    }
    
    return self;
    
}

- (void)parse {
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.data];
    
    parser.delegate = self;
    
    [parser parse];
    
}

- (BOOL) result {
    
    return self.failedTestSuiteCount == 0;
    
}

- (NSString *) testCaseNameForTestCaseAtIndex:(NSUInteger)index {
    
    return (index < self.testCaseNames.count) ? self.testCaseNames[index] : nil;
    
}

//MARK: NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    [NSException exceptionWithName:parseError.localizedDescription reason:parseError.localizedFailureReason userInfo:parseError.userInfo];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"testsuite"]) {
        
        [self takeTestCaseCountFromElementAttributes:attributeDict];
    
        [self parseTestSuiteFailuresForElementAttributes:attributeDict];
        
    }
    
    if ([elementName isEqualToString:@"testcase"]) {
        
        [self takeTestCaseNameFromElementAttributes:attributeDict];
    }
    
}

- (void) takeTestCaseCountFromElementAttributes:(NSDictionary*)attributesDict {
    
    NSUInteger count = [[attributesDict objectForKey:@"tests"] integerValue];
    
    self.testCaseCount = count;
    
    
}

- (void) parseTestSuiteFailuresForElementAttributes:(NSDictionary*)attributesDict {
    
    NSUInteger failuresCount = [[attributesDict objectForKey:@"failures"] integerValue];
    
    self.failedTestSuiteCount += failuresCount;
    
}

- (void) takeTestCaseNameFromElementAttributes:(NSDictionary*)attributesDict {
    
    NSString* name = (NSString *) attributesDict[@"name"];
    
    if (!self.testCaseNames) {
        self.testCaseNames = [NSMutableArray arrayWithObject:name];
    } else {
        [self.testCaseNames addObject:name];
    }
}


@end
