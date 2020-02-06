#import "RNPushKitEventHandler.h"
#import "RNEventEmitter.h"

@implementation RNPushKitEventHandler

- (void)registeredWithToken:(NSString *)token {
    [RNEventEmitter sendEvent:RNPushKitRegistered body:@{@"pushKitToken": token}];
}

- (void)didReceiveIncomingPushWithPayload:(NSDictionary *)payload {
    [RNEventEmitter sendEvent:RNPushKitNotificationReceived body:payload];
}

- (void)onStartCallAction:(NSDictionary *)payload {
    [RNEventEmitter sendEvent:RNOnStartCallAction body:payload];
}

- (void)onEndCallAction:(NSDictionary *)payload {
    [RNEventEmitter sendEvent:RNOnEndCallAction body:payload];
}

@end
