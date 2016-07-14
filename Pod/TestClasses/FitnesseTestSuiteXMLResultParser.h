#import <Foundation/Foundation.h>

@interface FitnesseTestSuiteXMLResultParser : NSObject <NSXMLParserDelegate>

- (BOOL) resultForTestSuiteXMLData:(NSData *) data;

@end
