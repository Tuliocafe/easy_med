import 'package:easy_med/database/dao/alarme_dao.dart';
import 'package:easy_med/database/dao/usuario_dao.dart';
import 'package:easy_med/model/alarme.dart';
import 'package:easy_med/model/medicamento.dart';
import 'package:easy_med/telas/novo_alarme.dart';
import 'package:easy_med/telas/tela_cadastro_medicamento.dart';
import 'package:easy_med/telas/tela_confirmacao.dart';
import 'package:easy_med/telas/tela_notificacao.dart';
import 'package:flutter/material.dart';

import '../database/dao/medicamento_dao.dart';
import '../model/usuario.dart';
import '../widget/menu_lateral_widget.dart';
import 'modal_cadastro_alarme.dart';


class TelaAlarme extends StatefulWidget {
  final Usuario? usuario;
  final Medicamento? medicamento;
  final Alarme? alarme;

  // alarme({Key? key}) : super(key: key);

  // final List<AlarmeInfo> alarmes = [
  //
  // ];

  TelaAlarme({Key? key, this.usuario,this.medicamento, this.alarme}) : super(key: key);

  @override
  _TelaAlarmeState createState() => _TelaAlarmeState();
}

class _TelaAlarmeState extends State<TelaAlarme> {
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

  final tabs = [
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
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('Alarme', style: TextStyle(fontFamily: 'avenir')),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: listarAgenda,
                    child: ListView.builder(
                        itemCount: alarmes.length,
                        itemBuilder: (context, index) {
                          // children: alarmes.map((alarme){
                          return ListTile(
                            title: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              margin: const EdgeInsets.only(bottom: 32),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.red,
                                      Colors.white,
                                      Colors.red,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
                                border: Border.all(color: Colors.black, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, ModalAlarme(builder: (context) => confirmacao(alarme: alarmes[index],)));
                                    print(alarmes[index].idAlarme);
                                  },
                                onLongPress: () {
                                    setState(() {
                                      // cancel = await AndroidAlarmManager.cancel(idAlarme!);
                                      daoAlarme.deletarAlarme(alarmes[index].idAlarme!);
                                      listarAgenda();
                                    });

                                },

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [

                                        Row(
                                          children: [
                                            Icon(Icons.add_box_outlined),
                                            SizedBox(width: 8),
                                            Text(
                                              '${alarmes[index].idMedicamento}',
                                              style: TextStyle(),
                                            ),
                                          ],
                                        ),
                                        Text('teste'),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 32,
                                        ),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${alarmes[index].hora}' + ':' + '${alarmes[index].minuto}',
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'Faltam ' + '${alarmes[index].quantidade} ' +  'itens',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Periodo: Todos os dias',
                                            style: TextStyle(),
                                          ),
                                        ])
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
