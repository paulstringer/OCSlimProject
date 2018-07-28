#//# --------------------------------------------------------------------------------------
#//# Created using Sequence Diagram for Mac
#//# https://www.macsequencediagram.com
#//# https://itunes.apple.com/gb/app/sequence-diagram/id1195426709?mt=12
#//# --------------------------------------------------------------------------------------
participant App as xcodebuild
participant "Acceptance Test Target" as atest
participant "unit test bundle" as utest
participant "generate-fitnesse-test-report.sh" as genfit
participant "LaunchFitnesse.sh" as lfit
participant FitNesse as Fit
participant RunTestsTargetWithSlimPort as slim
participant "ios-sim" as iossim
participant iphonesimulator as iPhone
*-> xcodebuild: Test
xcodebuild->atest: Build
xcodebuild->utest: Test
utest->genfit: Run Script
genfit->lfit: Test
activate lfit
	lfit->lfit: check java installed
	lfit->lfit: check fitnesse installed
	opt [ first run ]
		lfit->lfit: Copy FitNesseRoot
	end
	activate Fit
	lfit->Fit: java -jar fitnesse.jar
	Fit->Fit: Initialise
	loop [ wait ]
		lfit->Fit: "curl localhost:8080"
	end #end loop
	lfit->Fit: curl localhost/TestPageName?suite&format=junit
	activate slim
	fit->slim: Run
	slim->slim: Check Node
	slim->slim: Check ios-sim
	slim->iossim: launch
	loop [ wait ]
		note over slim
	"""
	Could hang! 💥
	"""
		end note
	iossim->iPhone: Acceptance Test App Install
	iPhone->atest: Launch
	atest->atest: Start Slimserver
	slim->slim: Wait for app launch
	Fit->atest: Slimserver Detected | Run Suite
	atest->Fit: Do Work
	Fit-> atest: Terminate
	slim->slim: Wait for app terminated

	end

	deactivate slim
	
	fit->lfit: junit xml
	lfit->utest: write junit xml
	
	alt [ suite test runtime error ]
	fit->fit: write error log file
	end
	
	lfit->Fit: terminate
	
	deactivate Fit
	
deactivate lfit

alt [ test report junit file exists ]

	utest->utest: parse junit to xctest suite
	utest->utest: run xctestsuite reporting pass / fails
	utest->xcodebuild: Pass / Fail
	
else [test report missing or not junit xml]

	utest->xcodebuild: throw exception
	
end





