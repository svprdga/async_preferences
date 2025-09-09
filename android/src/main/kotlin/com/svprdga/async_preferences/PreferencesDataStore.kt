package com.svprdga.async_preferences

import android.content.Context
import android.util.Log
import androidx.datastore.core.DataMigration
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.SharedPreferencesMigration
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.core.longPreferencesKey
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map

class PreferencesDataStore(
    private val context: Context,
    private val keysToMigrate: List<String>,
    name: String? = null,
) {

    private val dataStoreName = name ?: "${context.packageName}_preferences"

    private val Context.dataStore: DataStore<Preferences> by preferencesDataStore(
        name = dataStoreName,
        produceMigrations = { context ->
            listOf(object: DataMigration<Preferences> {
                override suspend fun shouldMigrate(currentData: Preferences) = true
//                override suspend fun shouldMigrate(currentData: Preferences): Boolean {
//                    val sharedPreferences = context.getSharedPreferences(name, Context.MODE_PRIVATE)
//                    return keysToMigrate.any { key ->
//                        sharedPreferences.contains(key) && !currentData.contains(stringPreferencesKey(key)) &&
//                        !currentData.contains(booleanPreferencesKey(key)) &&
//                        !currentData.contains(intPreferencesKey(key)) &&
//                        !currentData.contains(longPreferencesKey(key))
//                    }
//                }

                override suspend fun migrate(currentData: Preferences): Preferences {
                    val out = currentData.toMutablePreferences()
                    Log.d("DS-MIG", "Initial=$out")

                    val sharedPreferences = context.getSharedPreferences(name, Context.MODE_PRIVATE)

                    val allValues = sharedPreferences.all

                    // TODO
                    Log.d("DS-MIG", "SP keys=${allValues}")
                    Log.d("DS-MIG", "keysToMigrate=$keysToMigrate")

                    keysToMigrate.forEach { key ->
                        val value = allValues[key]
                        
                        when (value) {
                            is String -> out[stringPreferencesKey(key)] = value
                            is Boolean -> out[booleanPreferencesKey(key)] = value
                            is Int -> out[intPreferencesKey(key)] = value
                            is Long -> out[longPreferencesKey(key)] = value
                        }
                    }

                    // TODO
                    Log.d("DS-MIG", "Migrated=$out")


                    return out
                }

                override suspend fun cleanUp() {
                    val sharedPreferences = context.getSharedPreferences(name, Context.MODE_PRIVATE)
                    val editor = sharedPreferences.edit()
                    keysToMigrate.forEach { key ->
                        editor.remove(key)
                    }
                    editor.apply()
                }
            })


//            listOf(
//                SharedPreferencesMigration(
//                    ctx,
//                    dataStoreName
//                )
//            )
        }
    )

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