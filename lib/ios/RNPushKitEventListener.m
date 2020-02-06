#import "RNPushKitEventListener.h"
#import "RNNotificationUtils.h"
#import "CallKit/Callkit.h"

@implementation RNPushKitEventListener {
    PKPushRegistry* _pushRegistry;
    RNPushKitEventHandler* _pushKitEventHandler;
}

- (instancetype)initWithPushKitEventHandler:(RNPushKitEventHandler *)pushKitEventHandler {
    self = [super init];
    
    _pushRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    _pushKitEventHandler = pushKitEventHandler;
    
    return self;
}

- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)credentials forType:(NSString *)type {
    [_pushKitEventHandler registeredWithToken:[RNNotificationUtils deviceTokenToString:credentials.token]];
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(NSString *)type {
    [_pushKitEventHandler didReceiveIncomingPushWithPayload:payload.dictionaryPayload];
    
    // Check if iOS version is starting 10.0
    if (@available(iOS 10.0, *)) {
        CXProviderConfiguration * config = [[CXProviderConfiguration alloc] initWithLocalizedName:@"Actio"];
        
        CXProvider *callkitProvider = [[CXProvider alloc] initWithConfiguration: config];
        [callkitProvider setDelegate:self  queue:nil];
        CXCallUpdate *update = [[CXCallUpdate alloc] init];
        update.localizedCallerName = @"Actio: Training session";
        
        // Report incoming call from push notification
        [callkitProvider reportNewIncomingCallWithUUID:[NSUUID UUID]  update:update completion:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error: %@", error);
            }
        }];
    }
}

/// MARK: CXProviderDelegate
- (void)provider:(CXProvider *)provider performStartCallAction:(CXStartCallAction *)action  API_AVAILABLE(ios(10.0)){
    [_pushKitEventHandler onStartCallAction: @{ @"STATUS": @"START" }];
}

- (void)provider:(CXProvider *)provider performEndCallAction:(CXEndCallAction *)action  API_AVAILABLE(ios(10.0)){
    [_pushKitEventHandler onEndCallAction: @{ @"STATUS": @"END" }];
}

@end
