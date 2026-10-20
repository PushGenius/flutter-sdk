import Flutter
import PushGenius
import UIKit

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
      BigBrain.initialize(call.arguments as? String ?? "", withLaunchOptions: nil)
      result(nil)
    case "login":
      BigBrain.login(call.arguments as? String ?? "")
      result(nil)
    case "logout":
      BigBrain.logout()
      result(nil)
    case "addTags":
      if let tags = call.arguments as? [String: String] {
        BigBrain.User.addTags(tags)
      }
      result(nil)
    case "requestPermission":
      BigBrain.Notifications.requestPermission(true) { granted in result(granted) }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
