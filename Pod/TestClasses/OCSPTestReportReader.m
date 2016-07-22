#import "OCSPTestReportReader.h"

@implementation OCSPTestReportFileReader

- (NSData *) read {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *path = [bundle pathForResource:@"Fitnesse-Test-Report" ofType:@"xml"];
    
    NSAssert(path != nil, @"Fitnesse-Test-Report.xml file is missing. Check the setup of your Test target... (provide further details to make this a more useful message)");
    
    return [NSData dataWithContentsOfFile:path];
    
}

@end


/// OCSlimFitnesseTestReportCenter ///

@implementation OCSPTestReportCenter

static id<OCSPTestReportReader> _defaultReader;

+ (id<OCSPTestReportReader>)defaultReader {
    
    return _defaultReader;
    
}

+ (void)initialize {
    
    _defaultReader = [[OCSPTestReportFileReader alloc] init];
    
}

+ (void)setDefaultReader:(id<OCSPTestReportReader>)reader {
    
    _defaultReader = reader;
    
}


@end



