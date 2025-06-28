import 'dart:math';
import 'package:flutter/material.dart';
import '../model/pasos_model.dart';
import '../services/health_connect_service.dart';


class PasosViewmodel extends ChangeNotifier {
  final _service = HealthConnectService();
  RegistrarlosPasos? registro;
  List<int> pasosxhora = List.filled(24, 0);
  bool isLoading = false;
  String? errorMessage;
  bool permisosSolicitados = false;


  Future<void> cargarlospasos () async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      
      if (!permisosSolicitados) {
        final permisosConcedidos = await _service.solicitarPermisos();
        permisosSolicitados = true;
        
        if (!permisosConcedidos) {
          errorMessage = "Se requieren permisos de Health Connect para acceder a los datos de pasos";
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

  void _simularpasosxhora (int total) {
    final random = Random();
    pasosxhora = List.generate(24, (_) => random.nextInt(total ~/ 10));
  }

  }



