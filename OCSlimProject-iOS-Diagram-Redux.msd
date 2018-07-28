#//# --------------------------------------------------------------------------------------
#//# Created using Sequence Diagram for Mac
#//# https://www.macsequencediagram.com
#//# https://itunes.apple.com/gb/app/sequence-diagram/id1195426709?mt=12
#//# --------------------------------------------------------------------------------------
participant App as xcodebuild
participant "Acceptance Test Target (iOS)" as atest
participant "Acceptance Test Unit Tests Target" as utest
participant "OCSlimProject" as ocsp
participant FitNesse as Fit

# Xcodebuild Test Phase
*-> xcodebuild: Test 
xcodebuild->atest: Build
atest->utest: Build / Test
activate utest

# OCSlimProject
activate ocsp 
utest->ocsp: Run Script Phase

# Fitnesse
ocsp->Fit: Launch
activate Fit
Fit->Fit: Running (http://localhost:8080)
ocsp->Fit: Run Test Suite
Fit->ocsp: RunTestTargetWithSlimPort:<PORT>
loop [wait for slim server]
Fit->Fit: Listen for <PORT>
end

# iPhoneimulator
ocsp->atest: Launch On Simulator args <PORT>
activate atest
atest->atest: Start Slimserver

# Cslim
loop [Run Test Pages]
Fit->atest: Execute Test (cslim)
atest->xcodebuild: Fixture Call
xcodebuild->atest: Result
atest->Fit: Result (cslim)
end

# Report Generate
Fit-> atest: Terminate
deactivate atest
Fit->Fit: Generate JUnit Report
fit->ocsp: JUnit XML
ocsp->utest: Write XML to Bundle
ocsp->Fit: terminate
ocsp->utest: Exit 0
deactivate Fit
deactivate ocsp

# XCTest Junit Parsing
utest->utest: Start XCTest
utest->utest: Parse XML -> XCTestSuite
utest->xcodebuild: XCTestCase Pass/Fail
deactivate utest


