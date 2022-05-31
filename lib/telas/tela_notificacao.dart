import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:easy_med/database/dao/relatorio_dao.dart';
import 'package:easy_med/database/dao/usuario_dao.dart';
import 'package:easy_med/examples/alarm_manger_exmples.dart';
import 'package:easy_med/telas/tela_cadastro_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/notificacao_api.dart';
import '../database/app_database.dart';
import '../database/dao/alarme_dao.dart';
import '../database/dao/medicamento_dao.dart';
import '../model/alarme.dart';
import '../model/medicamento.dart';
import '../model/relatorio.dart';
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
  Medicamento? medicamento;
  Alarme? alarme;
  String? email;
  int? ultimoalarme;
  Alarme? ultimoAlarme;
  final medicamentoDao daoMedicamento = medicamentoDao();
  final alarmeDao daoAlarme = alarmeDao();
  final usuarioDao daoUsuario = usuarioDao();
  final relatorioDao daoRelatorio = relatorioDao();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  NotificationService _notificationService = NotificationService();
  bool isOn = false;
  int alarmId = 3;
  List<Map> relatorio = [];

  //
  // Future IncluirRelatorio() async{
  //   final relatorio = await daoRelatorio.findAll1();
  //
  //   setState(() {
  //     this.relatorio = relatorio;
  //   });
  // }


  Future getMedicamento() async {
    final medicamento =
        await daoMedicamento.getMedicamentoId(ultimoAlarme?.idMedicamento);
    setState(() {
      this.medicamento = medicamento;
    });
  }

  @override
  void initState() {
    super.initState();
    listenNotification();
  }

  void listenNotification() =>
      NotificationService.onNotifications.stream.listen(onCliclNotification);

  void onCliclNotification(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => cadastroUsuario(),
    ));
  }

  // void teste() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => cadastroUsuario(),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro Especial'),
        centerTitle: true,
      ),
      endDrawer: MenuLateralWidget(usuario: widget.usuario),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  apagabanco();
                },
                child: Text('Apaga Banco'),
              )),
          Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  daoMedicamento.salvarMedicamento(Medicamento(
                      nome: 'Dorflex',
                      dosagem: '1g',
                      laboratorio: 'De nos todos'));
                  daoMedicamento.salvarMedicamento(Medicamento(
                      nome: 'Dipirona',
                      dosagem: '1g',
                      laboratorio: 'Neo Quimica'));
                  daoMedicamento.salvarMedicamento(Medicamento(
                      nome: 'Loratadina',
                      dosagem: '10mg',
                      laboratorio: 'Prati Donaduzzi'));
                  daoMedicamento.salvarMedicamento(Medicamento(
                      nome: 'Meloxicam',
                      dosagem: '15mg',
                      laboratorio: 'Medquimica'));
                  daoMedicamento.salvarMedicamento(Medicamento(
                      nome: 'Albendazol',
                      dosagem: '400mg',
                      laboratorio: 'Prati Donaduzzi'));

                  daoUsuario.salvarUsuario(Usuario(
                      nome: 'Tulio Cafe',
                      sexo: 'masculino',
                      idade: 39,
                      email: 'tuliocafe@yahoo.com.br',
                      senha: '123456',
                      tipo: 'normal'));
                },
                child: Text('Cadastrar Medicamentos e Usuario Padrao'),
              )),
          Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {


                   // var relatoio = daoRelatorio.findAllRelatorio();
                   // print(relatoio);

                },
                child: Text('Botao de teste'),
              )),

          // Padding(
          //   padding: EdgeInsets.all(16),
          //   child: Switch(
          //     value: isOn,
          //     onChanged: (value) {
          //       setState(() {
          //         isOn = value;
          //       });
          //       if (isOn == true) {
          //         print(DateTime.now());
          //         AndroidAlarmManager.oneShotAt(
          //           // date time format (year,month,date,hour,minutes,seconds)
          //           DateTime(2022, 03, 20, 00, 20),
          //           alarmId,
          //           fireAlarm,
          //         );
          //       } else {
          //         AndroidAlarmManager.cancel(2);
          //         print('Alarm Timer Canceled');
          //       }
          //     },
          //   ),
          // ),
        ]),
      ),
    );
  }
}

void fireAlarm() {
  print('Vai tomar remedio cara ');
  // _notificationService.showNotifications();
}

notifica() async {
  final ultimoAlarme = await alarmeDao().getultimoAlarmeBD();

  final notifica = NotificationService();
  await notifica.init();
  await notifica.showNotifications(
      ultimoAlarme.idAlarme!, ultimoAlarme.idMedicamento.toString());
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
