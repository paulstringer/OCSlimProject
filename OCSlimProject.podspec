#
# Be sure to run `pod lib lint OCSlimProject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "OCSlimProject"
  s.version          = "1.0.0"
  s.summary          = "Lightweight Xcode Project wrapper of cslim to help you get setup writing fast, rock solid, non UI based Acceptance Tests using Fitnesse"
  s.description      = <<-DESC
  OCSlimProject is a convienient lightweight wrapper around a collection of scripts 
  with some Xcode project glue automating the process of creating 'ocslim' 
  based Apps for use with Fitnesse. These tools help you write rock solid, non UI based 
  acceptance tests for your iOS application.
                       DESC

  s.homepage         = "https://github.com/paulstringer/OCSlimProject"
  s.license          = 'MIT'
  s.author           = { "Paul Stringer" => "paulstringer@mac.me" }
  s.source           = { :git => "https://github.com/paulstringer/OCSlimProject.git", :tag => s.version.to_s }
  s.social_media_url = 'https://uk.linkedin.com/in/paulstringer'

  s.platform     = :ios, '8.0'

  s.source_files = 'Pod/Classes/**'
  s.resource_bundles = {
    'OCSlimProject' => ['Pod/Support/*']
  }
  s.dependency 'cslim'
 
end
