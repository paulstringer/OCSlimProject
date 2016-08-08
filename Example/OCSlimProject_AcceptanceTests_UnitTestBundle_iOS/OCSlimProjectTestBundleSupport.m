//
//  OCSlimProjectTestBundleSupport.m
//  OCSlimProjectTestBundleSupport
//
//  Created by OCSlimProject on 25/07/2016.
//  © MIT Licence
//

#if __has_include(<OCSlimProjectTestBundleSupport/OCSlimProjectFitnesseTestsMain.h>)
#else
#pragma GCC error "'OCSlimProjectTestBundleSupport' pod was not found. Add the entry \"\
target 'OCSlimProject_AcceptanceTests_UnitTestBundle_iOS' do \
pod 'OCSlimProjectTestBundleSupport' \
end\"\
to your Podfile configuration."
#endif