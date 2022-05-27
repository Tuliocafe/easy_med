import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:easy_med/servico/servico_cadastro.dart';
import 'package:easy_med/telas/tela_login.dart';
import 'package:easy_med/widget/autenticacao_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/notificacao_api.dart';
import 'model/usuario.dart';




void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  // listenNotifications();
  await AndroidAlarmManager.initialize();
  await Firebase.initializeApp();



  runApp(
    // MultiProvider(providers: [
      // ainda estou aprendendo como usa.
      // ChangeNotifierProvider(create: (context) => ServicoCadastro()),
      // ChangeNotifierProvider(create: (context) => ServicoAutenticacao()),
      // ChangeNotifierProvider(create: (context) => ServicoAutenticacaoGoogle()),


    // ],
    //     child: MyApp()),
  MyApp()
  );
}

// void listenNotifications(){
//   NotificationService.onNotifications.stream.listen(onClickNotification);
// }
//
// void onClickNotification(String? payload){
//    notificacao();
//
// }


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: telalogin(),
      // home: notificacao()
      // home: TelaUsuario(),
      // home: cadastroUsuario(),
      // home: alarme(),
      // home: confirmacao(),
      // home: VerificarAuthWidget(),
    );
  }
}







