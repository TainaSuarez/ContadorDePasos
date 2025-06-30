# Contador de Pasos - Aplicación Móvil

## 📱 Descripción

**Contador de Pasos** es una aplicación móvil desarrollada en Flutter que permite a los usuarios monitorear su actividad física diaria mediante la integración con Google Health Connect. La aplicación proporciona una interfaz intuitiva y moderna para visualizar el número de pasos realizados en las últimas 24 horas, junto con un análisis detallado de la distribución horaria.

## ⚠️ Nota Importante sobre el Entorno de Desarrollo

**El código de la aplicación de contador de pasos está correctamente implementado para recibir y mostrar los pasos.** Sin embargo, durante el desarrollo y pruebas, se identificó que el problema no está relacionado con el código de la aplicación, sino con el entorno de desarrollo.

### Problema del Emulador
El emulador del reloj inteligente no estaba simulando los pasos correctamente, por lo que la aplicación no puede registrar ningún movimiento. Esto significa que:

- La aplicación no puede detectar pasos simulados en el emulador
- No se reflejan datos de actividad en la aplicación
- La pantalla muestra "No se pudieron obtener los datos de pasos"

**La aplicación funciona correctamente, pero al no poder simular pasos en el emulador, no se reflejan datos en la aplicación.**

## 📋 Proceso de Desarrollo y Diagnóstico del Error

### Paso 1: Configuración Inicial del Emulador
![Emparejamiento del Reloj](capturas/reloj%20y%20emulador%20emparejados.PNG)

**Explicación del Paso 1:**
- Se configuró correctamente el emulador del reloj inteligente
- El emparejamiento entre el reloj y el emulador fue exitoso
- La conexión entre dispositivos se estableció sin problemas
- **Estado**: ✅ Configuración correcta

### Paso 2: Aplicación Funcionando con Datos Simulados
![Pantalla Principal](capturas/Pantalla%20contador%20de%20pasos.PNG)

**Explicación del Paso 2:**
- La aplicación se ejecuta correctamente en el emulador
- La interfaz se muestra perfectamente con el diseño Material Design
- Los componentes visuales (contador, gráfico, botón) están funcionando
- **Estado**: ✅ Interfaz funcionando correctamente

### Paso 3: Intento de Emulación de Pasos
![Intento de Emulación](capturas/intentando%20emular%20los%20pasos.PNG)

**Explicación del Paso 3:**
- Se intentó simular pasos en el emulador del reloj
- El emulador no puede generar datos reales de sensores de movimiento
- Los sensores de acelerómetro y giroscopio no se simulan correctamente
- **Estado**: ❌ Emulación de sensores fallida

### Paso 4: Error Final - No se Pueden Obtener Datos
![Error de Datos](capturas/no%20salva%20los%20pasos.PNG)

**Explicación del Paso 4:**
- Como resultado de la falla en la emulación de sensores
- La aplicación no puede obtener datos reales de pasos
- Se muestra el mensaje de error "No se pudieron obtener los datos de pasos"
- **Estado**: ❌ Error final debido a limitaciones del emulador


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


## 🚀 Instalación y Configuración

### 1. Preparación del Entorno
```bash
# Clonar el repositorio
git clone https://github.com/MarlaMendez/ContadorDePasos
cd ContadorDePasos/contadordepasos

# Instalar dependencias
flutter pub get
```

## 📱 Capturas de Pantalla y Explicación Paso a Paso

### 1. Pantalla Principal - Aplicación Funcionando
![Pantalla Principal](capturas/Pantalla%20contador%20de%20pasos.PNG)

**Explicación**: Esta captura muestra la aplicación funcionando correctamente con datos simulados. La interfaz incluye:
- Contador principal de pasos
- Gráfico de distribución horaria
- Botón de actualización
- Diseño moderno en tonos índigo

### 2. Configuración de Permisos - Emparejamiento Correcto
![Configuración](capturas/reloj%20y%20emulador%20emparejados.PNG)

**Explicación**: Muestra el proceso de emparejamiento entre el reloj inteligente y el emulador. Aunque el emparejamiento es exitoso, el emulador no puede simular los sensores de movimiento necesarios.

### 3. Error de Datos - Problema del Emulador
![Error de Datos](capturas/no%20salva%20los%20pasos.PNG)

**Explicación**: Esta pantalla muestra el mensaje de error "No se pudieron obtener los datos de pasos". Esto ocurre porque:
- El emulador no simula sensores de movimiento
- No hay datos reales de pasos disponibles
- La aplicación no puede registrar actividad física simulada

### 4. Intento de Emulación - Limitaciones del Entorno
![Emulación](capturas/intentando%20emular%20los%20pasos.PNG)




