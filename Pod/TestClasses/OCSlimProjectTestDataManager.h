#import <Foundation/Foundation.h>

@interface OCSlimProjectTestDataManager : NSObject

+ (NSData *)failedResultData;

+ (NSData *)successResultData;

+ (NSData *)successResultDataByAppendingHyphenatedFilenameModifier:(NSString *)modifier;

+ (NSData *)fitnesseTestReportData;

void createDefaultTestReportReaderWithData(NSData *data);

@end


