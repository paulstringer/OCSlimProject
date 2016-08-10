#import "OCSPTestReportReader.h"

@implementation OCSPTestReportFileReader

- (NSData *) read {
    
    NSString *fitnesseTestReportResourceName = @"Fitnesse-Test-Report";
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *path = [bundle pathForResource:fitnesseTestReportResourceName ofType:@"xml"];
    
    NSLog(@"[OCSP] INFO: Fitnesse test report output path = %@", path);
    
    if (path == nil ) {
       
        NSLog(@"[OCSP] WARNING: The %@.xml file is missing. Check your 'OCSlimProject' Acceptance Test target is being built. 1) Try running 'pod update' to resolve this issue. 2) Manually run Acceptance Tests using the utility 'LaunchFitnesse' located at your projects root directory and investigate any issues.", fitnesseTestReportResourceName, nil);
        
    }
    
    return [NSData dataWithContentsOfFile:path];
    
}

@end


/// OCSPTestReportReader ///

@implementation OCSPTestReportReader

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



