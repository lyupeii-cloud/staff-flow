package com.staffflow.staff_flow

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.ContentValues
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.provider.CalendarContract.Calendars
import android.provider.CalendarContract.Events
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.TimeZone

class MainActivity : FlutterActivity() {
    /// Réponse en attente de la demande d'accès à l'agenda.
    private var pendingPermission: MethodChannel.Result? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Canal des notifications envoyées par le serveur (channel_id « staff_flow »).
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel("staff_flow", "Staff Flow", NotificationManager.IMPORTANCE_HIGH)
            getSystemService(NotificationManager::class.java).createNotificationChannel(channel)
        }
    }

    /// Agenda du téléphone (Google Agenda) : écrire, modifier et retirer les
    /// services de la personne. Les valeurs sont passées avec les types
    /// attendus par Android (entiers, pas de booléens).
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "staff_flow/calendar").setMethodCallHandler { call, result ->
            try {
                when (call.method) {
                    "hasPermission" -> result.success(granted())
                    "requestPermission" -> {
                        if (granted()) {
                            result.success(true)
                        } else {
                            pendingPermission = result
                            requestPermissions(arrayOf(Manifest.permission.READ_CALENDAR, Manifest.permission.WRITE_CALENDAR), 4242)
                        }
                    }
                    "calendars" -> result.success(calendars())
                    "upsert" -> result.success(upsert(call.argument<Map<String, Any?>>("event")!!))
                    "delete" -> {
                        val id = (call.argument<String>("eventId") ?: "").toLongOrNull()
                        result.success(id != null && contentResolver.delete(
                            android.content.ContentUris.withAppendedId(Events.CONTENT_URI, id), null, null) > 0)
                    }
                    else -> result.notImplemented()
                }
            } catch (e: Exception) {
                result.error("calendar", e.message, null)
            }
        }
    }

    private fun granted() = Build.VERSION.SDK_INT < Build.VERSION_CODES.M ||
        (checkSelfPermission(Manifest.permission.READ_CALENDAR) == PackageManager.PERMISSION_GRANTED &&
            checkSelfPermission(Manifest.permission.WRITE_CALENDAR) == PackageManager.PERMISSION_GRANTED)

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == 4242) {
            pendingPermission?.success(granted())
            pendingPermission = null
        }
    }

    /// Agendas où l'on peut écrire.
    private fun calendars(): List<Map<String, Any?>> {
        val out = mutableListOf<Map<String, Any?>>()
        val projection = arrayOf(Calendars._ID, Calendars.CALENDAR_DISPLAY_NAME, Calendars.ACCOUNT_NAME,
            Calendars.ACCOUNT_TYPE, Calendars.IS_PRIMARY, Calendars.CALENDAR_ACCESS_LEVEL)
        contentResolver.query(Calendars.CONTENT_URI, projection, null, null, null)?.use { c ->
            while (c.moveToNext()) {
                if (c.getInt(5) < Calendars.CAL_ACCESS_CONTRIBUTOR) continue
                out.add(mapOf(
                    "id" to c.getLong(0).toString(),
                    "name" to c.getString(1),
                    "account" to c.getString(2),
                    "accountType" to c.getString(3),
                    "primary" to (c.getInt(4) == 1),
                ))
            }
        }
        return out
    }

    /// Crée l'événement, ou le met à jour s'il existe encore. Renvoie son identifiant.
    private fun upsert(e: Map<String, Any?>): String {
        val values = ContentValues().apply {
            put(Events.CALENDAR_ID, (e["calendarId"] as String).toLong())
            put(Events.TITLE, e["title"] as String?)
            put(Events.DESCRIPTION, e["description"] as String?)
            put(Events.EVENT_LOCATION, e["location"] as String?)
            put(Events.DTSTART, (e["start"] as Number).toLong())
            put(Events.DTEND, (e["end"] as Number).toLong())
            put(Events.EVENT_TIMEZONE, TimeZone.getDefault().id)
            put(Events.ALL_DAY, 0)
            put(Events.HAS_ALARM, 0)
        }
        // Événement supprimé à la main dans l'agenda : on en crée un nouveau.
        val existing = (e["eventId"] as String?)?.toLongOrNull()?.takeIf { id ->
            contentResolver.query(android.content.ContentUris.withAppendedId(Events.CONTENT_URI, id),
                arrayOf(Events.DELETED), null, null, null)?.use { c -> c.moveToFirst() && c.getInt(0) == 0 } ?: false
        }
        if (existing != null) {
            val updated = contentResolver.update(
                android.content.ContentUris.withAppendedId(Events.CONTENT_URI, existing), values, null, null)
            if (updated > 0) return existing.toString()
        }
        val uri = contentResolver.insert(Events.CONTENT_URI, values) ?: throw IllegalStateException("insert")
        return uri.lastPathSegment!!
    }
}
