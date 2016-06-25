import Foundation

@objc class OCSlimFitnesseTestReportCenter: NSObject {
    
    static var defaultReader: OCSlimFitnesseTestReportReader  = OCSlimFitnesseTestReportFileReaderTests()
    
}

@objc protocol OCSlimFitnesseTestReportReader {
    
    func read() -> NSData
    
}

class OCSlimFitnesseTestReportFileReaderTests: NSObject, OCSlimFitnesseTestReportReader {
    
    func read() -> NSData {
        
        let bundle = NSBundle(forClass: OCSlimFitnesseTestReportFileReaderTests.self)
        
        let path = bundle.pathForResource("Fitnesse-Test-Report", ofType: "xml")!
        
        return NSData(contentsOfFile: path)!
        
    }
    
}

class OCSlimFitnesseTestReportReaderStub: NSObject, OCSlimFitnesseTestReportReader {
    
    private let data: NSData
    
    init(data: NSData) {
        self.data = data
        super.init()
    }
    
    func read() -> NSData {
        
        return data
        
    }
    
}