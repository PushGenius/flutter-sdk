# pushgenius-flutter

Standalone Flutter plugin for iOS and Android.

```dart
import 'package:pushgenius/pushgenius.dart';

await BigBrain.setHost('https://api.pushgeni.us');
await BigBrain.initialize(appId);
await BigBrain.Notifications.requestPermission(true);
await BigBrain.login('user-123');
await BigBrain.User.addTag('plan', 'pro');
```

Requires iOS 15+. On iOS, enable the Push Notifications capability and Background Modes → Remote notifications. On Android, add `google-services.json` and apply the `com.google.gms.google-services` Gradle plugin.

## Developing

The native iOS and Android SDK sources are vendored into `ios/Classes/Core` and `android/src/main/kotlin/us/pushgeni/sdk`. After changing either native SDK, run `scripts/sync-native.sh` (expects the `ios` and `android` SDK repos next to this one) and commit the result. Don't edit the vendored copies directly.

## Publishing

`dart pub publish`
