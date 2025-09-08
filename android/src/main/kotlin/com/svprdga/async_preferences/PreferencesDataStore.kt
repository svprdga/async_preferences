package com.svprdga.async_preferences

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.core.longPreferencesKey
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map

class PreferencesDataStore(private val context: Context, name: String? = null) {

    private val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = name ?: "${context.packageName}_preferences")

    suspend fun remove(id: String) {
        context.dataStore.edit { preferences ->
            val stringKey = stringPreferencesKey(id)
            val booleanKey = booleanPreferencesKey(id)
            val intKey = intPreferencesKey(id)
            val longKey = longPreferencesKey(id)
            
            preferences.remove(stringKey)
            preferences.remove(booleanKey)
            preferences.remove(intKey)
            preferences.remove(longKey)
        }
    }

    suspend fun setString(id: String, value: String) {
        context.dataStore.edit { preferences ->
            preferences[stringPreferencesKey(id)] = value
        }
    }

    suspend fun getString(id: String): String? {
        return context.dataStore.data
            .map { preferences -> preferences[stringPreferencesKey(id)] }
            .first()
    }

    suspend fun setBoolean(id: String, value: Boolean) {
        context.dataStore.edit { preferences ->
            preferences[booleanPreferencesKey(id)] = value
        }
    }

    suspend fun getBoolean(id: String): Boolean? {
        return context.dataStore.data
            .map { preferences -> preferences[booleanPreferencesKey(id)] }
            .first()
    }

    suspend fun setInt(id: String, value: Int) {
        context.dataStore.edit { preferences ->
            preferences[intPreferencesKey(id)] = value
        }
    }

    suspend fun getInt(id: String): Int? {
        return context.dataStore.data
            .map { preferences -> preferences[intPreferencesKey(id)] }
            .first()
    }

    suspend fun setLong(id: String, value: Long) {
        context.dataStore.edit { preferences ->
            preferences[longPreferencesKey(id)] = value
        }
    }

    suspend fun getLong(id: String): Long? {
        return context.dataStore.data
            .map { preferences -> preferences[longPreferencesKey(id)] }
            .first()
    }
}