import XCTest


// Fitnesse Launched as Pre Script in Test Phase
// Test Setup Runslocalhost:8080?Suite&format=junit
// Results Gathered into an XML File
// For Each TestCase element instantiate an XCTestCase

class FitnesseTestSuiteXMLResultParserTests: XCTestCase, XCTestObservation {
    
    let test = FitnesseTestSuiteXMLResultParser()
    
    let bundle = NSBundle(forClass: FitnesseTestSuiteXMLResultParser.self)
    var failedResultPath: String!
    var successResultPath: String!
    
    override func setUp() {
        failedResultPath = bundle.pathForResource("SuiteTestResultFailures", ofType: "xml")
        successResultPath = bundle.pathForResource("SuiteTestResultSuccess", ofType: "xml")
    }
    
    func testSuiteJUnitXMLFailureWillFail() {
        let data = NSData(contentsOfFile: failedResultPath)!
        XCTAssertFalse(test.resultForTestSuiteXMLData(data))
    }
    
    func testSuiteJUnitXMLSuccessWillPass() {
        let data = NSData(contentsOfFile: successResultPath)!
        XCTAssertTrue(test.resultForTestSuiteXMLData(data))
    }

    
}
