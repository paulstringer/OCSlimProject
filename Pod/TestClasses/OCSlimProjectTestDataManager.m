#import "OCSlimProjectTestDataManager.h"
#import "OCSlimFitnesseTestReportReader.h"

@implementation OCSlimProjectTestDataManager

static NSBundle *_bundle;

+ (void)initialize {
    
    _bundle = [NSBundle bundleForClass:self];
    
}

+ (NSString *)failedResultPath {
    
    NSString *path = [_bundle pathForResource:@"SuiteTestResultFailures" ofType:@"xml"];
    
    NSParameterAssert(path);
    
    return path;
    
}

+ (NSData *)failedResultData {
    
    return [NSData dataWithContentsOfFile:[self failedResultPath]];
    
}

+ (NSString *)successResultPath {
    
    NSString *path = [_bundle pathForResource:@"SuiteTestResultSuccess" ofType:@"xml"];
    
    NSParameterAssert(path);
    
    return path;
    
}

+ (NSData *)successResultData {
    
    return [NSData dataWithContentsOfFile:[self successResultPath]];
    
}

+ (NSData *)fitnesseTestReportData {
    
    NSString  *fitnesseReportPath = [_bundle pathForResource:@"Fitnesse-Test-Report" ofType:@"xml"];
    
    return [NSData dataWithContentsOfFile: fitnesseReportPath];
    
}

@end


/// OCSlimFitnesseTestReportReaderStub ///

@interface OCSlimFitnesseTestReportReaderStub : NSObject <OCSlimFitnesseTestReportReader>

@property (nonatomic, strong) NSData *data;

- (id)initWithData:(NSData*)data;

@end

@implementation OCSlimFitnesseTestReportReaderStub

- (id)initWithData:(NSData*)data {
    
    if (self = [super init] ) {
        
        _data = data;
    }
    
    return self;
}

- (NSData *)read {
    
    return self.data;
}

@end


NSData* createDefaultTestReportReaderWithDataAtFilePath(NSString *path) {
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    id<OCSlimFitnesseTestReportReader> reader = [[OCSlimFitnesseTestReportReaderStub alloc] initWithData:data];
    
    [OCSlimFitnesseTestReportCenter setDefaultReader: reader];
    
    return data;
    
}