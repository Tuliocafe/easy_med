

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:easy_med/examples/alarm_manger_exmples.dart';
import 'package:easy_med/telas/tela_cadastro_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/notificacao_api.dart';
import '../main.dart';
import '../model/usuario.dart';
import '../widget/menu_lateral_widget.dart';

class notificacao extends StatefulWidget {
  final Usuario? usuario;
  // final String? payload;
  const notificacao({Key? key, this.usuario}) : super(key: key);

  @override
  _notificacaoState createState() => _notificacaoState();
}


class _notificacaoState extends State<notificacao> {
  String? email;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  NotificationService _notificationService = NotificationService();
  bool isOn = false;
  int alarmId = 3;

  @override
  void initState(){
    super.initState();
    listenNotification();
  }

  void listenNotification() => NotificationService.onNotifications.stream.listen(onCliclNotification);

  void onCliclNotification(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => cadastroUsuario(),));
  }

  void teste (){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => cadastroUsuario(),));
  }



    @override
    Widget build(BuildContext context) {
    email = widget.usuario?.email;
      return Scaffold(
        appBar: AppBar(
          title: Text('Easy Med'),
          centerTitle: true,
        ),
        endDrawer: MenuLateralWidget(usuario: widget.usuario),
        body: Center(
          child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () async {
                    // await _notificationService.showNotifications();
                    AndroidAlarmManager.oneShot(
                      // date time format (year,month,date,hour,minutes,seconds)
                        Duration(seconds: 5),
                        alarmId,
                        navega,
                        exact: true,
                        alarmClock: true,
                        wakeup: true,
                        allowWhileIdle: true,
                        rescheduleOnReboot: true);
                  },
                  child: Text('Botao teste'),
                )),
            Padding(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () async {
                    // await _notificationService.showNotifications();
                    AndroidAlarmManager.oneShotAt(
                      // date time format (year,month,date,hour,minutes,seconds)
                        DateTime(2022, 03, 21, 10, 10),
                        alarmId,
                        notifica,
                        exact: true,
                        alarmClock: true,
                        wakeup: true,
                        allowWhileIdle: true,
                        rescheduleOnReboot: true);
                  },
                  child: Text('Agendar com data'),
                )),

            Padding(
              padding: EdgeInsets.all(16),
              child: Switch(
                value: isOn,
                onChanged: (value) {
                  setState(() {
                    isOn = value;
                  });
                  if (isOn == true) {
                    print(DateTime.now());
                    AndroidAlarmManager.oneShotAt(
                      // date time format (year,month,date,hour,minutes,seconds)
                      DateTime(2022, 03, 20, 00, 20),
                      alarmId,
                      fireAlarm,
                    );
                  } else {
                    AndroidAlarmManager.cancel(2);
                    print('Alarm Timer Canceled');
                  }
                },
              ),
            ),
            Padding(padding: EdgeInsets.all(16),
              child: Text(email!),

            ),
          ]),
        ),
      );
    }
  }


void fireAlarm() {
  print('Vai tomar remedio caralho ');
  // _notificationService.showNotifications();
}


void notifica() async{
  print('que que pega foi?');


  // final noticia = NotificationService();
  // await noticia.init();
  // await noticia.showNotifications();
}


navega() {
  print('que que pega?');
  // NotificationService.teste;
  // Navigator.pushNamed(context,  '/secontod');
  // return MaterialPageRoute(builder: (context) =>  cadastroUsuario());
}








// class telainicial extends StatelessWidget {
//   const telainicial({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Easy Med'), centerTitle: true,
//         ),
//         body: Center(
//             child: Padding(padding: EdgeInsets.all(16),
//                 child: ElevatedButton(onPressed: () {
//
//                   _showNotification(
//                     // title: 'E o remedio zé??',
//                     // body: 'Tu vai tomar esse trem ou nao vai mano ?',
//                     // // payload: 'easy.med',
//                   );
//                 }, child: Text('Botao teste'),))
//
//         )
//     );
//   }
//
//   // Future<void> _showNotification() async {
//   //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//   //   AndroidNotificationDetails('your channel id', 'your channel name',
//   //       channelDescription: 'your channel description',
//   //       importance: Importance.max,
//   //       priority: Priority.high,
//   //       ticker: 'ticker');
//   //   const NotificationDetails platformChannelSpecifics =
//   //   NotificationDetails(android: androidPlatformChannelSpecifics);
//   //   await flutterLocalNotificationsPlugin.show(
//   //       0, 'bora ver esse trem', 'vai funcionar ?', platformChannelSpecifics,
//   //       payload: 'item x');
//   }
//
//
