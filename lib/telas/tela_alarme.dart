import 'package:easy_med/telas/tela_notificacao.dart';
import 'package:flutter/material.dart';

import 'botao_add.dart';
import 'modal_cadastro_alarme.dart';

class alarme extends StatefulWidget {
  // const alarme({Key? key}) : super(key: key);

  final List<AlarmeInfo> alarmes = [

  ];

  @override
  _alarmeState createState() => _alarmeState();
}

class _alarmeState extends State<alarme> {
  final List<AlarmeInfo> alarmes = [];

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
          onPressed: (){
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => notificacao()));
            Navigator.of(context).push(ModalAlarme(builder:(context) => AddTodoButton()));
          },
          label: const Text('Adicionar'),
          icon: const Icon(Icons.add),
          backgroundColor: (Colors.red),

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
                      itemCount: widget.alarmes.length,
                      itemBuilder: (context, index) {
                        // children: alarmes.map((alarme){
                        return ListTile(
                          title: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2
                              ),

                              borderRadius: BorderRadius.all(Radius.circular(32)),
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
                                          '${widget.alarmes[index].medicamento}',
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












// import 'package:easy_med/telas/tela_notificacao.dart';
// import 'package:flutter/material.dart';
//
// import 'botao_add.dart';
// import 'modal_cadastro_alarme.dart';
//
// class alarme extends StatefulWidget {
//   // const alarme({Key? key}) : super(key: key);
//
//   final List<AlarmeInfo> alarmes = [
//
//   ];
//
//   @override
//   _alarmeState createState() => _alarmeState();
// }
//
// class _alarmeState extends State<alarme> {
//   final List<AlarmeInfo> alarmes = [];
//   final List<Item> _data = [
//     Item(id: 1, headerValue:'Painel1', expandedValue: 'item2'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     widget.alarmes
//         .add(AlarmeInfo(medicamento: 'Viagra', hora: '15', minuto: '30'));
//     widget.alarmes
//         .add(AlarmeInfo(medicamento: 'PredSim', hora: '15', minuto: '30'));
//     widget.alarmes
//         .add(AlarmeInfo(medicamento: 'Remedio2', hora: '15', minuto: '30'));
//     // widget.alarmes
//     //     .add(AlarmeInfo(medicamento: 'PredSim', hora: '15', minuto: '30'));
//     return Scaffold(
//
//         // backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: const Text('Alarmes'),
//         ),
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: (){
//             // Navigator.of(context).push(MaterialPageRoute(builder: (context) => notificacao()));
//             Navigator.of(context).push(ModalAlarme(builder:(context) => AddTodoButton()));
//           },
//           label: const Text('Adicionar'),
//           icon: const Icon(Icons.add),
//           backgroundColor: (Colors.red),
//
//         ),
//
//
//         body: Center(
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               // mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Text('Alarme', style: TextStyle(fontFamily: 'avenir')),
//                 Expanded(
//                   child: ListView.builder(
//                       itemCount: widget.alarmes.length,
//                       itemBuilder: (context, index) {
//                         // children: alarmes.map((alarme){
//                         return ListTile(
//                           title: Container(
//                             padding:
//                                 EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                             margin: const EdgeInsets.only(bottom: 32),
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   colors: [
//                                     Colors.red,
//                                     Colors.white,
//                                     Colors.red,
//                                   ],
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight),
//                               border: Border.all(
//                                 color: Colors.black,
//                                 width: 2
//                               ),
//
//                               borderRadius: BorderRadius.all(Radius.circular(32)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.4),
//                                   blurRadius: 8,
//                                   spreadRadius: 2,
//                                   offset: Offset(4, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Icon(Icons.add_box_outlined),
//                                         SizedBox(width: 8),
//                                         Text(
//                                           '${widget.alarmes[index].medicamento}',
//                                           style: TextStyle(),
//                                         ),
//                                       ],
//                                     ),
//                                     Text('50g'),
//                                     Icon(
//                                       Icons.keyboard_arrow_down,
//                                       size: 32,
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         '9' + ':' + '30',
//                                         style: TextStyle(
//                                             fontSize: 32,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                       Text(
//                                         'Faltam 3 comprimidos',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ]),
//                                 Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Periodo: Todos os dias',
//                                         style: TextStyle(),
//                                       ),
//                                     ])
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//
// ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
//
//
//
// class AlarmeInfo {
//   String? medicamento;
//   String? hora;
//   String? minuto;
//
//   AlarmeInfo({this.medicamento, this.hora, this.minuto});
// }
//
// class editaralarme extends StatelessWidget {
//   /// {@macro add_todo_button}
//   // const AddTodoButton({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(32.0),
//       child: GestureDetector(
//         onTap: () {
//           // Navigator.of(context).push(ModalAlarme(builder: (context) {
//           //   return _AddTodoPopupCard();
//           // }
//         },
//         child: Hero(
//             tag: 'teste',
//           child: Center(
//             child: Material(
//               color: Colors.green,
//               elevation: 2,
//               shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               child: Container(
//                 padding:
//                 EdgeInsets.symmetric(horizontal: 16, vertical: 32),
//                 // margin: const EdgeInsets.only(bottom: 32),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       colors: [
//                         Colors.red,
//                         Colors.white,
//                         Colors.red,
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight),
//                   borderRadius: BorderRadius.all(Radius.circular(32)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.red.withOpacity(0.4),
//                       blurRadius: 8,
//                       spreadRadius: 2,
//                       offset: Offset(4, 4),
//                     ),
//                   ],
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(Icons.add_box_outlined),
//                               SizedBox(width: 8),
//                               Text(
//                                 'teste',
//                                 style: TextStyle(),
//                               ),
//                             ],
//                           ),
//                           Text('50g'),
//                           Icon(
//                             Icons.keyboard_arrow_down,
//                             size: 32,
//                           ),
//                         ],
//                       ),
//                       Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               '9' + ':' + '30',
//                               style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                             Text(
//                               'Faltam 3 comprimidos',
//                               style: TextStyle(
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ]),
//                       Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Periodo: Todos os dias',
//                               style: TextStyle(),
//                             ),
//                           ])
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Item {
//   Item({
//     required this.id,
//     required this.expandedValue,
//     required this.headerValue,
//   });
//
//   int id;
//   String expandedValue;
//   String headerValue;
// }