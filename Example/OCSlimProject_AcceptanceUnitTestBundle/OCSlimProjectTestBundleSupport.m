//
//  OCSlimProjectTestBundleSupport.m
//  OCSlimProjectTestBundleSupport
//
//  Created by OCSlimProject on 09/08/2016.
//  MIT License
//  © 2016 Paul Stringer
//
//

#if __has_include(<OCSlimProjectTestBundleSupport/OCSPPrincipalTestObserver.h>)
#else
#pragma GCC error "Target requires pod 'OCSlimProjectTestBundleSupport'. Add the entry \"pod 'OCSlimProjectTestBundleSupport'\" to your Podfile configuration."
#endif

/* Copy and paste this entry to your projects Podfile and run 'pod install' or 'pod update' as necessary

 target 'OCSlimProject_AcceptanceUnitTestBundle' do
    platform :ios, 9.0
    pod 'OCSlimProjectTestBundleSupport'
 end
 
  https://cocoapods.org/?q=OCSlimProjectTestBundleSupport

*/