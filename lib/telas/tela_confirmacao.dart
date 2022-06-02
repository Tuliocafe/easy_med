import 'package:easy_med/database/dao/medicamento_dao.dart';
import 'package:easy_med/model/usuario.dart';
import 'package:easy_med/telas/tela_edicao_alarme.dart';
import 'package:easy_med/telas/tela_principal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/dao/alarme_dao.dart';
import '../database/dao/correncia_alarme.dart';
import '../model/alarme.dart';
import '../model/Ocorrencia_Alarme.dart';
import '../widget/modal_cadastro_alarme.dart';


class confirmacao extends StatelessWidget {
  Alarme? alarme;
  Usuario? usuario;
  String? nomeMedicamento;

  confirmacao({Key? key, this.alarme, this.usuario, this.nomeMedicamento}) : super(key: key);

  final alarmeDao daoAlarme = alarmeDao();
  final medicamentoDao daoMedicamento = medicamentoDao();
  final ocorrenciaDao daoRelatorio = ocorrenciaDao();
  bool botaoativo = true;




  salvarRegistro(confirmacao)async{
    await daoRelatorio.salvarRelatorio(OcorrenciaAlarme(
      idAlarme: alarme?.idAlarme,
      dataRegistro: await dataFormatada(),
      confirmacaoUso: confirmacao
    ));
  }

  dataFormatada()async{
    final DateTime dataatual = await DateTime.now();
    final DateFormat dataformatada =  DateFormat('d-M-y hh:mm');

    final String formatted =  dataformatada.format(dataatual);
    return formatted.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (alarme?.quantidade == 0){
      botaoativo = false;
    }

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
                child: Text('Já usou o produto ${nomeMedicamento} ?',
                    style: const TextStyle(
                      fontSize: 23,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(50),
                          primary: Colors.green,
                          shape: StadiumBorder(),
                        ),

                        onPressed: botaoativo ? () async {
                          int? novaquantidade = await (alarme?.quantidade)! - 1;
                          await salvarRegistro('sim');
                          await daoAlarme
                              .updateQuantidade(alarme?.idAlarme, novaquantidade)
                              .then((value) =>  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                              builder: (context) => TelaPrincipal(usuario: usuario)),
                                  (route) => false));
                        } :

                        null,

                        child: const Text('SIM', style: TextStyle(fontSize: 23)),
                      )),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.all(50),
                          shape: StadiumBorder(),
                        ),
                        onPressed: botaoativo ? () async {
                          await salvarRegistro('nao');
                          Navigator.of(context).pop();
                        } : null,
                        child: const Text('NAO', style: TextStyle(fontSize: 23)),
                      )),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.all(20),
                      // minimumSize: Size.fromHeight(12),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () async {
                          Navigator.push(context, ModalAlarme(builder: (context) => EditarAlarme(usuario: usuario, alarme: alarme)));
                    },
                    child: const Text('Editar Alarme',
                        style: TextStyle(fontSize: 23)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
