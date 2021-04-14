package com.svprdga.async_preferences

import android.content.Context
import android.content.SharedPreferences
import androidx.preference.PreferenceManager

class Preferences(context: Context) {

    // ****************************************** VARS ***************************************** //

    private val sharedPreferences: SharedPreferences =
            PreferenceManager.getDefaultSharedPreferences(context)
    private val editor: SharedPreferences.Editor = sharedPreferences.edit()
    
    // ************************************* PUBLIC METHODS ************************************ //

    fun remove(id: String): Boolean {
        editor.remove(id)
        return editor.commit()
    }
    
    fun setString(id: String, value: String): Boolean {
        editor.putString(id, value)
        return editor.commit()
    }
    
    fun getString(id: String): String? {
        return sharedPreferences.getString(id, null)
    }

    fun setBoolean(id: String, value: Boolean): Boolean {
        editor.putBoolean(id, value)
        return editor.commit()
    }

    fun getBoolean(id: String): Boolean? {
        return if (sharedPreferences.contains(id)) {
            sharedPreferences.getBoolean(id, false)
        } else {
            null
        }
    }

    fun setInt(id: String, value: Int): Boolean {
        editor.putInt(id, value)
        return editor.commit()
    }

    fun getInt(id: String): Int? {
        return if (sharedPreferences.contains(id)) {
            sharedPreferences.getInt(id, 0)
        } else {
            null
        }
    }
}