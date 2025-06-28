import 'package:flutter/services.dart';
import '../model/pasos_model.dart';


class HealthConnectService {
  static const platform = MethodChannel('com.example.contador_pasos/pasos');

  Future<bool> solicitarPermisos() async {
    try {
      final result = await platform.invokeMethod('solicitarPermisos');
      return result == true;
    } catch (e) {
      print('Error al solicitar permisos: $e');
      return false;
    }
  }

  Future<RegistrarlosPasos?> obtenerPasos24h() async {
    try {
      // Primero solicitar permisos
      final permisosConcedidos = await solicitarPermisos();
      if (!permisosConcedidos) {
        print('Permisos no concedidos para Health Connect');
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