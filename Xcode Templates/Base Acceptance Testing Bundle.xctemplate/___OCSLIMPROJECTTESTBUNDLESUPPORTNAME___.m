//
//  ___FILENAME___
//  ___OCSLIMPROJECTTESTBUNDLESUPPORTNAME___
//
//  Created by OCSlimProject on ___DATE___.
//  © MIT Licence
//

#if __has_include(<OCSlimProjectTestBundleSupport/OCSlimProjectFitnesseTestsMain.h>)
#else
#pragma GCC error "'___OCSLIMPROJECTTESTBUNDLESUPPORTNAME___' pod was not found. Add the entry \"\
target '___PACKAGENAMEASIDENTIFIER___' do \
pod '___OCSLIMPROJECTTESTBUNDLESUPPORTNAME___' \
end\"\
to your Podfile configuration."
#endif

/* Copy and paste this entry to your projects Podfile and run 'pod install' or 'pod update' as necessary

 target '___PACKAGENAMEASIDENTIFIER___' do
    platform :___POD_PLATFORM___
    pod '___OCSLIMPROJECTTESTBUNDLESUPPORTNAME___'
 end

*/