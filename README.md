# pushgenius-flutter

Standalone Flutter plugin. Depends on the native iOS and Android SDK repos at build time.

```dart
import 'package:pushgenius/pushgenius.dart';

await OneSignal.setHost('https://api.pushgeni.us');
await OneSignal.initialize(appId);
await OneSignal.Notifications.requestPermission(true);
await OneSignal.login('user-123');
await OneSignal.User.addTag('plan', 'pro');
```

Point `pubspec.yaml` git dependencies (or path, while developing) at:

- `pushgenius-ios`
- `pushgenius-android`
