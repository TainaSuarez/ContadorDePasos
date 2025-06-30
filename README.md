# Contador de Pasos - Aplicación Móvil

![Contador de Pasos](capturas/Pantalla%20contador%20de%20pasos.PNG)

## 📱 Descripción

**Contador de Pasos** es una aplicación móvil desarrollada en Flutter que permite a los usuarios monitorear su actividad física diaria mediante la integración con Google Health Connect. La aplicación proporciona una interfaz intuitiva y moderna para visualizar el número de pasos realizados en las últimas 24 horas, junto con un análisis detallado de la distribución horaria.

## ✨ Características Principales

### 🔐 Integración con Health Connect
- **Autenticación segura**: Integración nativa con Google Health Connect para acceder a datos de actividad física
- **Gestión de permisos**: Solicitud automática y gestión de permisos de acceso a datos de salud
- **Datos en tiempo real**: Obtención de datos de pasos directamente desde el dispositivo

### 📊 Visualización de Datos
- **Contador principal**: Muestra el total de pasos en las últimas 24 horas
- **Gráfico de distribución horaria**: Visualización interactiva de la actividad por hora del día
- **Interfaz moderna**: Diseño Material Design con tema personalizado en tonos índigo

### 🔄 Funcionalidades Avanzadas
- **Actualización manual**: Botón para refrescar datos en tiempo real
- **Manejo de errores**: Gestión robusta de errores de conexión y permisos
- **Estados de carga**: Indicadores visuales durante la carga de datos

## 🛠️ Arquitectura Técnica

### Stack Tecnológico
- **Frontend**: Flutter 3.7.2+
- **Patrón de Arquitectura**: MVVM (Model-View-ViewModel)
- **Gestión de Estado**: Provider Pattern
- **Integración Nativa**: Method Channel para comunicación Flutter-Android
- **Gráficos**: fl_chart para visualización de datos

### Estructura del Proyecto
```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── model/
│   └── pasos_model.dart      # Modelo de datos para pasos
├── view/
│   └── pasos_view.dart       # Vista principal de la aplicación
├── viewmodel/
│   └── pasos_viewmodel.dart  # Lógica de negocio y gestión de estado
├── services/
│   └── health_connect_service.dart # Servicio de integración con Health Connect
└── widgets/
    ├── card_paso.dart        # Widget para mostrar contador de pasos
    └── grafico_paso.dart     # Widget para gráfico de distribución horaria
```

## 📋 Requisitos del Sistema

### Requisitos Mínimos
- **Android**: API Level 26 (Android 8.0) o superior
- **Google Health Connect**: Aplicación instalada y configurada
- **Permisos**: Acceso a datos de actividad física
- **Dispositivo**: Smartphone con sensor de movimiento

### Dependencias Principales
```yaml
dependencies:
  flutter: ^3.7.2
  provider: ^6.0.5
  fl_chart: ^0.66.0
  permission_handler: ^11.3.1
```

## 🚀 Instalación y Configuración

### 1. Preparación del Entorno
```bash
# Clonar el repositorio
git clone https://github.com/MarlaMendez/ContadorDePasos
cd ContadorDePasos/contadordepasos

# Instalar dependencias
flutter pub get
```

### 2. Configuración de Health Connect
1. **Instalar Google Health Connect** desde Google Play Store
2. **Configurar la aplicación** con los permisos necesarios
3. **Emparejar el dispositivo** con la aplicación de salud

### 3. Compilación y Ejecución
```bash
# Ejecutar en modo debug
flutter run

# Compilar APK de release
flutter build apk --release
```

## 📖 Guía de Uso

### Primeros Pasos
1. **Abrir la aplicación** - La aplicación se inicia automáticamente
2. **Conceder permisos** - Se solicitarán permisos de Health Connect
3. **Esperar la carga** - Los datos se cargan automáticamente

### Interfaz Principal
![Pantalla Principal](capturas/Pantalla%20contador%20de%20pasos.PNG)

La pantalla principal muestra:
- **Tarjeta de pasos**: Total de pasos en las últimas 24 horas
- **Gráfico de distribución**: Actividad por hora del día
- **Botón de actualización**: Para refrescar los datos

### Gestión de Permisos
![Emparejamiento](capturas/reloj%20y%20emulador%20emparejados.PNG)

La aplicación requiere permisos específicos:
- **Lectura de datos de pasos**: Para acceder a la información de actividad
- **Permisos de Health Connect**: Para la integración con el sistema de salud

### Solución de Problemas

#### Error de Permisos
![Error de Permisos](capturas/no%20salva%20los%20pasos.PNG)

Si aparecen errores de permisos:
1. Verificar que Health Connect esté instalado
2. Revisar la configuración de permisos en la aplicación
3. Reiniciar la aplicación y volver a intentar

#### Emulación de Datos
![Emulación](capturas/intentando%20emular%20los%20pasos.PNG)

Para desarrollo y pruebas:
- La aplicación incluye simulación de datos por hora
- Los datos simulados se generan aleatoriamente basados en el total
- Útil para probar la interfaz sin datos reales

## 🔧 Desarrollo y Personalización

### Modificar el Tema
```dart
// En main.dart
theme: ThemeData(
  primarySwatch: Colors.indigo,  // Cambiar color principal
  brightness: Brightness.light,
  fontFamily: 'Roboto',
),
```

### Agregar Nuevas Métricas
1. **Extender el modelo** en `pasos_model.dart`
2. **Actualizar el servicio** en `health_connect_service.dart`
3. **Modificar el ViewModel** para manejar nuevos datos
4. **Crear widgets** para mostrar las nuevas métricas

### Personalizar Gráficos
```dart
// En grafico_paso.dart
BarChartData(
  barGroups: List.generate(24, (i) {
    return BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          toY: datosPorHora[i].toDouble(),
          color: Colors.teal,  // Cambiar color de las barras
        )
      ],
    );
  }),
)
```

## 🐛 Solución de Problemas Comunes

### Problema: No se cargan los datos
**Solución:**
- Verificar conexión a internet
- Comprobar permisos de Health Connect
- Reiniciar la aplicación

### Problema: Gráfico no se muestra
**Solución:**
- Verificar que fl_chart esté correctamente instalado
- Comprobar que los datos no estén vacíos
- Revisar la configuración del widget

### Problema: Error de compilación
**Solución:**
```bash
flutter clean
flutter pub get
flutter run
```

## 📱 Capturas de Pantalla

### Pantalla Principal
![Pantalla Principal](capturas/Pantalla%20contador%20de%20pasos.PNG)

### Configuración de Permisos
![Configuración](capturas/reloj%20y%20emulador%20emparejados.PNG)

### Manejo de Errores
![Errores](capturas/no%20salva%20los%20pasos.PNG)

### Emulación de Datos
![Emulación](capturas/intentando%20emular%20los%20pasos.PNG)

## 🤝 Contribución

Para contribuir al proyecto:

1. **Fork** el repositorio
2. **Crear** una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. **Commit** tus cambios (`git commit -am 'feat: agregar nueva funcionalidad'`)
4. **Push** a la rama (`git push origin feature/nueva-funcionalidad`)
5. **Crear** un Pull Request

### Convenciones de Commits
- `feat:` Nueva funcionalidad
- `fix:` Corrección de errores
- `docs:` Documentación
- `style:` Cambios de formato
- `refactor:` Refactorización de código
- `test:` Agregar o modificar tests



---

