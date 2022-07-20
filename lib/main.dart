import 'package:findphone_vdos/model/dispositivo.dart';
import 'package:findphone_vdos/screens/listadipositivos.dart';
import 'package:findphone_vdos/service/dispositivo_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:findphone_vdos/screens/login.dart';

void main() =>runApp(AppState());


class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DispositivoServicio())],
      child: App(),
    );
  }
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dispositivos',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: 'Login',
      routes: {
        'Dispositivos': (_) => ListaDispositivos(),
        'Login': (_) => Login(),
      },
    );
  }
}
