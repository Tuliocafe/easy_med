import 'package:easy_med/telas/novo_alarme.dart';
import 'package:easy_med/telas/tela_notificacao.dart';
import 'package:flutter/material.dart';

import '../model/usuario.dart';
import '../widget/menu_lateral_widget.dart';
import 'modal_cadastro_alarme.dart';

class alarme extends StatefulWidget {
  final Usuario? usuario;

  // alarme({Key? key}) : super(key: key);

  // final List<AlarmeInfo> alarmes = [
  //
  // ];

  alarme({Key? key, this.usuario}) : super(key: key);

  @override
  _alarmeState createState() => _alarmeState();
}

class _alarmeState extends State<alarme> {
  String? email;
  int contador = 0;
  final List<AlarmeInfo> alarmes = [];

  @override
  Widget build(BuildContext context) {
    email = widget.usuario?.email;

    // widget.alarmes
    //     .add(AlarmeInfo(medicamento: 'PredSim', hora: '15', minuto: '30'));
    return Scaffold(

        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Alarmes'),
        ),
        endDrawer: MenuLateralWidget(usuario: widget.usuario),
        floatingActionButton: InkWell(
          onLongPress: () {
            print(contador);
            if (alarmes.isEmpty) {
              contador = 0;
            } else {
              alarmes.removeLast();
              setState(() {
                contador--;
              });
            }
          },
          child: FloatingActionButton.extended(
            onPressed: () {

              print(contador);
              if (contador == 0) {
                alarmes.add(AlarmeInfo(
                    medicamento: 'Dipirona', hora: '15', minuto: '30'));
              }
              if (contador == 2) {
                alarmes.add(AlarmeInfo(
                    medicamento: 'Loratadina', hora: '9', minuto: '15'));

              }
              if (contador == 3) {
                alarmes.add(AlarmeInfo(
                    medicamento: 'Meloxicam', hora: '20', minuto: '30'));
              }
              setState(() {
                if (contador > 3){}
                else contador++;
              });

              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => notificacao()));
              // Navigator.of(context).push(ModalAlarme(builder:(context) => NovoAlarme()));
            },
            label: const Text('Adicionar'),
            icon: const Icon(Icons.add),
            backgroundColor: (Colors.red),
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('Alarme', style: TextStyle(fontFamily: 'avenir')),
                Expanded(
                  child: ListView.builder(
                      itemCount: alarmes.length,
                      itemBuilder: (context, index) {
                        // children: alarmes.map((alarme){
                        return ListTile(
                          title: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
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
                                          '${alarmes[index].medicamento}',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                    Text('50g'),
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
                                        '9' + ':' + '30',
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Faltam 3 comprimidos',
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
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}

class AlarmeInfo {
  String? medicamento;
  String? hora;
  String? minuto;

  AlarmeInfo({this.medicamento, this.hora, this.minuto});
}
