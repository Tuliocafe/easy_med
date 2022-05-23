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
  Medicamento? medicamento;
  final medicamentoDao daoMedicamento = medicamentoDao();
  final alarmeDao daoAlarme = alarmeDao();

  String? email;
  int contador = 0;
  List<Alarme> alarmes = [];
  String? dosagem;
  List<Map> alarmenovo = [];

  // Future getMedicamento() async {
  //   final medicamento = await daoMedicamento.getMedicamento();
  //
  //   setState(() {
  //     this.medicamento = medicamento;
  //   });
  // }
  @override
  initState(){
    super.initState();
    listarAgenda();
    listarAgenda2();

  }

  Future listarAgenda() async{
    final alarme = await daoAlarme.getAlarmeBD();
    setState(() {
      this.alarmes = alarme;
    });
    return Future.delayed(Duration(seconds: 0));
  }

  Future listarAgenda2() async{
    final alarme2 = await daoAlarme.selectAgenda();
    setState(() {
      alarmenovo = alarme2;
    });
    return Future.delayed(Duration(seconds: 0));
  }

  int _indexAtual = 0;

  final telas = [
    TelaAlarme(),
    cadastroMedicameto(),
  ];

  @override
  Widget build(BuildContext context) {
    email = widget.usuario?.email;
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
                icon: Icon(Icons.medication), label: 'Medicamento'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'So teste mesmo'),


          ],
          onTap: (index){
            setState(() {
              _indexAtual = index;
            });
          },
          selectedItemColor: Colors.red,
        ),
        endDrawer: MenuLateralWidget(usuario: widget.usuario),
        floatingActionButton: Container(
          padding: const EdgeInsets.only(left: 32, top: 0, right: 0, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onLongPress: () {

                },
                child: FloatingActionButton.extended(
                  onPressed: () {

                    daoAlarme.selectAgenda();
                    print(alarmenovo);

                    // Navigator.push(context, ModalAlarme(builder: (context) => NovoAlarme(usuario: widget.usuario)));

                  },
                  label: const Text('Editar    '),
                  icon: const Icon(Icons.create_rounded),
                  backgroundColor: (Colors.red),
                ),
              ),
              InkWell(
                onLongPress: () {

                },
                child: FloatingActionButton.extended(
                  onPressed: () {

                    Navigator.push(context, ModalAlarme(builder: (context) => NovoAlarme(usuario: widget.usuario)));

                    // Navigator.of(context).push(ModalAlarme(builder:(context) => NovoAlarme(usuario: widget.usuario))).then((value) => setState((){}));
                    // Navigator.of(context).pushNamed("/novoAlarme").
                  },
                  label: const Text('Adicionar'),
                  icon: const Icon(Icons.add),
                  backgroundColor: (Colors.red),
                ),
              ),
            ], ),
        ),
    );
  }
}
