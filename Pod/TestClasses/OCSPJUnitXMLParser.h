#import <Foundation/Foundation.h>

@interface OCSPJUnitXMLParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, readonly) NSUInteger testCaseCount;

@property (nonatomic, readonly, nonnull) NSString *testSuiteName;

@property (nonatomic, readonly) BOOL parseErrorOccured;

@property (nonatomic, readonly) BOOL parsingSucceeded;

- (nonnull id)initWithXMLData:(nonnull NSData *) data;

- (void) parse;

- (BOOL) result;

- (nullable NSString *) testNameForTestCaseAtIndex:(NSUInteger)index;

- (BOOL) testResultForTestCaseAtIndex:(NSUInteger)index;

- (nullable NSString *) testErrorMessageForTestCaseAtIndex:(NSUInteger)index;

- (nonnull NSString *) testSuiteName;

@end
