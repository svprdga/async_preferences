#import "AsyncPreferencesPlugin.h"
#if __has_include(<async_preferences/async_preferences-Swift.h>)
#import <async_preferences/async_preferences-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "async_preferences-Swift.h"
#endif

@implementation AsyncPreferencesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAsyncPreferencesPlugin registerWithRegistrar:registrar];
}
@end
