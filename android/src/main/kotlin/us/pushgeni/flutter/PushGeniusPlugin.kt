package us.pushgeni.flutter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import us.pushgeni.sdk.BigBrain
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
            "initialize" -> { BigBrain.initialize(call.arguments as String); result.success(null) }
            "login" -> { BigBrain.login(call.arguments as String); result.success(null) }
            "logout" -> { BigBrain.logout(); result.success(null) }
            "addTags" -> {
                @Suppress("UNCHECKED_CAST")
                val tags = call.arguments as Map<String, String>
                BigBrain.User.addTags(tags)
                result.success(null)
            }
            "removeTags" -> {
                @Suppress("UNCHECKED_CAST")
                BigBrain.User.removeTags(call.arguments as List<String>)
                result.success(null)
            }
            "addAlias" -> {
                val args = call.arguments as Map<*, *>
                BigBrain.User.addAlias(args["label"] as String, args["id"] as String)
                result.success(null)
            }
            "optIn" -> { BigBrain.User.pushSubscription.optIn(); result.success(null) }
            "optOut" -> { BigBrain.User.pushSubscription.optOut(); result.success(null) }
            "requestPermission" -> BigBrain.Notifications.requestPermission(true) { result.success(it) }
            "getSubscriptionId" -> result.success(BigBrain.User.pushSubscription.id)
            "getToken" -> result.success(BigBrain.User.pushSubscription.token)
            "getOptedIn" -> result.success(BigBrain.User.pushSubscription.optedIn)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
