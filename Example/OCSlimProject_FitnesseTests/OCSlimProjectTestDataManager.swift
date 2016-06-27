import Foundation

public class OCSlimProjectTestDataManager : NSObject{
    
    let bundle = NSBundle(forClass: OCSlimProjectTestDataManager.self)
    
    let failedResultPath: String
    let successResultPath: String
    let failedResultData: NSData
    let successResultData: NSData
    let fitnesseTestReportData: NSData
    
    override public init() {

        self.failedResultPath = bundle.pathForResource("SuiteTestResultFailures", ofType: "xml")!
        
        self.failedResultData = NSData(contentsOfFile:self.failedResultPath)!
        
        
        self.successResultPath = bundle.pathForResource("SuiteTestResultSuccess", ofType: "xml")!
        
        self.successResultData = NSData(contentsOfFile:self.successResultPath)!
        
        
        let fitnesseReportPath = bundle.pathForResource("Fitnesse-Test-Report", ofType: "xml")!
        
        self.fitnesseTestReportData = NSData(contentsOfFile: fitnesseReportPath)!

    }
    
}
