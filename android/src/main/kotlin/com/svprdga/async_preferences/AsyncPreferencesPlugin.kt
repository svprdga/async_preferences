package com.svprdga.async_preferences

import android.content.Context
import android.content.SharedPreferences
import androidx.annotation.NonNull
import androidx.preference.PreferenceManager

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
    private lateinit var context: Context
    private var preferences = HashMap<String?, Preferences>()

    // *************************************** LIFECYCLE *************************************** //

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "async_preferences")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.getApplicationContext()
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

    private fun getPreferences(file: String? = null): Preferences {
        if (preferences.containsKey(file)) {
            return preferences[file]!!
        }

        val newPreference = if (file == null) {
            PreferenceManager.getDefaultSharedPreferences(context)
        } else {
            context.getSharedPreferences(file!!, Context.MODE_PRIVATE)
        }

        preferences[file] = Preferences(newPreference)
        return preferences[file]!!
    }

    private fun remove(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<Any>

            val preferenceFile = list[0] as String?
            val preferences = getPreferences(preferenceFile)

            val key = list[1] as String

            result.success(preferences.remove(key))
        } catch (e: Exception) {
            result.error("remove_error", e.message, null)
        }
    }
    
    private fun setString(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<Any>

            val preferenceFile = list[0] as String?
            val preferences = getPreferences(preferenceFile)

            val key = list[1] as String
            val value = list[2] as String

            result.success(preferences.setString(key, value))
        } catch (e: Exception) {
            result.error("set_string_error", e.message, null)
        }
    }

    private fun getString(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<Any>

            val preferenceFile = list[0] as String?
            val preferences = getPreferences(preferenceFile)

            val key = list[1] as String

            val value = preferences.getString(key)
            result.success(value)
        } catch (e: Exception) {
            result.error("get_string_error", e.message, null)
        }
    }

    private fun setBoolean(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<Any>

            val preferenceFile = list[0] as String?
            val preferences = getPreferences(preferenceFile)

            val key = list[1] as String
            val value = list[2] as Boolean

            result.success(preferences.setBoolean(key, value))
        } catch (e: Exception) {
            result.error("set_boolean_error", e.message, null)
        }
    }

    private fun getBoolean(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<Any>

            val preferenceFile = list[0] as String?
            val preferences = getPreferences(preferenceFile)

            val key = list[1] as String

            val value = preferences.getBoolean(key)
            result.success(value)
        } catch (e: Exception) {
            result.error("get_boolean_error", e.message, null)
        }
    }

    private fun setInt(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<Any>

            val preferenceFile = list[0] as String?
            val preferences = getPreferences(preferenceFile)

            val key = list[1] as String
            val value = list[2] as Int

            result.success(preferences.setInt(key, value))
        } catch (e: Exception) {
            result.error("set_int_error", e.message, null)
        }
    }

    private fun getInt(call: MethodCall, result: MethodChannel.Result) {
        try {
            val list = call.arguments as ArrayList<Any>

            val preferenceFile = list[0] as String?
            val preferences = getPreferences(preferenceFile)

            val key = list[1] as String

            val value = preferences.getInt(key)
            result.success(value)
        } catch (e: Exception) {
            result.error("get_int_error", e.message, null)
        }
    }

}
