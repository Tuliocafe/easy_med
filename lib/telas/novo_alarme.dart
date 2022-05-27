import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:easy_med/database/dao/alarme_dao.dart';
import 'package:easy_med/database/dao/usuario_dao.dart';
import 'package:easy_med/telas/tela_alarme.dart';
import 'package:easy_med/telas/tela_notificacao.dart';
import 'package:easy_med/telas/tela_principal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

import '../api/notificacao_api.dart';
import '../database/dao/medicamento_dao.dart';
import '../model/alarme.dart';
import '../model/medicamento.dart';
import '../model/usuario.dart';
import 'modal_cadastro_alarme.dart';

class NovoAlarme extends StatefulWidget {
  final Usuario? usuario;

  NovoAlarme({Key? key, this.usuario}) : super(key: key);

  @override
  State<NovoAlarme> createState() => _NovoAlarmeState();
}

class _NovoAlarmeState extends State<NovoAlarme> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  NotificationService _notificationService = NotificationService();

  Usuario? usuario;
  final nomeAlarme = TextEditingController();
  final horaAlarme = TextEditingController();
  final minutoAlarme = TextEditingController();
  final quantidadeAlarme = TextEditingController();
  final usuarioDao daoUsuario = usuarioDao();
  Medicamento? medicamento;
  Alarme? alarme;
  final medicamentoDao daoMedicamento = medicamentoDao();
  final alarmeDao daoAlarme = alarmeDao();
  int? ultimoalarme;
  Alarme? ultimoAlarme;

  // const AddTodoButton({Key key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  String? medicamentoSelecionado;
  List<Medicamento> listaMedicamento = [];
  Medicamento? ultimoMedic;

  @override
  void initState() {
    super.initState();
    atualizarlistaMedicamento();
    listenNotification();
  }

  void listenNotification() =>
      NotificationService.onNotifications.stream.listen(onCliclNotification);

  void onCliclNotification(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TelaAlarme(),
    ));
  }

  void atualizarlistaMedicamento() async {
    final listaMedicamento = await daoMedicamento.getMedicamentoNome();
    setState(() {
      this.listaMedicamento = listaMedicamento;
    });
  }

  Future registraAlarme() async {
  // print(widget.usuario?.idUsuario);
    try {
      await daoAlarme.salvarAlarme(Alarme(
        nome: nomeAlarme.text,
        idMedicamento: int.parse(medicamentoSelecionado!),
        hora: horaAlarme.text,
        minuto: minutoAlarme.text,
        idUsuario: widget.usuario?.idUsuario,
        quantidade: int.parse(quantidadeAlarme.text),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future getultimoID() async {
    final alarmenow = await daoAlarme.getIdUltimoAlarme();
    final ultimoAlarme = await daoAlarme.getultimoAlarmeBD();
    setState(() {
      this.ultimoAlarme = ultimoAlarme;
    });

    ultimoalarme = alarmenow;
  }

  Future getMedicamento()async{
    final medicamento = await daoMedicamento.getMedicamentoId(ultimoAlarme?.idMedicamento);
    setState(() {
      this.medicamento = medicamento;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Material(
            // color: AppColors.accentColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nomeAlarme,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome do Alarme'),
                        cursorColor: Colors.white,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      buildMedicamento(),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      TextFormField(
                        controller: horaAlarme,
                        decoration: const InputDecoration(
                          labelText: 'Hora',
                          border: OutlineInputBorder(),
                        ),
                        cursorColor: Colors.white,
                        // maxLines: 2,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      TextFormField(
                        controller: minutoAlarme,
                        decoration: const InputDecoration(
                          labelText: 'minuto',
                          border: OutlineInputBorder(),
                        ),
                        cursorColor: Colors.white,
                        // maxLines: 2,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      TextFormField(
                        controller: quantidadeAlarme,
                        decoration: const InputDecoration(
                          labelText: 'Quantidade Atual',
                          border: OutlineInputBorder(),
                        ),
                        cursorColor: Colors.white,
                        // maxLines: 2,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: Size.fromHeight(50),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          // print(widget.usuario);

                          // date time format (year,month,date,hour,minutes,seconds)
                          try {
                            registraAlarme().then((value) =>
                          getultimoID().then(
                                (value) => getMedicamento().then((value) =>
                          AndroidAlarmManager.oneShotAt(
                                        DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day,
                                            int.parse(horaAlarme.text),
                                            int.parse(minutoAlarme.text)),

                                            // ultimoAlarme.idMedicamento!, verificar como fazer
                                        ultimoalarme!,
                                        notifica,
                                        exact: true,
                                        alarmClock: true,
                                        wakeup: true,
                                        allowWhileIdle: true,
                                        rescheduleOnReboot: true)
                                    // .then((value) =>
                                    //     FlutterAlarmClock.createAlarm(
                                    //         int.parse(horaAlarme.text),
                                    //         int.parse(minutoAlarme.text)))
                                          )));
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (context) => TelaPrincipal(usuario: widget.usuario)),
                          (route) => false);
                            // await Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => TelaAlarme(
                            //           usuario: widget.usuario,
                            //         )));
                          } catch (e) {
                            print(e);
                          }
                          // Navigator.of(context).pop(); nao apresentou o resultado esperado
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMedicamento() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
      child: Row(
        children: <Widget>[
          DropdownButton<String>(
            hint: const Text(
              'Medicamento',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            value: medicamentoSelecionado,
            iconSize: 24,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            style: const TextStyle(color: Colors.black),
            borderRadius: BorderRadius.circular(16),
            items: listaMedicamento.map((map) {
              return DropdownMenuItem(
                child: Text(map.nome.toString()),
                value: map.idMedicamento.toString(),
              );
            }).toList(),
            // listaMedicamento.map((String, String medCadastroJson) {
            //   return DropdownMenuItem<String, String>(
            //     value: id,
            //     child: Text(medCadastroJson),
            //   );
            // }).toList(),
            onChanged: (String? idSelecionado) {
              setState(() {
                medicamentoSelecionado = idSelecionado;
              });
            },
          )
        ],
      ),
    );
  }


}
