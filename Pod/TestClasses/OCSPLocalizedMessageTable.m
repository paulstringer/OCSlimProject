#import "OCSPLocalizedMessageTable.h"

@implementation OCSPLocalizedMessageTable

+ (NSString*) localizedEmptyTestSuiteMessageWithSuiteName:(NSString *) suiteName {

    return [self localizedMessageWithKey:@"EmptyTestSuiteErrorMessage"
                                argument:suiteName];
    
}

+ (NSString *)localizedTestPageMessageWithUnderlyingMessage:(NSString *) underlyingMessage {
    
    return [self localizedMessageWithKey:@"TestPageErrorMessage"
                                argument:underlyingMessage];
    
}

+ (NSString *)localizedTestSuiteParsingErrorMessage {
    
    return [self localizedMessageWithKey:@"TestSuiteParsingErrorMessage" argument:nil];
}

+ (NSString *)localizedMessageWithKey:(NSString*)key argument:(NSString*)arg {
    
    NSString *localizedString = NSLocalizedStringFromTableInBundle(key, nil, [NSBundle bundleForClass:[self class]], nil);
    
    NSString *message = [NSString stringWithFormat:localizedString, arg, nil];
    
    return message;
}

@end
