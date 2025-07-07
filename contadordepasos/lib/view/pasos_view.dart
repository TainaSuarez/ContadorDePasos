import 'package:contador_pasos/viewmodel/pasos_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/card_paso.dart';
import '../widgets/grafico_paso.dart';

class PasosView extends StatefulWidget {
  @override
  State<PasosView> createState() => _PasosViewState();
}

class _PasosViewState extends State<PasosView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PasosViewmodel>().cargarlospasos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PasosViewmodel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Contador de Pasos"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildBody(vm),
      ),
    );
  }

  Widget _buildBody(PasosViewmodel vm) {
    if (vm.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.indigo),
            SizedBox(height: 16),
            Text(
              "Solicitando permisos y cargando datos...",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (vm.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              vm.errorMessage!,
              style: TextStyle(fontSize: 16, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => vm.cargarlospasos(),
              child: Text("Reintentar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    if (vm.registro == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_walk,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              "No hay datos de pasos disponibles",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => vm.cargarlospasos(),
              child: Text("Cargar Datos"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          PasoCard(
            titulo: "Pasos en las últimas 24h",
            valor: "${vm.registro!.cantidad_pasos}",
            icono: Icons.directions_walk,
            color: Colors.indigo,
          ),
          SizedBox(height: 24),
          Text(
            "Distribución por hora",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          SizedBox(height: 200, child: GraficoPasos(datosPorHora: vm.pasosxhora)),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => vm.cargarlospasos(),
            child: Text("Actualizar Datos"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
