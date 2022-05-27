import 'package:easy_med/model/usuario.dart';
import 'package:easy_med/telas/tela_edicao_alarme.dart';
import 'package:easy_med/telas/tela_principal.dart';
import 'package:flutter/material.dart';
import '../database/dao/alarme_dao.dart';
import '../model/alarme.dart';
import 'modal_cadastro_alarme.dart';


class confirmacao extends StatelessWidget {
  Alarme? alarme;
  Usuario? usuario;

  confirmacao({Key? key, this.alarme, this.usuario}) : super(key: key);

  final alarmeDao daoAlarme = alarmeDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmacao '),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Alarme:  ${alarme?.nome}',
                    style: const TextStyle(
                      fontSize: 23,
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Já usou o produto ${alarme?.idMedicamento} ?',
                    style: const TextStyle(
                      fontSize: 23,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.all(8),
                      // child: Text('teste'),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(50),
                          primary: Colors.green,
                          // minimumSize: Size.fromHeight(12),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          int? novaquantidade = await (alarme?.quantidade)! - 1;
                          await daoAlarme
                              .updateQuantidade(alarme?.idAlarme, novaquantidade)
                              .then((value) =>  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                              builder: (context) => TelaPrincipal(usuario: usuario)),
                                  (route) => false));
                        },
                        child: const Text('SIM', style: TextStyle(fontSize: 23)),
                      )),
                  Padding(
                      padding: EdgeInsets.all(8),
                      // child: Text('teste'),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.all(50),
                          // minimumSize: Size.fromHeight(12),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          // print(usuario?.nome);
                          Navigator.of(context).pop();
                        },
                        child: const Text('NAO', style: TextStyle(fontSize: 23)),
                      )),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(50),
                  // child: Text('teste'),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.all(20),
                      // minimumSize: Size.fromHeight(12),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () async {

                          Navigator.push(context, ModalAlarme(builder: (context) => EditarAlarme(usuario: usuario, alarme: alarme)));
                          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          // builder: (context) => TelaPrincipal(usuario: usuario)),
                          //     (route) => false));
                    },
                    child: const Text('Editar Alarme',
                        style: TextStyle(fontSize: 23)),
                  )),
              // Padding(
              //     padding: EdgeInsets.all(64),
              //
              //     // child: Text('teste'),
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         primary: Colors.red,
              //         padding: const EdgeInsets.all(16),
              //         maximumSize: Size.fromRadius(128),
              //         // minimumSize: Size.fromHeight(12),
              //         shape: StadiumBorder(),
              //       ),
              //       onPressed: () async {
              //         await daoAlarme.deletarAlarme(alarme?.idAlarme);
              //         Navigator.of(context).pop();
              //       },
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //           children: const [
              //             Icon(Icons.delete),
              //             Text('Excluir alarme', style: TextStyle(fontSize: 23)),
              //
              //           ],
              //     ))),
            ],
          ),
        ),
      ),
    );
  }
}
