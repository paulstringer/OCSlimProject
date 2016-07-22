#import "OCSPJUnitXMLParser.h"

@interface OCSPJUnitXMLParser () <NSXMLParserDelegate>

@property (nonatomic, assign) NSUInteger testCaseCount;
@property (nonatomic, assign) NSUInteger failedTestSuiteCount;

@end

@implementation OCSPJUnitXMLParser

- (BOOL) resultForTestSuiteXMLData:(NSData *) data  {
    
    [self parseTestSuiteXMLData:data];
    
    return self.failedTestSuiteCount == 0;
    
}

- (NSInteger)testCaseCountForXMLData:(NSData *)data {
    
    [self parseTestSuiteXMLData:data];
    
    return self.testCaseCount;
}

//MARK: Parsing Private Helpers

- (void) parseTestSuiteXMLData:(NSData*) data {
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    parser.delegate = self;
    
    [parser parse];
    
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
    
}

- (void) takeTestCaseCountFromElementAttributes:(NSDictionary*)attributesDict {
    
    NSUInteger count = [[attributesDict objectForKey:@"tests"] integerValue];
    
    self.testCaseCount = count;
    
    
}

- (void) parseTestSuiteFailuresForElementAttributes:(NSDictionary*)attributesDict {
    
    NSUInteger failuresCount = [[attributesDict objectForKey:@"failures"] integerValue];
    
    self.failedTestSuiteCount += failuresCount;
    
}


@end
