import 'package:flutter/services.dart';

class PushSubscription {
  static const _ch = MethodChannel('pushgenius');
  Future<String?> get id async => _ch.invokeMethod<String>('getSubscriptionId');
  Future<String?> get token async => _ch.invokeMethod<String>('getToken');
  Future<bool> get optedIn async => (await _ch.invokeMethod<bool>('getOptedIn')) ?? false;
  Future<void> optIn() => _ch.invokeMethod('optIn');
  Future<void> optOut() => _ch.invokeMethod('optOut');
}

class UserNamespace {
  final pushSubscription = PushSubscription();
  Future<void> addTag(String key, String value) => addTags({key: value});
  Future<void> addTags(Map<String, String> tags) =>
      const MethodChannel('pushgenius').invokeMethod('addTags', tags);
  Future<void> removeTag(String key) => removeTags([key]);
  Future<void> removeTags(List<String> keys) =>
      const MethodChannel('pushgenius').invokeMethod('removeTags', keys);
  Future<void> addAlias(String label, String id) =>
      const MethodChannel('pushgenius').invokeMethod('addAlias', {'label': label, 'id': id});
}

class NotificationsNamespace {
  Future<bool> requestPermission([bool fallbackToSettings = true]) async {
    return (await const MethodChannel('pushgenius')
            .invokeMethod<bool>('requestPermission', fallbackToSettings)) ??
        false;
  }
}

class BigBrain {
  static final User = UserNamespace();
  static final Notifications = NotificationsNamespace();

  static Future<void> setHost(String url) =>
      const MethodChannel('pushgenius').invokeMethod('setHost', url);

  static Future<void> initialize(String appId) =>
      const MethodChannel('pushgenius').invokeMethod('initialize', appId);

  static Future<void> login(String externalId) =>
      const MethodChannel('pushgenius').invokeMethod('login', externalId);

  static Future<void> logout() => const MethodChannel('pushgenius').invokeMethod('logout');
}

typedef PushGenius = BigBrain;
