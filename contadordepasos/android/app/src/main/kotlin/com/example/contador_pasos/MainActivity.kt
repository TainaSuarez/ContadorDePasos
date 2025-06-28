package com.example.contador_pasos

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.time.Instant
import java.time.temporal.ChronoUnit
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.time.TimeRangeFilter

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.contador_pasos/pasos"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "getpasos24h") {
                obtenerPasos(result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun obtenerPasos(result: MethodChannel.Result) {
        val client = HealthConnectClient.getOrCreate(this)

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val end = Instant.now()
                val start = end.minus(24, ChronoUnit.HOURS)

                val response = client.aggregate(
    AggregateRequest(
        metrics = setOf(StepsRecord.COUNT_TOTAL),
        timeRangeFilter = TimeRangeFilter.between(start, end)
    )
)

val totalPasos = response[StepsRecord.COUNT_TOTAL] ?: 0

                val data = mapOf(
                    "cantidad_pasos" to totalPasos,
                    "fechainicio" to start.toString(),
                    "fechafin" to end.toString()
                )

                withContext(Dispatchers.Main) {
                    result.success(data)
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    result.error("ERROR", "No se pudo obtener pasos", e.message)
                }
            }
        }
    }
}
