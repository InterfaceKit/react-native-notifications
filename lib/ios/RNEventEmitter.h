#import <React/RCTEventEmitter.h>

static NSString* const RNRegistered                  = @"remoteNotificationsRegistered";
static NSString* const RNRegistrationFailed          = @"remoteNotificationsRegistrationFailed";
static NSString* const RNPushKitRegistered           = @"pushKitRegistered";
static NSString* const RNNotificationReceived        = @"notificationReceived";
static NSString* const RNNotificationOpened          = @"notificationOpened";
static NSString* const RNPushKitNotificationReceived = @"pushKitNotificationReceived";
static NSString* const RNOnStartCallAction = @"onStartCallAction";
static NSString* const RNOnEndCallAction = @"onEndCallAction";

@interface RNEventEmitter : RCTEventEmitter <RCTBridgeModule>

+ (void)sendEvent:(NSString *)event body:(NSDictionary *)body;

@end
