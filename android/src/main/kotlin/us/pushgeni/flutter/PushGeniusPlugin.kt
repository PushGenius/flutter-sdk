package us.pushgeni.flutter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import us.pushgeni.sdk.OneSignal
import us.pushgeni.sdk.PushGenius

class PushGeniusPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "pushgenius")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setHost" -> { PushGenius.setHost(call.arguments as String); result.success(null) }
            "initialize" -> { OneSignal.initialize(call.arguments as String); result.success(null) }
            "login" -> { OneSignal.login(call.arguments as String); result.success(null) }
            "logout" -> { OneSignal.logout(); result.success(null) }
            "addTags" -> {
                @Suppress("UNCHECKED_CAST")
                val tags = call.arguments as Map<String, String>
                OneSignal.User.addTags(tags)
                result.success(null)
            }
            "removeTags" -> {
                @Suppress("UNCHECKED_CAST")
                OneSignal.User.removeTags(call.arguments as List<String>)
                result.success(null)
            }
            "addAlias" -> {
                val args = call.arguments as Map<*, *>
                OneSignal.User.addAlias(args["label"] as String, args["id"] as String)
                result.success(null)
            }
            "optIn" -> { OneSignal.User.pushSubscription.optIn(); result.success(null) }
            "optOut" -> { OneSignal.User.pushSubscription.optOut(); result.success(null) }
            "requestPermission" -> OneSignal.Notifications.requestPermission(true) { result.success(it) }
            "getSubscriptionId" -> result.success(OneSignal.User.pushSubscription.id)
            "getToken" -> result.success(OneSignal.User.pushSubscription.token)
            "getOptedIn" -> result.success(OneSignal.User.pushSubscription.optedIn)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
