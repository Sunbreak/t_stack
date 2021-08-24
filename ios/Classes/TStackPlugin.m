#import "TStackPlugin.h"
#if __has_include(<t_stack/t_stack-Swift.h>)
#import <t_stack/t_stack-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "t_stack-Swift.h"
#endif

@implementation TStackPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTStackPlugin registerWithRegistrar:registrar];
}
@end
