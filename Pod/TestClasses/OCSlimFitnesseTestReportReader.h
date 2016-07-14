#import <Foundation/Foundation.h>

@protocol OCSlimFitnesseTestReportReader <NSObject>
    
- (NSData * _Nonnull) read;
    
@end


@interface OCSlimFitnesseTestReportCenter : NSObject

+ (id<OCSlimFitnesseTestReportReader> _Nonnull) defaultReader;

+ (void)setDefaultReader:(id<OCSlimFitnesseTestReportReader> _Nonnull)reader;

@end


/// OCSlimFitnesseTestReportFileReaderTests (Rename this) ///

@interface OCSlimFitnesseTestReportFileReaderTests : NSObject <OCSlimFitnesseTestReportReader>

@end