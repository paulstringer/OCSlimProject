import XCTest

class OCSlimFitnesseTestReportReaderTests: XCTestCase {

    let reader = OCSlimFitnesseTestReportFileReaderTests()
    
    func testReaderDataEqualsFitnesseReportFileData() {
        
        let data = OCSlimProjectTestDataManager().fitnesseTestReportData
        
        XCTAssertEqual(data, reader.read())
    }

}
