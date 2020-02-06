import { EmitterSubscription } from 'react-native';
import { NativeEventsReceiver } from '../adapters/NativeEventsReceiver';
import {
  RegisteredPushKit
} from '../interfaces/NotificationEvents';

export class EventsRegistryIOS {
  constructor(
    private nativeEventsReceiver: NativeEventsReceiver) { }

  public registerPushKitRegistered(callback: (event: RegisteredPushKit) => void): EmitterSubscription {
    return this.nativeEventsReceiver.registerPushKitRegistered(callback);
  }

  public registerPushKitNotificationReceived(callback: (event: object) => void): EmitterSubscription {
    return this.nativeEventsReceiver.registerPushKitNotificationReceived(callback);
  }

  public registerOnStartCallAction(callback: (event: object) => void): EmitterSubscription {
    return this.nativeEventsReceiver.registerOnStartCallAction(callback);
  }

  public registerOnEndCallAction(callback: (event: object) => void): EmitterSubscription {
    return this.nativeEventsReceiver.registerOnEndCallAction(callback);
  }
}
