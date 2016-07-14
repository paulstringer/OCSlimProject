import Foundation

class FitnesseTestSuiteXMLResultParser: NSObject, NSXMLParserDelegate {
    
    var failedTestSuiteCount = 0
    
    internal func resultForTestSuiteXMLData(data: NSData) -> Bool {
        parseTestSuiteXMLData(data)
        return failedTestSuiteCount == 0
    }
    
    //MARK: Parsing Helpers
    
    private func parseTestSuiteXMLData(data: NSData) {
        let parser = NSXMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    private func parseTestSuiteFailuresForElementAttributes(attributes attributeDict: [String: String]) {
        if let failuresCount = attributeDict["failures"] {
            failedTestSuiteCount += Int(failuresCount)!
        }
    }
    
    //MARK: NSXMLParserDelegate
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        parseTestSuiteFailuresForElementAttributes(attributes: attributeDict)
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
        fatalError(parseError.localizedDescription)
    }
}
