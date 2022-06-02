import 'package:easy_med/database/dao/medicamento_dao.dart';
import 'package:easy_med/database/dao/correncia_alarme.dart';
import 'package:easy_med/model/medicamento.dart';
import 'package:easy_med/model/Ocorrencia_Alarme.dart';
import 'package:easy_med/model/usuario.dart';
import 'package:flutter/material.dart';


class TelaRelatorio extends StatefulWidget {
  Usuario? usuario;
  TelaRelatorio({this.usuario});

  @override
  State<TelaRelatorio> createState() => _TelaRelatorioState();
  }

class _TelaRelatorioState extends State<TelaRelatorio> {
  List<OcorrenciaAlarme> listrelatorio = [];
  final ocorrenciaDao daoRelatorio = ocorrenciaDao();
  final medicamentoDao daoMedicamento = medicamentoDao();
  List<Medicamento> listaMedicamentos = [];


  @override
  void initState() {
    super.initState();
    getListRelatorio();
  }


  Future getListRelatorio() async {
    final lista = await daoRelatorio.getRelatorioMedicamento(widget.usuario?.idUsuario);

    setState(() {
      this.listrelatorio = lista;
    });
  }


  Future listaMedicamento() async{
    final medicamentos = await daoMedicamento.getMedicamento();
    setState(() {
      listaMedicamentos = medicamentos;
    });
  }


  iconeConfirmacao(confirmacao){
    if(confirmacao == 'sim'){
      return const CircleAvatar( backgroundColor: Colors.green,child: Icon(Icons.check),);
    }
    if (confirmacao == 'nao') {
      return CircleAvatar(child: Icon(Icons.close),);
    }
    else return CircleAvatar(child: Icon(Icons.stream),);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatorio Uso'),
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
              itemCount: listrelatorio.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: iconeConfirmacao(listrelatorio[index].confirmacaoUso.toString()),
                  title: Text('${listrelatorio[index].nome}'),
                  subtitle: Text('${listrelatorio[index].confirmacaoUso}'),
                  trailing: Text('${listrelatorio[index].dataRegistro}'),
                );
              }),
        )
      ]),
    );
  }
}
