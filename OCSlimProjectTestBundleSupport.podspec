#
#  Be sure to run `pod spec lint OCSlimProjectTestBundleSupport.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "OCSlimProjectTestBundleSupport"
  s.version      = "1.3"
  s.summary      = "Integrate Fitnesse with XCTest to provide running and reporting of fast Fitnesse based BDD/Acceptance Tests right from within Xcode."
  s.description  = <<-DESC
  OCSlimProjectTestBundleSupport enables OSX and iOS Unit Test targets to dynamically run test suites that run and display the results of Fitnesse based Acceptance Tests conveniently right within Xcode.
  Use together with 'OCSlimProject' for fast, rock-solid, non UI based acceptance testing that integrates seamlessly with both Xcode development and CI environments.
                   DESC

  s.homepage     = "http://paulstringer.github.io/OCSlimProject"
  s.documentation_url = 'http://paulstringer.github.io/OCSlimProject'
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  # ――― Licence ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  s.license      = { :type => "MIT", :file => "LICENSE" }

  # ――― Author ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  s.author             = { "Paul Stringer" => "paulstringer@mac.com" }
  s.social_media_url   = "http://twitter.com/paulstringer"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/paulstringer/OCSlimProject.git", :tag => s.version.to_s }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "Pod/TestClasses/**/*.{h,m}"
  s.exclude_files = "Pod/TestClasses/*Test{s,able}.{h,m}"
  s.public_header_files = "Pod/TestClasses/OCSPTestSuite.h"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.resources = "Pod/Resources/*.lproj"
  s.framework  = "XCTest"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  s.user_target_xcconfig =  { 'OCSP_TEST_REPORT_FILE_NAME' => 'Fitnesse-Test-Report.xml', 'OCSP_SUPPORT_FILE_DIR' => "${PODS_ROOT}/OCSlimProject/Pod/Support/SharedSupport"}
  s.osx.user_target_xcconfig = { 'OCSP_TEST_REPORT_FILE_PATH' => "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${OCSP_TEST_REPORT_FILE_NAME}" }
  s.ios.user_target_xcconfig = { 'OCSP_TEST_REPORT_FILE_PATH' => "${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${OCSP_TEST_REPORT_FILE_NAME}" }

  s.platforms = { ios: "9.0", osx: "10.8" }
  

end
