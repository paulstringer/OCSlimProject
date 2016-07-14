#import "OCSlimFitnesseTestReportReader.h"

@implementation OCSlimFitnesseTestReportFileReader

- (NSData *) read {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *path = [bundle pathForResource:@"Fitnesse-Test-Report" ofType:@"xml"];
    
    NSAssert(path != nil, @"Fitnesse-Test-Report.xml file is missing. Check the setup of your Test target... (provide further details to make this a more useful message)");
    
    return [NSData dataWithContentsOfFile:path];
    
}

@end


/// OCSlimFitnesseTestReportCenter ///

@implementation OCSlimFitnesseTestReportCenter

static id<OCSlimFitnesseTestReportReader> _defaultReader;

+ (id<OCSlimFitnesseTestReportReader>)defaultReader {
    
    return _defaultReader;
    
}

+ (void)initialize {
    
    _defaultReader = [[OCSlimFitnesseTestReportFileReader alloc] init];
    
}

+ (void)setDefaultReader:(id<OCSlimFitnesseTestReportReader>)reader {
    
    _defaultReader = reader;
    
}


@end



