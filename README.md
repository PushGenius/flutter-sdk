# pushgenius-flutter

Standalone Flutter plugin. Depends on the native iOS and Android SDK repos at build time.

```dart
import 'package:pushgenius/pushgenius.dart';

await BigBrain.setHost('https://api.pushgeni.us');
await BigBrain.initialize(appId);
await BigBrain.Notifications.requestPermission(true);
await BigBrain.login('user-123');
await BigBrain.User.addTag('plan', 'pro');
```

Point `pubspec.yaml` git dependencies (or path, while developing) at:

- `pushgenius-ios`
- `pushgenius-android`
