#import <XCTest/XCTest.h>
#import "OCSlimFitnesseTestReportReader.h"
#import "OCSlimProjectTestDataManager.h"
#import "OCSlimFitnesseTestReportReader.h"

@interface OCSlimFitnesseTestReportReaderTests : XCTestCase

@property (nonatomic, strong) OCSlimFitnesseTestReportFileReaderTests* reader;
@end

@implementation OCSlimFitnesseTestReportReaderTests

- (void)setUp {
    [super setUp];
    
    self.reader = [[OCSlimFitnesseTestReportFileReaderTests alloc] init];
    
}

- (void)tearDown {
    
    self.reader = nil;
    
    [super tearDown];
}

- (void) testReaderDataEqualsFitnesseReportFileData {

    NSData *data = [OCSlimProjectTestDataManager fitnesseTestReportData];
    
    NSData *readData = [self.reader read];
    
    XCTAssertTrue([data isEqualToData:readData]);
}

@end
