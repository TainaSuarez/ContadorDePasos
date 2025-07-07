import 'package:health/health.dart';
import '../model/pasos_model.dart';


class HealthConnectService {
  final Health _health = Health();

  Future<bool> solicitarPermisos() async {
    final types = [HealthDataType.STEPS];
    final permissions = [HealthDataAccess.READ];
    return await _health.requestAuthorization(types, permissions: permissions);
  }

  Future<RegistrarlosPasos?> obtenerPasos24h() async {
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
      return RegistrarlosPasos(
        cantidad_pasos: totalSteps,
        fechainicio: start,
        fechafin: now,
      );
    } catch (e) {
      print('No se pudieron obtener los pasos: $e');
      return null;
    }
  }
}