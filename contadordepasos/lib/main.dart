import 'package:contador_pasos/viewmodel/pasos_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/pasos_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PasosViewmodel(),
      child: MaterialApp(
        title: 'Contador de Pasos',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.light,
          fontFamily: 'Roboto',
        ),
        home: PasosView(),
      ),
    );
  }
}
