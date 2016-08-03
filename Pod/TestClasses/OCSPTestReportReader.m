#import "OCSPTestReportReader.h"

@implementation OCSPTestReportFileReader

- (NSData *) read {
    
    
    NSString *fitnesseTestReportResourceName = @"Fitnesse-Test-Report";
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *path = [bundle pathForResource:fitnesseTestReportResourceName ofType:@"xml"];
    
    NSLog(@"[OCSP] INFO: Fitnesse test report output path = %@", path);
    
    if (path == nil ) {
       
        NSLog(@"[OCSP] WARNING: The %@.xml file is missing. Check your 'OCSlimProject' Acceptance Test target is being built. 1) Check you're able to run Acceptance Tests using the command line utility 'LaunchFitnesse' located at your projects root directory. 2) Check this targets Run Script build phase for usage of LaunchFitnesse which generates the %@ file.", fitnesseTestReportResourceName, fitnesseTestReportResourceName, nil);
        
    }
    
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



