import 'dart:math';
import 'package:flutter/material.dart';
import '../model/pasos_model.dart';
import '../services/health_connect_service.dart';


class PasosViewmodel extends ChangeNotifier {
  final _service = HealthConnectService();
  RegistrarlosPasos? registro;
  List<int> pasosxhora = List.filled(24, 0);


  Future<void> cargarlospasos () async {
    final resultado = await _service.obtenerPasos24h();
    if (resultado != null) {
       registro = resultado;
      _simularpasosxhora(resultado.cantidad_pasos);
      notifyListeners();
    }
    }

  void _simularpasosxhora (int total) {
    final random = Random();
    pasosxhora = List.generate(24, (_) => random.nextInt(total ~/ 10));
  }

  }



