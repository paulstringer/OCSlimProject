import Foundation
import os.log

@objc(FixtureExample)

class FixtureExample : NSObject, SlimDecisionTable {
    
    //MARK: Inputs
    
    var input = ""
    
    //MARK: <SlimDecisionTable>
    
    func execute() {
        // 1. Prepare a System Under Test (SUT) using the given inputs.
        // e.g. let system = MySystemUnderTestContext(input: input)
        // 2. Run your SUT
        // 3. Take values from the SUT and return via outputs
    }
    
    //MARK: Outputs
    
    var output: NSString? {
        get {
            switch input {
            case "foo":
                return "bar"
            case "bar":
                return "baz"
            default:
                return nil
            }
        }
    }

    //MARK: Calling Methods

    func log() -> Bool {

        // Use Swift print to log statements on OS X (recommended)
        print("Swift print() log statement (OSX only)")

        // *WARNING* NSLog will direct to stderr on OS X which results in a build being marked as a failure. Use print() instead
        // NSLog("NSLog() statements (directs to standard error output)")

        // os_log is unsupported for logging and will not be reprted
        os_log("*WARNING* os_log() statements not supported on OS X")

        return true
    }
    
}
