import 'package:easy_med/telas/novo_alarme.dart';
import 'package:easy_med/telas/tela_notificacao.dart';
import 'package:flutter/material.dart';

import 'modal_cadastro_alarme.dart';

class telaalarme extends StatefulWidget {
  // const alarme({Key? key}) : super(key: key);

  final List<AlarmeInfo> alarmes = [
  ];

  @override
  _alarmeState createState() => _alarmeState();
}

class _alarmeState extends State<telaalarme> {
  final List<AlarmeInfo> alarmes = [];
  final List<Item> _data = [
    Item(id: 1, header: 'Painel1', body: 'item2'),
    Item(id: 2, header: 'teste1', body: 'teste2')
  ];

  @override
  Widget build(BuildContext context) {
    widget.alarmes
        .add(AlarmeInfo(medicamento: 'Viagra', hora: '15', minuto: '30'));
    widget.alarmes
        .add(AlarmeInfo(medicamento: 'PredSim', hora: '15', minuto: '30'));
    widget.alarmes
        .add(AlarmeInfo(medicamento: 'Remedio2', hora: '15', minuto: '30'));
    // widget.alarmes
    //     .add(AlarmeInfo(medicamento: 'PredSim', hora: '15', minuto: '30'));
    return Scaffold(
      // backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Alarmes'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => notificacao()));
            Navigator.of(context).push(
                ModalAlarme(builder: (context) => NovoAlarme()));
          },
          label: const Text('Adicionar'),
          icon: const Icon(Icons.add),
          backgroundColor: (Colors.red),
        ),
        body: Center(
            child: Material(
                color: Colors.green,
                elevation: 2,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    // margin: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.white,
                            Colors.red,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                        child: ExpansionPanelList.radio(
                            children: _data.map<ExpansionPanelRadio>((
                                Item item) {
                              return ExpansionPanelRadio(
                                  value: item.id,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
// Text('Alarme', style: TextStyle(fontFamily: 'avenir')),
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 16),
                                      child: ListTile(
                                        title: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 32, vertical: 16),
                                            child: Text(item.header!)),

                                      ),
                                    );
                                  },
                                  body: ListTile(
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
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
                                                    'teste',
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
                                                      fontWeight: FontWeight
                                                          .w700),
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
                                      subtitle: const Text(
                                          'To delete this panel, tap the trash can icon'),
                                      trailing: const Icon(Icons.delete),
                                      onTap: () {
                                        // setState(() {
                                        //   _data.removeWhere((Item currentItem) =>
                                        //   item == currentItem);
                                      }
                                  )
                              );
                            }

                            ).toList()
                        )
                    )
                )
            )
        )
    );
  }

}

class Item {
  final int id;
  final String? header;
  final String? body;

  Item({required this.id,this.body, this.header});
}

class AlarmeInfo {
  String? medicamento;
  String? hora;
  String? minuto;

  AlarmeInfo({this.medicamento, this.hora, this.minuto});
}


//
// children: _data.map<ExpansionPanelRadio>((Item item) {
// return ExpansionPanelRadio(
// value: item.id,
// headerBuilder:
// (BuildContext context, bool isExpanded) {
// // Text('Alarme', style: TextStyle(fontFamily: 'avenir')),
// return Container(
// padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
// child: ListTile(
// title: Container(
// padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
// child: Text(item.header!)),
//
// ),
// );
// },
// body: ListTile(
// title: Text(item.body!),
// subtitle: const Text(
// 'To delete this panel, tap the trash can icon'),
// trailing: const Icon(Icons.delete),
// onTap: () {
// setState(() {
// _data.removeWhere((Item currentItem) =>
// item == currentItem);
// });
// }));
// }
// ).toList(),
// )