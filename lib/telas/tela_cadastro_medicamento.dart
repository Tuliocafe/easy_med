import 'package:easy_med/database/dao/medicamento_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/medicamento.dart';
import '../servico/servico_autenticacao.dart';

class cadastroMedicameto extends StatefulWidget {
  // final String? payload;

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

  // late TextEditingController controllerNome;
  // late TextEditingController controllerEmail;
  // late TextEditingController controllerSenha;
  // late TextEditingController controllerIdade;

  // final controllerNome = TextEditingController();
  // final controllerEmail = TextEditingController();
  // final controllerSenha = TextEditingController();
  // final controlleridade = TextEditingController();

  @override
  void initState() {
    super.initState();
    // initUser();
  }

  // void initUser() {
  //   final nome = widget.usuario == null ? '': widget.usuario!.nome;
  //   final email = widget.usuario == null ? '': widget.usuario!.email;
  //   final senha = widget.usuario == null ? '': widget.usuario!.senha;
  //   final idade = widget.usuario == null ? '': widget.usuario!.idade;
  //
  //
  //
  //   setState(() {
  //     controllerNome = TextEditingController(text: nome);
  //     controllerEmail = TextEditingController(text: email);
  //     controllerSenha = TextEditingController(text: senha);
  //     controllerIdade = TextEditingController(text: idade.toString());
  //   });
  // }

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
              // shrinkWrap: true,
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
        // if (laboratorio.text == confirmacaosenha.text) {
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

  Widget buildTestar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        minimumSize: Size.fromHeight(50),
        shape: StadiumBorder(),
      ),
      onPressed: () async {
        try {
        } catch (e) {
          final snackBar = SnackBar(
            content: const Text(
                'Erro, Tente mais tarde ou entre em contato com Administração.'),
            action: SnackBarAction(
              label: 'Recolher',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const Text('Localizar'),
    );
  }

// Widget buildSexo() {
//   return Container(
//     decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
//     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
//     child: Row(
//       children: <Widget>[
//         DropdownButton<String>(
//           hint: const Text(
//             'Genero',
//             style: TextStyle(color: Colors.grey, fontSize: 18),
//           ),
//           value: sexoSelecionado,
//           iconSize: 36,
//           icon: const Icon(
//             Icons.keyboard_arrow_down,
//             color: Colors.grey,
//           ),
//           style: const TextStyle(color: Colors.black),
//           borderRadius: BorderRadius.circular(16),
//           items: listasexo.map((String userCadastroJson) {
//             return DropdownMenuItem<String>(
//               value: userCadastroJson,
//               child: Text(userCadastroJson),
//             );
//           }).toList(),
//           onChanged: (String? idSelecionado) {
//             setState(() {
//               sexoSelecionado = idSelecionado;
//             });
//           },
//         )
//       ],
//     ),
//   );
// }
}
