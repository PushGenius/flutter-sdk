import Flutter
import UIKit

/// Flutter bridge over the vendored PushGenius iOS SDK (Core/).
public class PushGeniusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "pushgenius", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(PushGeniusPlugin(), channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "setHost":
      PushGenius.setHost(call.arguments as? String ?? "")
      result(nil)
    case "initialize":
      BigBrain.initialize(call.arguments as? String ?? "")
      result(nil)
    case "login":
      BigBrain.login(call.arguments as? String ?? "")
      result(nil)
    case "logout":
      BigBrain.logout()
      result(nil)
    case "addTags":
      let tags = (call.arguments as? [String: Any] ?? [:]).mapValues { "\($0)" }
      BigBrain.User.addTags(tags)
      result(nil)
    case "removeTags":
      BigBrain.User.removeTags(call.arguments as? [String] ?? [])
      result(nil)
    case "addAlias":
      let args = call.arguments as? [String: Any]
      guard let label = args?["label"] as? String, let id = args?["id"] as? String else {
        result(FlutterError(code: "invalid_arguments", message: "label and id are required", details: nil))
        return
      }
      BigBrain.User.addAlias(label: label, id: id)
      result(nil)
    case "optIn":
      BigBrain.User.pushSubscription.optIn()
      result(nil)
    case "optOut":
      BigBrain.User.pushSubscription.optOut()
      result(nil)
    case "requestPermission":
      BigBrain.Notifications.requestPermission(call.arguments as? Bool ?? true) { granted in result(granted) }
    case "getSubscriptionId":
      result(BigBrain.User.pushSubscription.id)
    case "getToken":
      result(BigBrain.User.pushSubscription.token)
    case "getOptedIn":
      result(BigBrain.User.pushSubscription.optedIn)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
