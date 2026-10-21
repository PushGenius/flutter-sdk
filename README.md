# pushgenius-flutter

Standalone Flutter plugin for iOS and Android.

```sh
flutter pub add pushgenius
```


```dart
import 'package:pushgenius/pushgenius.dart';

await BigBrain.setHost('https://api.pushgeni.us');
await BigBrain.initialize(appId);
await BigBrain.Notifications.requestPermission(true);
await BigBrain.login('user-123');
await BigBrain.User.addTag('plan', 'pro');
```

Requires Flutter 3.44+ and iOS 15+. Works with both Swift Package Manager and CocoaPods. On iOS, enable the Push Notifications capability and Background Modes → Remote notifications. On Android, add `google-services.json` and apply the `com.google.gms.google-services` Gradle plugin.

## Count notifications received in the background (iOS)

iOS doesn't run your app when a notification arrives in the background, so by default the SDK can only report notifications that arrive while the app is open. To count every notification, add a Notification Service Extension. iOS runs it for each notification, even when your app is closed.

1. In Xcode, choose **File → New → Target → Notification Service Extension** and name it `NotificationService`. Set its minimum iOS version to match your app's (iOS 15 or later).
2. Choose **File → Add Package Dependencies**, enter `https://github.com/PushGenius/ios-sdk.git`, and add the **PushGeniusNotificationService** library to the extension target only. This works alongside CocoaPods.
3. Replace the contents of the extension's `NotificationService.swift` with:

   ```swift
   import PushGeniusNotificationService

   class NotificationService: BigBrainNotificationService {}
   ```

If you call `setHost`, also override the host in the extension: `override var host: String { "https://your-host" }`.

If the build then fails with a dependency cycle, open the **Runner** target's **Build Phases** and drag **Embed Foundation Extensions** above **Run Script**.


## Developing

The native iOS and Android SDK sources are vendored into `ios/pushgenius/Sources/pushgenius/Core` and `android/src/main/kotlin/us/pushgeni/sdk`. After changing either native SDK, run `scripts/sync-native.sh` (expects the `ios` and `android` SDK repos next to this one) and commit the result. Don't edit the vendored copies directly.

## Publishing

`dart pub publish`
