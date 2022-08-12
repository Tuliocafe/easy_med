import 'package:easy_med/database/dao/medicamento_dao.dart';
import 'package:flutter/material.dart';
import '../model/medicamento.dart';


class cadastroMedicameto extends StatefulWidget {


  @override
  _cadastroUsuarioState createState() => _cadastroUsuarioState();
}

class _cadastroUsuarioState extends State<cadastroMedicameto> {
  final medicamentoDao daoMedicamento = medicamentoDao();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  final nome = TextEditingController();
  final dosagem = TextEditingController();
  final laboratorio = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  Future registrar() async {
    setState(() => loading = true);
      await daoMedicamento.salvarMedicamento(Medicamento(
        nome: nome.text,
        dosagem: dosagem.text,
        laboratorio: laboratorio.text,
      ));
      nome.clear();
      dosagem.clear();
      laboratorio.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView(
              padding: EdgeInsets.all(32),
              children: [
            Form(
                key: formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  buildNome(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildDosagem(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildLaboratorio(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildSalvar(),
                  const SizedBox(
                    height: 16,
                  ),
                ])),
          ])),
    );
  }

  Widget buildNome() => TextFormField(
        controller: nome,
        decoration: const InputDecoration(
          labelText: 'Nome',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite o seu nome' : null,
      );

  Widget buildDosagem() => TextFormField(
        controller: dosagem,
        decoration: const InputDecoration(
          labelText: 'Dosagem  ex: 50mg',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite o seu e-mail' : null,
      );

  Widget buildLaboratorio() => TextFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: laboratorio,
        decoration: const InputDecoration(
          labelText: 'laboratorio',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite sua senha' : null,
      );

  Widget buildSalvar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        minimumSize: Size.fromHeight(50),
        shape: StadiumBorder(),
      ),
      onPressed: () async {
        try {
          final Cadastrado = SnackBar(
              content: Text('Medicamento cadastrado com sucesso.'),
              action: SnackBarAction(
                label: 'Recolher',
                onPressed: () {},
              ));
          registrar().then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(Cadastrado)
              );
        } catch (e) {
          final snackBar = SnackBar(
              content: Text('Erro ${e}.'),
              action: SnackBarAction(
                label: 'Recolher',
                onPressed: () {},
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const Text('Salvar'),
    );
  }
}
