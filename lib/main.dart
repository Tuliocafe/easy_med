
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:easy_med/model/usuario.dart';
import 'package:easy_med/servico/servico_autenticacao.dart';
import 'package:easy_med/servico/servico_autenticacao_google.dart';
import 'package:easy_med/servico/servico_cadastro.dart';
import 'package:easy_med/telas/tela_alarme.dart';
import 'package:easy_med/telas/tela_cadastro_usuario.dart';
import 'package:easy_med/telas/tela_login.dart';
import 'package:easy_med/telas/tela_notificacao.dart';
import 'package:easy_med/telas/tela_usuario.dart';
import 'package:easy_med/telas/teste_tela_alarme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/notificacao_api.dart';
import 'database/app_database.dart';




void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await AndroidAlarmManager.initialize();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(providers: [
      // ainda estou aprendendo como usa.
      // ChangeNotifierProvider(create: (context) => ServicoCadastro()),
      // ChangeNotifierProvider(create: (context) => ServicoAutenticacao()),
      // ChangeNotifierProvider(create: (context) => ServicoAutenticacaoGoogle()),


    ],
        child: MyApp()),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: notificacao()
      home: TelaUsuario(),
      // home: cadastroUsuario(),
      // home: alarme(),
    );
  }
}







