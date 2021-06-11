#import "PingsAlarmscreenPlugin.h"
#if __has_include(<pings_alarmscreen/pings_alarmscreen-Swift.h>)
#import <pings_alarmscreen/pings_alarmscreen-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pings_alarmscreen-Swift.h"
#endif

@implementation PingsAlarmscreenPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPingsAlarmscreenPlugin registerWithRegistrar:registrar];
}
@end
