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
import androidx.health.connect.client.permission.HealthPermission
import android.content.Intent
import android.app.Activity
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.contador_pasos/pasos"
    private lateinit var healthConnectClient: HealthConnectClient
    private val PERMISSION_REQUEST_CODE = 1001

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "getpasos24h" -> obtenerPasos(result)
                "solicitarPermisos" -> solicitarPermisos(result)
                else -> result.notImplemented()
            }
        }
    }

    private fun solicitarPermisos(result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                healthConnectClient = HealthConnectClient.getOrCreate(this@MainActivity)
                
                val permissions = setOf(
                    HealthPermission.getReadPermission(StepsRecord::class)
                )
                
                val hasPermissions = healthConnectClient.permissionController.getGrantedPermissions().containsAll(permissions)
                
                if (hasPermissions) {
                    withContext(Dispatchers.Main) {
                        result.success(true)
                    }
                } else {
                    withContext(Dispatchers.Main) {
                        // Solicitar permisos usando el método tradicional
                        val permissionsArray = permissions.toTypedArray()
                        ActivityCompat.requestPermissions(this@MainActivity, permissionsArray, PERMISSION_REQUEST_CODE)
                        result.success(false)
                    }
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    result.error("PERMISSION_ERROR", "Error al solicitar permisos", e.message)
                }
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        
        if (requestCode == PERMISSION_REQUEST_CODE) {
            val allGranted = grantResults.all { it == PackageManager.PERMISSION_GRANTED }
            if (allGranted) {
                println("Permisos de Health Connect concedidos")
            } else {
                println("Permisos de Health Connect denegados")
            }
        }
    }

    private fun obtenerPasos(result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                healthConnectClient = HealthConnectClient.getOrCreate(this@MainActivity)
                
                // Verificar permisos antes de obtener datos
                val permissions = setOf(
                    HealthPermission.getReadPermission(StepsRecord::class)
                )
                
                val hasPermissions = healthConnectClient.permissionController.getGrantedPermissions().containsAll(permissions)
                
                if (!hasPermissions) {
                    withContext(Dispatchers.Main) {
                        result.error("NO_PERMISSIONS", "No se tienen los permisos necesarios", null)
                    }
                    return@launch
                }

                val end = Instant.now()
                val start = end.minus(24, ChronoUnit.HOURS)

                val response = healthConnectClient.aggregate(
                    AggregateRequest(
                        metrics = setOf(StepsRecord.COUNT_TOTAL),
                        timeRangeFilter = TimeRangeFilter.between(start, end)
                    )
                )

                val totalPasos = response[StepsRecord.COUNT_TOTAL] ?: 0

                val data = mapOf(
                    "cantidad_pasos" to totalPasos,
                    "inicio" to start.toString(),
                    "fin" to end.toString()
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
