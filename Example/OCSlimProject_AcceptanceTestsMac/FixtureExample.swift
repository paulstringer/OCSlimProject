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

        // Logging Examples
        
        print("Swift print() (OSX only)")
        NSLog("NSLog() statement (recommended)")

        // os_log is unsupported

        if #available(OSX 10.12, *) {
            os_log("*WARNING* os_log() statements such as this one are not captured on OS X")
        }

        return true
    }
    
}
