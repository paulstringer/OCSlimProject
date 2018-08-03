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

        // Only prints to a running Xcode console
        print("*WARNING* Swift's print function on iOS only print to the Xcode console not to logs.")

        // Use NSLog to print to the system log as a default message type
        NSLog("NSLog() statements")

        // Use os_log (recommended) to print to the system log with the related type
        if #available(iOS 10.0, *) {
            os_log("os_log() .default log statement", type: .default)
            os_log("os_log() .info log statement", type: .info)
            os_log("os_log() .error log statement", type: .error)
            os_log("Log files can be found in the current directory in ./Log/<DATETIME_STAMP>.log", type: .info)
        }
        return true
    }
    
}
