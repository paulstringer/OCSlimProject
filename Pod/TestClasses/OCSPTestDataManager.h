#import <Foundation/Foundation.h>

@interface OCSPTestDataManager : NSObject

+ (NSData *)failedResultData;

+ (NSData *)successResultData;

+ (NSData *)successResultDataByAppendingHyphenatedFilenameModifier:(NSString *)modifier;

+ (NSData *)fitnesseTestReportData;

void createDefaultTestReportReaderWithData(NSData *data);

@end


