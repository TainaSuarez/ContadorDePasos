# Documentación Técnica - Contador de Pasos

## 📋 Índice
1. [Arquitectura del Sistema](#arquitectura-del-sistema)
2. [API y Servicios](#api-y-servicios)
3. [Integración con Health Connect](#integración-con-health-connect)
4. [Patrón MVVM](#patrón-mvvm)
5. [Method Channel](#method-channel)
6. [Gestión de Estado](#gestión-de-estado)
7. [Guía de Desarrollo](#guía-de-desarrollo)
8. [Testing](#testing)
9. [Deployment](#deployment)

## 🏗️ Arquitectura del Sistema

### Diagrama de Arquitectura
```
┌─────────────────────────────────────────────────────────────┐
│                    Flutter UI Layer                        │
├─────────────────────────────────────────────────────────────┤
│  PasosView (View)                                          │
│  ├── PasoCard Widget                                       │
│  ├── GraficoPasos Widget                                   │
│  └── Error Handling UI                                     │
├─────────────────────────────────────────────────────────────┤
│                 ViewModel Layer                            │
├─────────────────────────────────────────────────────────────┤
│  PasosViewmodel (ViewModel)                                │
│  ├── State Management                                      │
│  ├── Business Logic                                        │
│  └── Data Processing                                       │
├─────────────────────────────────────────────────────────────┤
│                  Service Layer                             │
├─────────────────────────────────────────────────────────────┤
│  HealthConnectService (Service)                            │
│  ├── Permission Management                                 │
│  ├── Data Retrieval                                        │
│  └── Error Handling                                        │
├─────────────────────────────────────────────────────────────┤
│                 Method Channel                             │
├─────────────────────────────────────────────────────────────┤
│              Native Android Layer                          │
├─────────────────────────────────────────────────────────────┤
│  MainActivity (Kotlin)                                     │
│  ├── HealthConnectClient                                   │
│  ├── Permission Controller                                 │
│  └── Data Aggregation                                      │
├─────────────────────────────────────────────────────────────┤
│                Health Connect API                          │
└─────────────────────────────────────────────────────────────┘
```

### Componentes Principales

#### 1. View Layer (`lib/view/`)
- **Responsabilidad**: Presentación de datos y interacción con el usuario
- **Componentes**:
  - `PasosView`: Vista principal de la aplicación
  - Estados: Loading, Error, Success, Empty

#### 2. ViewModel Layer (`lib/viewmodel/`)
- **Responsabilidad**: Lógica de negocio y gestión de estado
- **Componentes**:
  - `PasosViewmodel`: Maneja la lógica de la aplicación
  - Estados: `isLoading`, `errorMessage`, `registro`, `pasosxhora`

#### 3. Service Layer (`lib/services/`)
- **Responsabilidad**: Comunicación con servicios externos
- **Componentes**:
  - `HealthConnectService`: Integración con Health Connect

#### 4. Model Layer (`lib/model/`)
- **Responsabilidad**: Definición de estructuras de datos
- **Componentes**:
  - `RegistrarlosPasos`: Modelo de datos para pasos

## 🔌 API y Servicios

### HealthConnectService

#### Métodos Principales

```dart
class HealthConnectService {
  static const platform = MethodChannel('com.example.contador_pasos/pasos');

  // Solicitar permisos de Health Connect
  Future<bool> solicitarPermisos() async {
    try {
      final result = await platform.invokeMethod('solicitarPermisos');
      return result == true;
    } catch (e) {
      print('Error al solicitar permisos: $e');
      return false;
    }
  }

  // Obtener datos de pasos de las últimas 24 horas
  Future<RegistrarlosPasos?> obtenerPasos24h() async {
    try {
      final permisosConcedidos = await solicitarPermisos();
      if (!permisosConcedidos) {
        return null;
      }

      final result = await platform.invokeMethod('getpasos24h');
      return RegistrarlosPasos(
        cantidad_pasos: result['cantidad_pasos'],
        fechainicio: DateTime.parse(result['inicio']), 
        fechafin: DateTime.parse(result['fin'])
      );
    } catch (e) {
      print('No se pudieron obtener los pasos: $e');
      return null;
    }
  }
}
```

### Modelo de Datos

```dart
class RegistrarlosPasos {
  final int cantidad_pasos;
  final DateTime fechainicio;
  final DateTime fechafin;

  RegistrarlosPasos({
    required this.cantidad_pasos,
    required this.fechainicio,
    required this.fechafin,
  });
}
```

## 🔗 Integración con Health Connect

### Configuración en Android

#### 1. Dependencias en `build.gradle.kts`
```kotlin
dependencies {
    implementation("androidx.health.connect:connect-client:1.1.0-alpha02")
}
```


#### 3. Implementación en MainActivity.kt

```kotlin
class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.contador_pasos/pasos"
    private lateinit var healthConnectClient: HealthConnectClient

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
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
                
                val hasPermissions = healthConnectClient.permissionController
                    .getGrantedPermissions().containsAll(permissions)
                
                withContext(Dispatchers.Main) {
                    result.success(hasPermissions)
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    result.error("PERMISSION_ERROR", "Error al solicitar permisos", e.message)
                }
            }
        }
    }

    private fun obtenerPasos(result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                healthConnectClient = HealthConnectClient.getOrCreate(this@MainActivity)
                
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
```

## 📊 Patrón MVVM

### ViewModel Implementation

```dart
class PasosViewmodel extends ChangeNotifier {
  final _service = HealthConnectService();
  RegistrarlosPasos? registro;
  List<int> pasosxhora = List.filled(24, 0);
  bool isLoading = false;
  String? errorMessage;
  bool permisosSolicitados = false;

  // Cargar datos de pasos
  Future<void> cargarlospasos() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      if (!permisosSolicitados) {
        final permisosConcedidos = await _service.solicitarPermisos();
        permisosSolicitados = true;
        
        if (!permisosConcedidos) {
          errorMessage = "Se requieren permisos de Health Connect";
          isLoading = false;
          notifyListeners();
          return;
        }
      }

      final resultado = await _service.obtenerPasos24h();
      if (resultado != null) {
        registro = resultado;
        _simularpasosxhora(resultado.cantidad_pasos);
        errorMessage = null;
      } else {
        errorMessage = "No se pudieron obtener los datos de pasos";
      }
    } catch (e) {
      errorMessage = "Error al cargar los datos: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Simular distribución de pasos por hora
  void _simularpasosxhora(int total) {
    final random = Random();
    pasosxhora = List.generate(24, (_) => random.nextInt(total ~/ 10));
  }
}
```

### Estados del ViewModel

| Estado | Descripción | UI Response |
|--------|-------------|-------------|
| `isLoading = true` | Cargando datos | Mostrar CircularProgressIndicator |
| `errorMessage != null` | Error ocurrido | Mostrar mensaje de error con botón de reintento |
| `registro != null` | Datos cargados exitosamente | Mostrar contador y gráfico |
| `registro == null` | Sin datos disponibles | Mostrar mensaje de "no hay datos" |

## 🔄 Method Channel

### Configuración del Canal

```dart
// Flutter Side
static const platform = MethodChannel('com.example.contador_pasos/pasos');

// Android Side
private val CHANNEL = "com.example.contador_pasos/pasos"
```

### Métodos Disponibles

| Método | Parámetros | Retorno | Descripción |
|--------|------------|---------|-------------|
| `solicitarPermisos` | None | `bool` | Solicita permisos de Health Connect |
| `getpasos24h` | None | `Map<String, dynamic>` | Obtiene datos de pasos de 24h |

### Estructura de Respuesta

```json
{
  "cantidad_pasos": 12345,
  "inicio": "2024-01-15T00:00:00Z",
  "fin": "2024-01-15T23:59:59Z"
}
```

## 🎯 Gestión de Estado

### Provider Pattern Implementation

```dart
// En main.dart
return ChangeNotifierProvider(
  create: (_) => PasosViewmodel(),
  child: MaterialApp(
    // ... configuración de la app
  ),
);

// En la vista
final vm = context.watch<PasosViewmodel>();
```

### Ciclo de Vida del Estado

1. **Inicialización**: ViewModel se crea con estado inicial
2. **Carga**: `isLoading = true`, se solicitan permisos y datos
3. **Éxito**: Datos cargados, se actualiza `registro` y `pasosxhora`
4. **Error**: Se establece `errorMessage` con descripción del error
5. **Actualización**: Usuario puede refrescar datos manualmente

## 🛠️ Guía de Desarrollo

### Configuración del Entorno

#### 1. Instalar Dependencias
```bash
flutter pub get
```

---

