#import <Foundation/Foundation.h>

@interface OCSPJUnitXMLParser : NSObject <NSXMLParserDelegate>

- (BOOL) resultForTestSuiteXMLData:(NSData *) data;

- (NSInteger) testCaseCountForXMLData:(NSData *) data;

@end
