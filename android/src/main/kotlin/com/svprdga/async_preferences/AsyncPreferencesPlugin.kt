package com.svprdga.async_preferences

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

import java.util.*

class AsyncPreferencesPlugin : FlutterPlugin, MethodCallHandler {

    // ****************************************** VARS ***************************************** //

    private lateinit var channel: MethodChannel
    private lateinit var preferences: Preferences

    // *************************************** LIFECYCLE *************************************** //

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "async_preferences")
        channel.setMethodCallHandler(this)
        preferences = Preferences(flutterPluginBinding.getApplicationContext())
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "remove" -> remove(call, result)
            "set_string" -> setString(call, result)
            "get_string" -> getString(call, result)
            "set_bool" -> setBoolean(call, result)
            "get_bool" -> getBoolean(call, result)
            "set_int" -> setInt(call, result)
            "get_int" -> getInt(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // ************************************ PRIVATE METHODS ************************************ //

    private fun remove(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<String>
            result.success(preferences.remove(list[0]))
        } catch (e: Exception) {
            result.error("remove_error", e.message, null)
        }
    }
    
    private fun setString(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<String>
            result.success(preferences.setString(list[0], list[1]))
        } catch (e: Exception) {
            result.error("set_string_error", e.message, null)
        }
    }

    private fun getString(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<String>
            val value = preferences.getString(list[0])
            result.success(value)
        } catch (e: Exception) {
            result.error("get_string_error", e.message, null)
        }
    }

    private fun setBoolean(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<Any>
            result.success(preferences.setBoolean(list[0] as String, list[1] as Boolean))
        } catch (e: Exception) {
            result.error("set_boolean_error", e.message, null)
        }
    }

    private fun getBoolean(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<String>
            val value = preferences.getBoolean(list[0])
            result.success(value)
        } catch (e: Exception) {
            result.error("get_boolean_error", e.message, null)
        }
    }

    private fun setInt(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<Any>
            result.success(preferences.setInt(list[0] as String, list[1] as Int))
        } catch (e: Exception) {
            result.error("set_int_error", e.message, null)
        }
    }

    private fun getInt(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<String>
            val value = preferences.getInt(list[0])
            result.success(value)
        } catch (e: Exception) {
            result.error("get_int_error", e.message, null)
        }
    }

}
