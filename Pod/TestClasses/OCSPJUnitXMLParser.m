#import "OCSPJUnitXMLParser.h"

@interface OCSPJUnitXMLParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *testSuiteName;
@property (nonatomic, assign) NSUInteger testCaseCount;
@property (nonatomic, assign) NSUInteger failedTestSuiteCount;
@property (nonatomic, assign) BOOL parseErrorOccured;
@property (nonatomic, strong) NSMutableArray<NSString *> *testCaseNames;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *testCaseResults;
@property (nonatomic, strong) NSMutableArray<id> *testErrorMessages;

@end

@implementation OCSPJUnitXMLParser

NSError *__autoreleasing * outErrorRef;

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


- (NSString *) testNameForTestCaseAtIndex:(NSUInteger)index {
    
    return (index < self.testCaseNames.count) ? self.testCaseNames[index] : nil;
    
}

- (BOOL)testResultForTestCaseAtIndex:(NSUInteger)index {
    
    return [self.testCaseResults[index] boolValue];
    
}

- (nullable NSString *)testErrorMessageForTestCaseAtIndex:(NSUInteger)index {
    
    NSObject *object = self.testErrorMessages[index];
    
    return ([[NSNull null] isEqual:object]) ? nil : (NSString *)object;
    
}

//MARK: NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    self.parseErrorOccured = YES;

    self.testSuiteName = @"NotFound";
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"testsuite"]) {
        
        self.testSuiteName = attributeDict[@"name"];
        
        [self takeTestCaseCountFromElementAttributes:attributeDict];
    
        [self parseTestSuiteFailuresForElementAttributes:attributeDict];
        
    }
    
    if ([elementName isEqualToString:@"testcase"]) {
        
        [self takeTestCaseNameFromElementAttributes:attributeDict];
        
        [self appendPassTestResult];
        
        [self appendNullTestErrorMessage];
    }
    
    if ([elementName isEqualToString:@"failure"]) {
        
        [self updateTestResultFailFromElementAttributes:attributeDict];
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


- (void)appendPassTestResult {
    
    if (!self.testCaseResults) {
        
        self.testCaseResults = [NSMutableArray arrayWithObject:@YES];
        
    } else {
        
        [self.testCaseResults addObject:@YES];
    }
    
}

- (void)appendNullTestErrorMessage {
    
    if (!self.testErrorMessages) {
        
        self.testErrorMessages = [NSMutableArray arrayWithObject:[NSNull null]];
        
    } else {
        
        [self.testErrorMessages addObject:[NSNull null]];
    }
    
}

- (void)updateTestResultFailFromElementAttributes:(NSDictionary *)attributeDict {
    
    NSUInteger lastTestResultIndex = [self.testCaseResults indexOfObject:self.testCaseResults.lastObject];
    
    [self.testCaseResults replaceObjectAtIndex:lastTestResultIndex withObject:@NO];
    
    
    NSString *message = attributeDict[@"message"];
    
    [self.testErrorMessages replaceObjectAtIndex:lastTestResultIndex withObject:message];
    
}
@end
