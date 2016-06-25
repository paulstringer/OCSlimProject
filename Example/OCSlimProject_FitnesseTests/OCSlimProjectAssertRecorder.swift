//
//  OCSlimProjectAssertRecorder.swift
//  OCSlimProject
//
//  Created by Paul Stringer on 23/06/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

@objc protocol OCSlimProjectAssertRecorder {
    
    func recordFail()
    func recordPass()
    
}

class OCSlimProjectXCTestAssertRecorder: NSObject, OCSlimProjectAssertRecorder {
    
    func recordFail() {
        XCTFail()
    }
    
    func recordPass() {
        XCTAssertTrue(true)
    }
    
}


class OCSlimProjectAssertRecorderSpy: NSObject, OCSlimProjectAssertRecorder {
    
    var didRecordFail = false
    var didRecordPass = false
    
    func recordFail() {
        didRecordFail = true
    }
    
    func recordPass() {
        didRecordPass = true
    }
}
