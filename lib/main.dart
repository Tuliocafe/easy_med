import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:easy_med/telas/tela_login.dart';
import 'package:flutter/material.dart';
import 'api/notificacao_api.dart';



void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await AndroidAlarmManager.initialize();


  runApp(
  MyApp()
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: telalogin(),
    );
  }
}







