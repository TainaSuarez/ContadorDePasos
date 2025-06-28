import 'package:flutter/services.dart';
import '../model/pasos_model.dart';


class HealthConnectService {
  static const platform = MethodChannel('com.example.contador_pasos/pasos');

  Future<RegistrarlosPasos?> obtenerPasos24h() async {
    try {
      final result = await platform.invokeMethod('getpasos24h');
      return RegistrarlosPasos(
        cantidad_pasos: result ['cantidad_pasos'],
         fechainicio: DateTime.parse(result['inicio']), 
         fechafin: DateTime.parse(result['fin'])
      );
    } catch (e) {
      print('No se pudieron obtener los pasos: $e');
      return null;
    }
  }
}