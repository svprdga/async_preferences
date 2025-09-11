package com.svprdga.async_preferences

import android.content.SharedPreferences

class Preferences(private val sharedPreferences: SharedPreferences) {

    fun remove(id: String): Boolean {
        val editor = sharedPreferences.edit()
        editor.remove(id)
        return editor.commit()
    }

    fun setString(id: String, value: String): Boolean {
        val editor = sharedPreferences.edit()
        editor.putString(id, value)
        return editor.commit()
    }

    fun getString(id: String): String? {
        return sharedPreferences.getString(id, null)
    }

    fun setBoolean(id: String, value: Boolean): Boolean {
        val editor = sharedPreferences.edit()
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
        val editor = sharedPreferences.edit()
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

    fun setLong(id: String, value: Long): Boolean {
        val editor = sharedPreferences.edit()
        editor.putLong(id, value)
        return editor.commit()
    }

    fun getLong(id: String): Long? {
        return if (sharedPreferences.contains(id)) {
            sharedPreferences.getLong(id, 0)
        } else {
            null
        }
    }
}