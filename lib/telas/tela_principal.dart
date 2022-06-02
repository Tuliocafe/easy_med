import 'package:easy_med/database/dao/alarme_dao.dart';
import 'package:easy_med/model/alarme.dart';
import 'package:easy_med/model/medicamento.dart';
import 'package:easy_med/telas/tela_alarme.dart';
import 'package:easy_med/telas/tela_cadastro_medicamento.dart';
import 'package:flutter/material.dart';
import '../database/dao/medicamento_dao.dart';
import '../model/usuario.dart';
import '../widget/menu_lateral_widget.dart';


class TelaPrincipal extends StatefulWidget {
  final Usuario? usuario;
  final Medicamento? medicamento;
  final Alarme? alarme;


  TelaPrincipal({Key? key, this.usuario,this.medicamento, this.alarme}) : super(key: key);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  Alarme? alarme;
  Usuario? usuario;
  Medicamento? medicamento;
  final medicamentoDao daoMedicamento = medicamentoDao();
  final alarmeDao daoAlarme = alarmeDao();
  final nomeTela = ['Alarmes', 'Cadastro Medicamento'];
  int _indexAtual = 0;

  @override
  initState(){
    super.initState();

  }

  late final telas = [
    TelaAlarme(usuario: widget.usuario),
    cadastroMedicameto(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nomeTela[_indexAtual]),
      ),
      body: telas[_indexAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexAtual,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.alarm), label: 'Alarme'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medication), label: 'Medicamento'),
        ],
        onTap: (index){
          setState(() {
            _indexAtual = index;
          });
        },
        selectedItemColor: Colors.red,
      ),
      endDrawer: MenuLateralWidget(
          usuario: widget.usuario
      ),
    );
  }
}
