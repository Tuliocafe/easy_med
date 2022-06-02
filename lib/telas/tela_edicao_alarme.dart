import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:easy_med/database/dao/alarme_dao.dart';

import 'package:easy_med/telas/tela_principal.dart';
import 'package:flutter/material.dart';


import '../api/notificacao_api.dart';
import '../database/dao/medicamento_dao.dart';
import '../model/alarme.dart';
import '../model/medicamento.dart';
import '../model/usuario.dart';
import '../widget/modal_cadastro_alarme.dart';

class EditarAlarme extends StatefulWidget {
  Usuario? usuario;
  Alarme? alarme;

  EditarAlarme({Key? key, this.usuario, this.alarme}) : super(key: key);

  @override
  State<EditarAlarme> createState() => _EditarAlarmeState();
}

class _EditarAlarmeState extends State<EditarAlarme> {
  // Usuario? usuario;
  late TextEditingController nomeAlarme;
  // final nomeAlarme = TextEditingController();
  // final horaAlarme = TextEditingController();
  // final minutoAlarme = TextEditingController();
  late  TextEditingController quantidadeAlarme;
  // final quantidadeAlarme = TextEditingController();


  // final usuarioDao daoUsuario = usuarioDao();
  // Medicamento? medicamento;
  // Alarme? alarme;
  // final medicamentoDao daoMedicamento = medicamentoDao();
  final alarmeDao daoAlarme = alarmeDao();
  // int? ultimoalarme;
  // Alarme? ultimoAlarme;

  // const AddTodoButton({Key key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  // String? medicamentoSelecionado;
  // List<Medicamento> listaMedicamento = [];
  // Medicamento? ultimoMedic;

  @override
  void initState() {
    super.initState();
    // atualizarlistaMedicamento();
    // listenNotification();
    initAlarme();
  }

  void initAlarme(){
    final nome = widget.alarme == null ? '' : widget.alarme!.nome;
    final quantidade = widget.alarme == null ? '' : widget.alarme!.quantidade.toString();
    setState(() {
      nomeAlarme = TextEditingController(text: nome);
      quantidadeAlarme = TextEditingController(text: quantidade);
    });
  }


  //
  // void listenNotification() =>
  //     NotificationService.onNotifications.stream.listen(onCliclNotification);
  //
  // void onCliclNotification(String? payload) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => TelaAlarme(),
  //   ));
  // }

  // void atualizarlistaMedicamento() async {
  //   final listaMedicamento = await daoMedicamento.getMedicamentoNome();
  //   setState(() {
  //     this.listaMedicamento = listaMedicamento;
  //   });
  // }




  // Future registraAlarme() async {
  //   try {
  //     await daoAlarme.salvarAlarme(Alarme(
  //       nome: nomeAlarme.text,
  //       idMedicamento: int.parse(medicamentoSelecionado!),
  //       hora: horaAlarme.text,
  //       minuto: minutoAlarme.text,
  //       idUsuario: widget.usuario?.idUsuario,
  //       quantidade: int.parse(quantidadeAlarme.text),
  //     ));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }

  // Future getultimoID() async {
  //   final alarmenow = await daoAlarme.getIdUltimoAlarme();
  //   final ultimoAlarme = await daoAlarme.getultimoAlarmeBD();
  //   setState(() {
  //     this.ultimoAlarme = ultimoAlarme;
  //   });
  //
  //   ultimoalarme = alarmenow;
  // }



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
                          if (widget.alarme?.nome != nomeAlarme.text){
                            await daoAlarme.updateNome(widget.alarme?.idAlarme, nomeAlarme.text);
                          }
                          if (widget.alarme?.quantidade.toString() != quantidadeAlarme.text) {
                            await daoAlarme.updateQuantidade(widget.alarme?.idAlarme, quantidadeAlarme.text);
                          }
                            await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (context) => TelaPrincipal(usuario: widget.usuario)),
                                    (route) => false);
                        },
                        child: const Text('Salvar Alteração'),
                      ),
                      const Divider(
                        height: 124,
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: Size.fromRadius(24),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          try{
                            await daoAlarme.deletarAlarme(widget.alarme?.idAlarme);
                            await AndroidAlarmManager.cancel(widget.alarme!.idAlarme!);
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (context) => TelaPrincipal(usuario: widget.usuario)),
                                    (route) => false);

                          }catch(e){}
                        },
                        child: Text('Excluir Alarme'),
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

  // Widget buildMedicamento() {
  //   return Container(
  //     decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
  //     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
  //     child: Row(
  //       children: <Widget>[
  //         DropdownButton<String>(
  //           hint: const Text(
  //             'Medicamento',
  //             style: TextStyle(color: Colors.grey, fontSize: 16),
  //           ),
  //           value: medicamentoSelecionado,
  //           iconSize: 24,
  //           icon: const Icon(
  //             Icons.keyboard_arrow_down,
  //             color: Colors.grey,
  //           ),
  //           style: const TextStyle(color: Colors.black),
  //           borderRadius: BorderRadius.circular(16),
  //           items: listaMedicamento.map((map) {
  //             return DropdownMenuItem(
  //               child: Text(map.nome.toString()),
  //               value: map.idMedicamento.toString(),
  //             );
  //           }).toList(),
  //           // listaMedicamento.map((String, String medCadastroJson) {
  //           //   return DropdownMenuItem<String, String>(
  //           //     value: id,
  //           //     child: Text(medCadastroJson),
  //           //   );
  //           // }).toList(),
  //           onChanged: (String? idSelecionado) {
  //             setState(() {
  //               medicamentoSelecionado = idSelecionado;
  //             });
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }


}
