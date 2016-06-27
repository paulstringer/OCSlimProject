import XCTest

public class OCSlimProjectFitnesseTestSuite: XCTestSuite {
    
    static let suiteName = NSStringFromClass(OCSlimProjectFitnesseTestSuite.self).componentsSeparatedByString(".").last!
    
    override init() {
        super.init(name: OCSlimProjectFitnesseTestSuite.suiteName)
    }
    
}