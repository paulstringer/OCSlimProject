import Foundation

@objc(FixtureExample)

class FixtureExample : NSObject, SlimDecisionTable {

    private var fooValue: String?
    private var barValue: String?

    //MARK: Inputs
    @objc
    var input = ""
    
    //MARK: <SlimDecisionTable>
    
    func execute() {
        // 1. Prepare a System Under Test (SUT) using the given inputs.
        // e.g. let system = MySystemUnderTestContext(input: input)
        // 2. Run your SUT
        // 3. Take values from the SUT and return via outputs
        fooValue = "bar"
        barValue = "baz"
    }
    
    //MARK: Outputs
    @objc
    public var output: String? {
        get {
            switch input {
            case "foo":
                return fooValue
            case "bar":
                return barValue
            default:
                return nil
            }
        }
    }
    
}
