#import <iMoMacros.h>
#import <uaunbox/uaunbox.h>
#import "UIAlertView+Blocks.h"

#define UCLocalize(key) UCLocalizeEx(@ key)

@interface NSString ( containsCategory )
- (BOOL) containsString: (NSString*) substring;
@end

@implementation NSString ( containsCategory )
- (BOOL) containsString: (NSString*) substring
{    
    NSRange range = [self rangeOfString : substring];
    BOOL found = ( range.location != NSNotFound );
    return found;
}
@end

static void removeFile(NSString *srcPath) {

    [[UBClient sharedInstance] deleteFile:srcPath];
}

@interface Package : NSObject
- (NSString *) id;
@end

// basic code ( i didn't finish it because i have another projects works on / use it but don't forget to credit me ;P )

%hook Cydia
- (void) removePackage:(Package *)package {
	%orig;
	NSString *prefsPathFromPackage = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", package.id];
	// NSString *prefsRootPathFromPackage = [NSString stringWithFormat:@"/var/root/Library/Preferences/%@.plist", package.id]; // do it yourself
	if ([prefsPathFromPackage containsString:package.id] && [prefsPathFromPackage hasSuffix:@".plist"]) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	            [UIAlertView showWithTitle:@"OldPrefsRemover" 
                    message:[NSString stringWithFormat:@"Preference File Found \n%@\n Would you like to remove them ?", prefsPathFromPackage]
                    style:nil
                    cancelButtonTitle:UCLocalize("CANCEL")
                    otherButtonTitles:@[UCLocalize("REMOVE")]
                    tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
                        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
                        if ([title isEqualToString:UCLocalize("REMOVE")]) {

                        }
                    }];
		});
	}
}
%end