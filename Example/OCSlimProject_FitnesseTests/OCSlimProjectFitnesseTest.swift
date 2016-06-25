import XCTest

public class OCSlimProjectFitnesseTest: XCTestCase {
    
    func exampleFail() {
        XCTAssertTrue(false)
    }
    
    func examplePass() {
        XCTAssertTrue(true)
    }
    
    func example(assert: Bool) {
        XCTAssertTrue(assert);
    }
    
    static let testSuiteName = NSStringFromClass(OCSlimProjectFitnesseTest.self).componentsSeparatedByString(".").last
    
}