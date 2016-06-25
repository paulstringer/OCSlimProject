import XCTest

// Fitnesse Launched as Pre Script in Test Phase
// Test Setup Runslocalhost:8080?Suite&format=junit
// Results Gathered into an XML File
// For Each TestSuite.TestCase element instantiate an XCTestCase

class FitnesseTestSuiteXMLResultParserTests: XCTestCase, XCTestObservation {
    
    let test = FitnesseTestSuiteXMLResultParser()
    let testData = OCSlimProjectTestDataManager()
    
    func testSuiteJUnitXMLFailureWillFail() {
        let data = testData.failedResultData
        XCTAssertFalse(test.resultForTestSuiteXMLData(data))
    }
    
    func testSuiteJUnitXMLSuccessWillPass() {
        let data = testData.successResultData
        XCTAssertTrue(test.resultForTestSuiteXMLData(data))
    }

    
}
