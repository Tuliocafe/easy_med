import 'package:easy_med/database/app_database.dart';
import 'package:easy_med/database/dao/usuario_dao.dart';
import 'package:easy_med/model/usuario.dart';
import 'package:easy_med/telas/tela_alarme.dart';
import 'package:easy_med/telas/tela_confirmacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../servico/servico_autenticacao.dart';

class cadastroUsuario extends StatefulWidget {
  // final String? payload;

  @override
  _cadastroUsuarioState createState() => _cadastroUsuarioState();
}

class _cadastroUsuarioState extends State<cadastroUsuario> {
  Usuario? usuario;
  final usuarioDao daoUsuario = usuarioDao();
  final formKey = GlobalKey<FormState>();
  List<String> listasexo = ['Masculino', 'Faminino', 'Não Informado'];
  List<Usuario> listaemail = [];
  String? sexoSelecionado;
  bool loading = false;
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final confirmacaosenha = TextEditingController();
  final idade = TextEditingController();

  Future getUser(email) async {
    final usuario = await daoUsuario.getUsuarioBD(email);

    setState(() {
      this.usuario = usuario;
    });
  }

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
    try {
      await context
          .read<ServicoAutenticacao>()
          .registrar(nome.text, email.text, senha.text);
      await daoUsuario.salvarUsuario(Usuario(
          // idUsuario: 0,
          nome: nome.text,
          sexo: sexoSelecionado,
          idade: int.parse(idade.text),
          email: email.text,
          senha: senha.text,
          tipo: 'email'));
    } on ExceptionAutenticacao catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
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
                    width: 8,
                  ),
                  Row(children: [
                    buildSexo(),
                  ]),
                  const SizedBox(
                    height: 16,
                  ),
                  buildIdade(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildEmail(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildSenha(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildConfirmacaoSenha(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildConfirmar(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildTestar(),
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

  Widget buildEmail() => TextFormField(
        controller: email,
        decoration: const InputDecoration(
          labelText: 'E-mail',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite o seu e-mail' : null,
      );

  Widget buildSenha() => TextFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: senha,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Senha',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite sua senha' : null,
      );

  Widget buildConfirmacaoSenha() => TextFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: confirmacaosenha,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Confirmar Senha',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite sua senha' : null,
      );

  Widget buildIdade() => TextFormField(
        keyboardType: TextInputType.number,
        controller: idade,
        decoration: const InputDecoration(
          labelText: 'Idade',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite sua Idade' : null,
      );

  Widget buildConfirmar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        minimumSize: Size.fromHeight(50),
        shape: StadiumBorder(),
      ),
      onPressed: () async {
        if (senha.text == confirmacaosenha.text) {
          try {
            registrar().then((value) => getUser(email.text)
                .then((value) => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TelaAlarme(
                          usuario: usuario,
                        )))));
            // ainda preciso validar o tipo
          } catch (e) {}
        } else {
          final snackBar = SnackBar(
              content:
                  const Text('Senha não confere. Favor digitar novamente.'),
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
          // findAll().then((usuarios) => print(usuarios));
          // ainda preciso validar o tipo
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

  Widget buildSexo() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
      child: Row(
        children: <Widget>[
          DropdownButton<String>(
            hint: const Text(
              'Genero',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            value: sexoSelecionado,
            iconSize: 36,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            style: const TextStyle(color: Colors.black),
            borderRadius: BorderRadius.circular(16),
            items: listasexo.map((String userCadastroJson) {
              return DropdownMenuItem<String>(
                value: userCadastroJson,
                child: Text(userCadastroJson),
              );
            }).toList(),
            onChanged: (String? idSelecionado) {
              setState(() {
                sexoSelecionado = idSelecionado;
              });
            },
          )
        ],
      ),
    );
  }
}
