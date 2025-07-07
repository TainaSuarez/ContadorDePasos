# Contador de Pasos - Documentación Técnica

## ¿Cómo funciona la aplicación?
La aplicación "Contador de Pasos" está desarrollada en Flutter y permite al usuario visualizar la cantidad de pasos dados en las últimas 24 horas, así como la distribución horaria de esos pasos. Utiliza el patrón MVVM (Model-View-ViewModel) y Provider para la gestión de estado. La interfaz es moderna y responsiva, mostrando un contador principal, un gráfico de barras y un botón para actualizar los datos.

- Al iniciar, la app solicita los permisos necesarios para acceder a los datos de pasos.
- Si los permisos son concedidos, consulta los pasos almacenados en Health Connect y los muestra en pantalla.
- Si no hay datos disponibles (por ejemplo, en emulador), muestra un mensaje de error informativo.

## Permisos utilizados
La app requiere los siguientes permisos declarados en el `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION"/>
<uses-permission android:name="android.permission.health.READ_STEPS"/>
<uses-permission android:name="android.permission.health.WRITE_STEPS"/>
<uses-permission android:name="android.permission.ACCESS_HEALTH_CONNECT"/>
```

Estos permisos permiten leer y escribir datos de pasos a través de Health Connect y acceder al reconocimiento de actividad física.

## Acceso a los datos a través de Health Connect
La app utiliza el paquete [`health`](https://pub.dev/packages/health) para interactuar con Health Connect. El flujo es:

1. Solicita autorización al usuario para acceder a los datos de pasos.
2. Si el usuario concede los permisos, la app consulta los pasos de las últimas 24 horas usando la API de Health Connect.
3. Los datos se muestran en la pantalla principal y se actualizan al presionar el botón correspondiente.

El acceso se realiza de forma segura y conforme a las políticas de privacidad de Android y Health Connect.

## Simulación de pasos
Durante el desarrollo, se intentó simular pasos en el emulador usando comandos ADB como:

```sh
adb -s emulator-5556 shell am broadcast -a "whs.USE_SYNTHETIC_PROVIDERS" com.google.android.wearable.healthservices
adb -s emulator-5556 shell am broadcast -a "whs.synthetic.user.START_WALKING" com.google.android.wearable.healthservices
```

Sin embargo, debido a limitaciones del emulador y de Health Connect en versiones recientes de Android, los pasos simulados no se reflejan en la app ni en Health Connect. Este es un problema conocido y reportado por otros desarrolladores y docentes.

**Nota:** En un dispositivo físico, la app funcionaría correctamente si los permisos y sensores están disponibles y configurados.

## 🏃‍♂️ Instrucciones para ejecutar la aplicación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/usuario/ContadorDePasos
   cd ContadorDePasos/contadordepasos
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Conecta un dispositivo físico o inicia un emulador compatible.

4. Ejecuta la app:
   ```bash
   flutter run
   ```

5. Concede los permisos solicitados en el dispositivo/emulador.

6. Si usas un emulador, ten en cuenta las limitaciones para simular pasos (ver sección anterior).


