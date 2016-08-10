#import <Foundation/Foundation.h>

@interface OCSPTestCaseReport : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) BOOL passed;

@property (nonatomic, strong) NSString *errorMessage;

- (nonnull id)initWithTestCaseName:(nonnull NSString *)name result:(BOOL)result;

@end



