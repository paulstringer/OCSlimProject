#import "FitnesseTestSuiteXMLResultParser.h"

@interface FitnesseTestSuiteXMLResultParser () <NSXMLParserDelegate>

@property (nonatomic, assign) NSUInteger failedTestSuiteCount;

@end

@implementation FitnesseTestSuiteXMLResultParser

- (BOOL) resultForTestSuiteXMLData:(NSData *) data  {
    
    [self parseTestSuiteXMLData:data];
    
    return self.failedTestSuiteCount == 0;
    
}

//MARK: Parsing Private Helpers

- (void) parseTestSuiteXMLData:(NSData*) data {
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    parser.delegate = self;
    
    [parser parse];
    
}

- (void) parseTestSuiteFailuresForElementAttributes:(NSDictionary*)attributesDict {
    
    NSUInteger failuresCount = [[attributesDict objectForKey:@"failures"] integerValue];
    
    self.failedTestSuiteCount += failuresCount;
    
}

//MARK: NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    [NSException exceptionWithName:parseError.localizedDescription reason:parseError.localizedFailureReason userInfo:parseError.userInfo];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict {
    
    [self parseTestSuiteFailuresForElementAttributes:attributeDict];
    
}

@end
