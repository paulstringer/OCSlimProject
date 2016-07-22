#import <Foundation/Foundation.h>

@interface OCSPJUnitXMLParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, readonly) NSUInteger testCaseCount;

- (nonnull id)initWithXMLData:(nonnull NSData *) data;

- (void) parse;

- (BOOL) result;

- (nullable NSString *) testNameForTestCaseAtIndex:(NSUInteger)index;

- (BOOL) testResultForTestCaseAtIndex:(NSUInteger)index;

@end
