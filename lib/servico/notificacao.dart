import 'package:easy_med/database/dao/correncia_alarme.dart';
import 'package:easy_med/database/dao/usuario_dao.dart';
import 'package:easy_med/telas/tela_cadastro_usuario.dart';
import 'package:flutter/material.dart';
import '../api/notificacao_api.dart';
import '../database/app_database.dart';
import '../database/dao/alarme_dao.dart';
import '../database/dao/medicamento_dao.dart';
import '../model/alarme.dart';
import '../model/medicamento.dart';
import '../model/usuario.dart';
import '../widget/menu_lateral_widget.dart';

class notificacao extends StatefulWidget {
  final Usuario? usuario;


  const notificacao({Key? key, this.usuario}) : super(key: key);

  @override
  _notificacaoState createState() => _notificacaoState();
}

class _notificacaoState extends State<notificacao> {
  Medicamento? medicamento;
  Alarme? alarme;
  String? email;
  int? ultimoalarme;
  Alarme? ultimoAlarme;
  final medicamentoDao daoMedicamento = medicamentoDao();
  final alarmeDao daoAlarme = alarmeDao();
  final usuarioDao daoUsuario = usuarioDao();
  final ocorrenciaDao daoRelatorio = ocorrenciaDao();
  List<Medicamento> listaMedicamento = [];


  void atualizarlistaMedicamento() async {
    final listaMedicamento = await daoMedicamento.getMedicamentoNome();
    setState(() {
      this.listaMedicamento = listaMedicamento;
    });
  }

  Future getMedicamento() async {
    final medicamento =
        await daoMedicamento.getMedicamentoId(ultimoAlarme?.idMedicamento);
    setState(() {
      this.medicamento = medicamento;
    });
  }

  @override
  void initState() {
    super.initState();
    listenNotification();
  }

  void listenNotification() =>
      NotificationService.onNotifications.stream.listen(onCliclNotification);

  void onCliclNotification(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => cadastroUsuario(),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro Especial'),
        centerTitle: true,
      ),
      endDrawer: MenuLateralWidget(usuario: widget.usuario),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  apagabanco();
                },
                child: Text('Apaga Banco'),
              )),
          Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  daoMedicamento.salvarMedicamento(Medicamento(
                      nome: 'Dorflex',
                      dosagem: '1g',
                      laboratorio: 'De nos todos'));
                  daoMedicamento.salvarMedicamento(Medicamento(
                      nome: 'Dipirona',
                      dosagem: '1g',
                      laboratorio: 'Neo Quimica'));
                  daoMedicamento.salvarMedicamento(Medicamento(
                      nome: 'Loratadina',
                      dosagem: '10mg',
                      laboratorio: 'Prati Donaduzzi'));
                  daoMedicamento.salvarMedicamento(Medicamento(
                      nome: 'Meloxicam',
                      dosagem: '15mg',
                      laboratorio: 'Medquimica'));
                  daoMedicamento.salvarMedicamento(Medicamento(
                      nome: 'Albendazol',
                      dosagem: '400mg',
                      laboratorio: 'Prati Donaduzzi'));

                  // daoUsuario.salvarUsuario(Usuario(
                  //     nome: 'Usuario Teste',
                  //     genero: 'masculino',
                  //     idade: 20,
                  //     email: 'contato@easymed.com.br',
                  //     senha: '123456',
                  //     )
                  // );
                },
                child: Text('Cadastrar Medicamentos e Usuario Padrao'),
              )),
          Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {


                   // var relatoio = daoRelatorio.findAllRelatorio();
                   // print(relatoio);

                },
                child: Text('Botao de teste'),
              )),


        ]),
      ),
    );
  }
}


notifica() async {
  final ultimoAlarme = await alarmeDao().getultimoAlarmeBD();
  final medicamento =  await medicamentoDao().getMedicamentoId(ultimoAlarme.idMedicamento);

  final notifica = NotificationService();
  await notifica.init();
  await notifica.showNotifications(
      ultimoAlarme.idAlarme!, medicamento.nome, medicamento.dosagem);
}
