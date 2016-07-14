#
# Be sure to run `pod lib lint OCSlimProject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "OCSlimProject"
  s.version          = "1.2"
  s.summary          = "Lightweight Xcode Project wrapper of cslim to help you get setup writing fast, rock solid, non UI based Acceptance Tests using Fitnesse"
  s.description      = <<-DESC
  OCSlimProject is a lightweight wrapper around a collection of scripts that automates the steps of creating 'ocslim' 
  based Xcode Projects for testing using Fitnesse. These tools help you write rock solid, non UI based 
  acceptance tests for your Mac or iOS application.
                       DESC

  s.homepage         = "https://github.com/paulstringer/OCSlimProject"
  s.license          = 'MIT'
  s.author           = { "Paul Stringer" => "paulstringer@mac.me" }
  s.source           = { :git => "https://github.com/paulstringer/OCSlimProject.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/paulstringer'

  s.dependency 'cslim'
#  s.dependency 'cslim', :path => "../../ObjectiveCSlim/cslim"
  s.source_files = 'Pod/Classes/**'
  
  s.osx.resource_bundles = {
    'OCSlimProject-Mac' => ['Pod/Support/OSX/*', 'Pod/Support/SharedSupport/*']
  }
  s.ios.resource_bundles = {
    'OCSlimProject' => ['Pod/Support/iOS/*', 'Pod/Support/SharedSupport/*']
  }

  s.osx.user_target_xcconfig = { 'OCSLIMPROJECT_BUNDLE_RESOURCES_DIR' => '${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/OCSlimProject-Mac.bundle/Contents/Resources' }
  s.ios.user_target_xcconfig = { 'OCSLIMPROJECT_BUNDLE_RESOURCES_DIR' => '${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/OCSlimProject.bundle' }
 
end