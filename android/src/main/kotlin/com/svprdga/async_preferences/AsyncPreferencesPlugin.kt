package com.svprdga.async_preferences

import android.content.Context
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class AsyncPreferencesPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private val preferencesDataStores = mutableMapOf<String?, PreferencesDataStore>()
    private var keysToMigrate: List<String> = emptyList()

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "async_preferences")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.getApplicationContext()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "keys_to_migrate" -> setKeysToMigrate(call, result)
            "remove" -> remove(call, result)
            "set_string" -> setString(call, result)
            "get_string" -> getString(call, result)
            "set_bool" -> setBoolean(call, result)
            "get_bool" -> getBoolean(call, result)
            "set_int" -> setInt(call, result)
            "get_int" -> getInt(call, result)
            "set_long" -> setLong(call, result)
            "get_long" -> getLong(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getPreferencesDataStore(file: String? = null): PreferencesDataStore {
        return preferencesDataStores.getOrPut(file) {
            PreferencesDataStore(context, file, keysToMigrate)
        }
    }

    private fun remove(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val list = call.arguments as ArrayList<Any>

                val preferenceFile = list[0] as String?
                val preferencesDataStore = getPreferencesDataStore(preferenceFile)

                val key = list[1] as String

                preferencesDataStore.remove(key)
                result.success(true)
            } catch (e: Exception) {
                result.error("remove_error", e.message, null)
            }
        }
    }

    private fun setString(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val list = call.arguments as ArrayList<Any>

                val preferenceFile = list[0] as String?
                val preferencesDataStore = getPreferencesDataStore(preferenceFile)

                val key = list[1] as String
                val value = list[2] as String

                preferencesDataStore.setString(key, value)
                result.success(true)
            } catch (e: Exception) {
                result.error("set_string_error", e.message, null)
            }
        }
    }

    private fun getString(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val list = call.arguments as ArrayList<Any>

                val preferenceFile = list[0] as String?
                val preferencesDataStore = getPreferencesDataStore(preferenceFile)

                val key = list[1] as String

                val value = preferencesDataStore.getString(key)
                result.success(value)
            } catch (e: Exception) {
                result.error("get_string_error", e.message, null)
            }
        }
    }

    private fun setBoolean(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val list = call.arguments as ArrayList<Any>

                val preferenceFile = list[0] as String?
                val preferencesDataStore = getPreferencesDataStore(preferenceFile)

                val key = list[1] as String
                val value = list[2] as Boolean

                preferencesDataStore.setBoolean(key, value)
                result.success(true)
            } catch (e: Exception) {
                result.error("set_boolean_error", e.message, null)
            }
        }
    }

    private fun getBoolean(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val list = call.arguments as ArrayList<Any>

                val preferenceFile = list[0] as String?
                val preferencesDataStore = getPreferencesDataStore(preferenceFile)

                val key = list[1] as String

                val value = preferencesDataStore.getBoolean(key)
                result.success(value)
            } catch (e: Exception) {
                result.error("get_boolean_error", e.message, null)
            }
        }
    }

    private fun setInt(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val list = call.arguments as ArrayList<Any>

                val preferenceFile = list[0] as String?
                val preferencesDataStore = getPreferencesDataStore(preferenceFile)

                val key = list[1] as String
                val value = list[2] as Int

                preferencesDataStore.setInt(key, value)
                result.success(true)
            } catch (e: Exception) {
                result.error("set_int_error", e.message, null)
            }
        }
    }

    private fun getInt(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val list = call.arguments as ArrayList<Any>

                val preferenceFile = list[0] as String?
                val preferencesDataStore = getPreferencesDataStore(preferenceFile)

                val key = list[1] as String

                val value = preferencesDataStore.getInt(key)
                result.success(value)
            } catch (e: Exception) {
                result.error("get_int_error", e.message, null)
            }
        }
    }

    private fun setLong(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val list = call.arguments as ArrayList<Any>

                val preferenceFile = list[0] as String?
                val preferencesDataStore = getPreferencesDataStore(preferenceFile)

                val key = list[1] as String
                val value = list[2] as String

                preferencesDataStore.setLong(key, value.toLong())
                result.success(true)
            } catch (e: Exception) {
                result.error("set_long_error", e.message, null)
            }
        }
    }

    private fun getLong(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val list = call.arguments as ArrayList<Any>

                val preferenceFile = list[0] as String?
                val preferencesDataStore = getPreferencesDataStore(preferenceFile)

                val key = list[1] as String

                val value = preferencesDataStore.getLong(key)
                result.success(value)
            } catch (e: Exception) {
                result.error("get_long_error", e.message, null)
            }
        }
    }

    private fun setKeysToMigrate(call: MethodCall, result: MethodChannel.Result) {
        try {
            @Suppress("UNCHECKED_CAST")
            keysToMigrate = call.arguments as List<String>
            result.success(null)
        } catch (e: Exception) {
            result.error("keys_to_migrate_error", e.message, null)
        }
    }

}
