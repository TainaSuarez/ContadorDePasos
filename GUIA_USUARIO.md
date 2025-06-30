# Guía de Usuario - Contador de Pasos

## 📱 Bienvenido a Contador de Pasos

**Contador de Pasos** es tu compañero perfecto para monitorear tu actividad física diaria. Esta aplicación te permite visualizar de manera clara y atractiva el número de pasos que has dado en las últimas 24 horas, junto con un análisis detallado de tu actividad por hora.

---

## 🚀 Primeros Pasos

### Requisitos Previos

Antes de usar la aplicación, asegúrate de tener:

- ✅ **Android 8.0 o superior** en tu dispositivo
- ✅ **Google Health Connect** instalado desde Google Play Store
- ✅ **Permisos de actividad física** habilitados en tu dispositivo
- ✅ **Conexión a internet** para la configuración inicial

### Instalación

1. **Descargar la aplicación** desde la fuente oficial
2. **Instalar el APK** en tu dispositivo Android
3. **Abrir la aplicación** por primera vez
4. **Seguir las instrucciones** de configuración

---

## 🔧 Configuración Inicial

### Paso 1: Configurar Google Health Connect

![Configuración de Health Connect](capturas/reloj%20y%20emulador%20emparejados.PNG)

1. **Abrir Google Health Connect** en tu dispositivo
2. **Crear una cuenta** o iniciar sesión con tu cuenta de Google
3. **Configurar tu perfil** con información básica (edad, peso, altura)
4. **Habilitar el seguimiento de pasos** en la configuración

### Paso 2: Conceder Permisos

Cuando abras la aplicación por primera vez:

1. **Aparecerá una solicitud de permisos** - Toca "Permitir"
2. **Se abrirá Health Connect** - Confirma el acceso a datos de pasos
3. **Regresa a la aplicación** - Los datos comenzarán a cargarse automáticamente

### Paso 3: Verificar la Configuración

- ✅ La aplicación muestra un indicador de carga
- ✅ Los permisos se solicitan correctamente
- ✅ Los datos de pasos se cargan sin errores

---

## 📊 Interfaz Principal

### Pantalla Principal

![Pantalla Principal](capturas/Pantalla%20contador%20de%20pasos.PNG)

La pantalla principal de la aplicación incluye:

#### 1. **Barra de Navegación**
- **Título**: "Contador de Pasos"
- **Color**: Índigo (tema principal de la aplicación)

#### 2. **Tarjeta de Pasos**
- **Icono**: 👟 Símbolo de caminar
- **Información**: Total de pasos en las últimas 24 horas
- **Diseño**: Tarjeta moderna con sombras y bordes redondeados

#### 3. **Gráfico de Distribución Horaria**
- **Título**: "Distribución por hora"
- **Visualización**: Gráfico de barras con 24 columnas (una por hora)
- **Colores**: Barras en tono verde azulado
- **Eje X**: Horas del día (0h a 23h)
- **Eje Y**: Número de pasos por hora

#### 4. **Botón de Actualización**
- **Texto**: "Actualizar Datos"
- **Función**: Refrescar los datos de pasos
- **Estilo**: Botón elevado en color índigo

---

## 🎯 Cómo Usar la Aplicación

### Visualizar tus Pasos

1. **Abrir la aplicación** - Se cargarán automáticamente los datos
2. **Revisar el contador principal** - Ver el total de pasos del día
3. **Analizar el gráfico** - Identificar tus horas más activas
4. **Actualizar cuando sea necesario** - Usar el botón "Actualizar Datos"

### Interpretar el Gráfico

El gráfico de distribución horaria te ayuda a:

- **Identificar patrones** de actividad durante el día
- **Encontrar tus horas pico** de movimiento
- **Detectar períodos sedentarios** que podrías mejorar
- **Planificar mejor** tu actividad física

### Ejemplo de Interpretación

```
Horas 6-8:   Poca actividad (despertando)
Horas 9-12:  Actividad moderada (trabajo/estudio)
Horas 12-14: Pico de actividad (almuerzo, caminatas)
Horas 15-18: Actividad constante (trabajo/actividades)
Horas 19-22: Actividad variable (ejercicio, ocio)
Horas 23-5:  Mínima actividad (descanso)
```

---

## ⚠️ Solución de Problemas

### Problema: No se cargan los datos

![Error de Carga](capturas/no%20salva%20los%20pasos.PNG)

**Síntomas:**
- La aplicación muestra un mensaje de error
- No aparece el contador de pasos
- El gráfico no se muestra

**Soluciones:**

#### 1. Verificar Health Connect
```
1. Abrir Google Health Connect
2. Verificar que esté instalado y actualizado
3. Comprobar que el seguimiento de pasos esté habilitado
4. Revisar que la cuenta esté configurada correctamente
```

#### 2. Revisar Permisos
```
1. Ir a Configuración > Aplicaciones > Contador de Pasos
2. Verificar que los permisos estén concedidos
3. Si no están, tocar "Permisos" y habilitar "Actividad física"
4. Reiniciar la aplicación
```

#### 3. Verificar Datos de Actividad
```
1. Abrir Google Health Connect
2. Ir a "Pasos" en el menú principal
3. Verificar que haya datos de pasos registrados
4. Si no hay datos, caminar un poco y esperar unos minutos
```

### Problema: Gráfico no se muestra correctamente

**Síntomas:**
- El gráfico aparece vacío
- Las barras no tienen altura
- El gráfico se ve distorsionado

**Soluciones:**

#### 1. Verificar Datos
```
1. Comprobar que el contador principal muestre un número mayor a 0
2. Si el contador es 0, no habrá datos para mostrar en el gráfico
3. Caminar un poco y actualizar los datos
```

#### 2. Reiniciar la Aplicación
```
1. Cerrar completamente la aplicación
2. Volver a abrirla
3. Esperar a que se carguen los datos
```

### Problema: Permisos no se conceden

**Síntomas:**
- Mensaje de error sobre permisos
- La aplicación no puede acceder a datos de salud

**Soluciones:**

#### 1. Configurar Health Connect Manualmente
```
1. Abrir Google Health Connect
2. Ir a Configuración > Aplicaciones conectadas
3. Buscar "Contador de Pasos"
4. Habilitar el acceso a datos de pasos
```

#### 2. Reinstalar la Aplicación
```
1. Desinstalar Contador de Pasos
2. Reiniciar el dispositivo
3. Volver a instalar la aplicación
4. Seguir el proceso de configuración desde el inicio
```

---

## 🔄 Actualización de Datos

### Actualización Automática

La aplicación carga automáticamente los datos cuando:
- Se abre por primera vez
- Se vuelve a abrir después de estar cerrada
- Se detecta una nueva sesión de Health Connect

### Actualización Manual

Para actualizar manualmente los datos:

1. **Tocar el botón "Actualizar Datos"**
2. **Esperar el indicador de carga**
3. **Verificar que los datos se hayan actualizado**

### Frecuencia de Actualización

- **Recomendado**: Actualizar cada 1-2 horas para datos precisos
- **Mínimo**: Una vez al día para seguimiento básico
- **Máximo**: Cada 15-30 minutos para seguimiento intensivo

---

## 📈 Consejos para Mejorar tu Actividad

### Establecer Metas Diarias

- **Principiantes**: 5,000 - 7,000 pasos por día
- **Intermedios**: 8,000 - 10,000 pasos por día
- **Avanzados**: 10,000+ pasos por día

### Estrategias para Aumentar Pasos

#### 1. **Durante el Trabajo**
- Usar las escaleras en lugar del ascensor
- Caminar durante las pausas
- Hacer reuniones caminando
- Estacionar más lejos de la entrada

#### 2. **En Casa**
- Caminar mientras hablas por teléfono
- Hacer tareas domésticas activamente
- Jugar con mascotas o niños
- Caminar después de las comidas

#### 3. **En el Tiempo Libre**
- Hacer caminatas recreativas
- Explorar nuevos lugares a pie
- Usar transporte público
- Practicar deportes que impliquen caminar

### Monitoreo de Progreso

- **Revisar el gráfico** diariamente para identificar patrones
- **Establecer recordatorios** para moverse regularmente
- **Celebrar logros** cuando alcances tus metas
- **Ajustar objetivos** según tu progreso

---

## 🔧 Configuración Avanzada

### Personalización de la Interfaz

La aplicación utiliza un tema personalizado con:
- **Color principal**: Índigo (#3F51B5)
- **Fuente**: Roboto
- **Diseño**: Material Design

### Optimización de Batería

Para optimizar el consumo de batería:
- **Cerrar la aplicación** cuando no la uses
- **Evitar actualizaciones excesivas** (más de cada 30 minutos)
- **Usar modo de ahorro de batería** en el dispositivo

### Sincronización de Datos

Los datos se sincronizan automáticamente con:
- **Google Health Connect**
- **Dispositivos conectados** (relojes inteligentes, bandas de fitness)
- **Otras aplicaciones de salud** compatibles

---

## 📞 Soporte y Ayuda

### Contacto de Soporte

Si necesitas ayuda adicional:

- **Email**: [tu-email@ejemplo.com]
- **Issues**: Crear un issue en el repositorio del proyecto
- **Documentación**: Consultar esta guía y la documentación técnica

### Información Técnica

- **Versión**: 1.0.0
- **Plataforma**: Android 8.0+
- **Integración**: Google Health Connect
- **Idioma**: Español

### Reportar Problemas

Al reportar un problema, incluye:
- **Versión de Android** de tu dispositivo
- **Versión de Health Connect**
- **Descripción detallada** del problema
- **Pasos para reproducir** el error
- **Capturas de pantalla** si es posible

---

## 📱 Capturas de Pantalla de Referencia

### Pantalla Principal Funcionando
![Pantalla Principal](capturas/Pantalla%20contador%20de%20pasos.PNG)

### Configuración de Permisos
![Configuración](capturas/reloj%20y%20emulador%20emparejados.PNG)

### Manejo de Errores
![Errores](capturas/no%20salva%20los%20pasos.PNG)

### Emulación de Datos (Desarrollo)
![Emulación](capturas/intentando%20emular%20los%20pasos.PNG)

---

## 🎉 ¡Disfruta tu Viaje hacia una Vida Más Activa!

**Contador de Pasos** está diseñado para ser tu compañero en el camino hacia una vida más saludable y activa. Con esta aplicación, podrás:

- 📊 **Visualizar** tu actividad diaria de manera clara
- 📈 **Analizar** tus patrones de movimiento
- 🎯 **Establecer** y alcanzar metas de actividad
- 💪 **Motivarte** para mantenerte activo

¡Recuerda que cada paso cuenta hacia una vida más saludable!

---

**Guía de Usuario v1.0** - Contador de Pasos 