import 'package:easy_med/database/dao/alarme_dao.dart';
import 'package:easy_med/database/dao/usuario_dao.dart';
import 'package:easy_med/model/alarme.dart';
import 'package:easy_med/model/medicamento.dart';
import 'package:easy_med/telas/novo_alarme.dart';
import 'package:easy_med/telas/tela_alarme.dart';
import 'package:easy_med/telas/tela_cadastro_medicamento.dart';
import 'package:easy_med/telas/tela_confirmacao.dart';
import 'package:easy_med/telas/tela_notificacao.dart';
import 'package:flutter/material.dart';

import '../database/dao/medicamento_dao.dart';
import '../model/usuario.dart';
import '../widget/menu_lateral_widget.dart';
import 'modal_cadastro_alarme.dart';


class TelaAlarmeTeste extends StatefulWidget {
  final Usuario? usuario;
  final Medicamento? medicamento;
  final Alarme? alarme;

  // alarme({Key? key}) : super(key: key);

  // final List<AlarmeInfo> alarmes = [
  //
  // ];

  TelaAlarmeTeste({Key? key, this.usuario,this.medicamento, this.alarme}) : super(key: key);

  @override
  _TelaAlarmeState createState() => _TelaAlarmeState();
}

class _TelaAlarmeState extends State<TelaAlarmeTeste> {
  Alarme? alarme;
  Usuario? usuario;
  Medicamento? medicamento;
  final medicamentoDao daoMedicamento = medicamentoDao();
  final alarmeDao daoAlarme = alarmeDao();
  late int id;

  @override
  initState(){
    super.initState();
    int id = 1;
    this.id = id;
  }


  int _indexAtual = 0;


  final telas = [
    TelaAlarme(),
    cadastroMedicameto(),
  ];

  @override
  Widget build(BuildContext context) {
    // listarAgenda();
    // widget.alarmes
    //     .add(AlarmeInfo(medicamento: 'PredSim', hora: '15', minuto: '30'));
    return Scaffold(
      // backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Alarmes'),
        ),
        body: telas[_indexAtual],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indexAtual,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Alarme'),
            BottomNavigationBarItem(
                icon: Icon(Icons.medication), label: 'Medicamento'),
          ],
          onTap: (index){
            setState(() {
              _indexAtual = index;
            });
          },
          selectedItemColor: Colors.red,
        ),
        // endDrawer: MenuLateralWidget(usuario: widget.usuario),

    );
  }
}
