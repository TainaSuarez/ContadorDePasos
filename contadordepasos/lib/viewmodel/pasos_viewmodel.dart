import 'package:flutter/material.dart';
import '../model/pasos_model.dart';

import 'package:health/health.dart';

class PasosViewmodel extends ChangeNotifier {
  final _health = Health();
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
        print('Solicitando permisos de Health Connect...');
        try {
          final types = [HealthDataType.STEPS];
          final permissions = [HealthDataAccess.READ];
          final permisosConcedidos = await _health.requestAuthorization(types, permissions: permissions);
          print('Permisos concedidos: $permisosConcedidos');
          permisosSolicitados = true;
          if (!permisosConcedidos) {
            errorMessage = "Se requieren permisos de Health Connect para acceder a los datos de pasos";
            print('Permisos NO concedidos.');
            isLoading = false;
            notifyListeners();
            return;
          }
        } catch (e) {
          errorMessage = "Error al solicitar permisos: $e";
          print('Error al solicitar permisos: $e');
          isLoading = false;
          notifyListeners();
          return;
        }
      }

      final now = DateTime.now();
      final start = now.subtract(const Duration(hours: 24));
      try {
        final types = [HealthDataType.STEPS];
        final stepsData = await _health.getHealthDataFromTypes(
          types: types,
          startTime: start,
          endTime: now,
        );
        int totalSteps = 0;
        for (var data in stepsData) {
          if (data.type == HealthDataType.STEPS && data.value is num) {
            totalSteps += (data.value as num).toInt();
          }
        }
        registro = RegistrarlosPasos(
          cantidad_pasos: totalSteps,
          fechainicio: start,
          fechafin: now,
        );
        errorMessage = null;
      } catch (e) {
        errorMessage = "No se pudieron obtener los datos de pasos: $e";
      }
    } catch (e) {
      errorMessage = "Error al cargar los datos: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  }



