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
      appBar: AppBar(title: Text("Contador de Pasos")),
      body: vm.registro == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  PasoCard(
                    titulo: "Pasos en las últimas 24h",
                    valor: "${vm.registro!.cantidad_pasos}",
                    icono: Icons.directions_walk,
                    color: Colors.indigo,
                  ),
                  SizedBox(height: 24),
                  Text("Distribución por hora",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 200, child: GraficoPasos(datosPorHora: vm.pasosxhora)),
                ],
              ),
            ),
    );
  }
}
