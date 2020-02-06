#import <Foundation/Foundation.h>
#import "RNNotificationEventHandler.h"

@interface RNPushKitEventHandler : RNNotificationEventHandler

- (void)registeredWithToken:(NSString *)token;

- (void)didReceiveIncomingPushWithPayload:(NSDictionary *)payload;

- (void)onStartCallAction:(NSDictionary *)payload;

- (void)onEndCallAction:(NSDictionary *)payload;

@end
