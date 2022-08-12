import 'package:easy_med/database/dao/alarme_dao.dart';
import 'package:easy_med/model/alarme.dart';
import 'package:easy_med/model/medicamento.dart';
import 'package:easy_med/telas/novo_alarme.dart';
import 'package:easy_med/telas/tela_confirmacao.dart';
import 'package:flutter/material.dart';
import '../database/dao/medicamento_dao.dart';
import '../model/usuario.dart';
import '../widget/modal_cadastro_alarme.dart';


class TelaAlarme extends StatefulWidget {
  Usuario? usuario;
  Medicamento? medicamento;
  Alarme? alarme;
  final int? id;


  TelaAlarme({Key? key, this.usuario,this.medicamento, this.alarme, this.id,}) : super(key: key);

  @override
  _TelaAlarmeState createState() => _TelaAlarmeState();
}

class _TelaAlarmeState extends State<TelaAlarme> {
  Alarme? alarme;
  Medicamento? medicamento;
  final medicamentoDao daoMedicamento = medicamentoDao();
  final alarmeDao daoAlarme = alarmeDao();

  String? email;
  List<Alarme> alarmes = [];
  List<Medicamento> listMedicamentos = [];
  String? dosagem;
  List<Map> alarmenovo = [];


  @override
  initState(){
    super.initState();
    listaMedicamento();
    listarAgendaUsuario(widget.usuario?.idUsuario);
  }


  Future listarAgendaUsuario(usuario) async{
    final alarme = await daoAlarme.getAlarmeUsuario(usuario);
    setState(() {
      this.alarmes = alarme;
    });
  }

  Future recarregarAgenda() async{
    final alarme = await daoAlarme.getAlarmeUsuario(widget.usuario?.idUsuario);
    setState(() {
      this.alarmes = alarme;
    });
  }

  Future listaMedicamento() async{
    final medicamentos = await daoMedicamento.getMedicamento();
    setState(() {
      listMedicamentos = medicamentos;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          padding: const EdgeInsets.only(left: 32, top: 0, right: 0, bottom: 0),
          child: InkWell(
          child: FloatingActionButton.extended(
            heroTag: 'botaoAdd',
            onPressed: () {
              Navigator.push(context, ModalAlarme(builder: (context) => NovoAlarme(usuario: widget.usuario)));
            },
            label: const Text('Adicionar'),
            icon: const Icon(Icons.add),
            backgroundColor: (Colors.red),
          ),
            ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: recarregarAgenda,
                    child: ListView.builder(
                        itemCount: alarmes.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              margin: const EdgeInsets.only(bottom: 32),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
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
                                    Navigator.push(context, ModalAlarme(builder: (context) => confirmacao(
                                      usuario: widget.usuario,
                                      alarme: alarmes[index],
                                      nomeMedicamento: listMedicamentos[alarmes[index].idMedicamento! -1].nome.toString(),)));
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
                                            // Icon(Icons.add_box_outlined),
                                            SizedBox(width: 8),
                                            Text(
                                              '${listMedicamentos[alarmes[index].idMedicamento! -1].nome}',
                                               // 'teste',
                                              style: TextStyle(),
                                            ),
                                          ],
                                        ),
                                        Text('${listMedicamentos[alarmes[index].idMedicamento! -1].dosagem}'),
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
                                            '${alarmes[index].hora}:${alarmes[index].minuto}',
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'Faltam ${alarmes[index].quantidade} itens',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
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
