#import <XCTest/XCTest.h>
#import "OCSPTestReportReader.h"
#import "OCSPTestDataManager.h"
#import "OCSPTestReportReader.h"

@interface OCSPTestReportReaderTests : XCTestCase

@property (nonatomic, strong) OCSPTestReportFileReader* reader;
@end

@implementation OCSPTestReportReaderTests

- (void)setUp {
    [super setUp];
    
    self.reader = [[OCSPTestReportFileReader alloc] init];
    
}

- (void)tearDown {
    
    self.reader = nil;
    
    [super tearDown];
}

- (void)testFitnesseReportFileDataExists {
    
    XCTAssertNotNil([OCSPTestDataManager fitnesseTestReportData]);
    
}
- (void) testReaderDataEqualsFitnesseReportFileData {

    NSData *data = [OCSPTestDataManager fitnesseTestReportData];
    
    NSData *readData = [self.reader read];
    
    XCTAssertTrue([data isEqualToData:readData]);
}

@end
