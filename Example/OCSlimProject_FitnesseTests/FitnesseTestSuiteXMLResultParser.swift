//
//  FitnesseTestSuiteXMLResultParser.swift
//  OCSlimProject
//
//  Created by Paul Stringer on 22/06/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

class FitnesseTestSuiteXMLResultParser: XCTestCase, NSXMLParserDelegate {
    
    var failedTestSuiteCount = 0
    
    func assertResultWithJUnitTestSuiteData(data: NSData) {
        let result = resultForTestSuiteXMLData(data)
        XCTAssertTrue(result)
    }

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
}
