import 'package:easy_med/database/dao/usuario_dao.dart';
import 'package:easy_med/model/usuario.dart';
import 'package:easy_med/telas/tela_principal.dart';
import 'package:flutter/material.dart';

class cadastroUsuario extends StatefulWidget {
  @override
  _cadastroUsuarioState createState() => _cadastroUsuarioState();
}

class _cadastroUsuarioState extends State<cadastroUsuario> {
  Usuario? usuario;
  final usuarioDao daoUsuario = usuarioDao();
  final formKey = GlobalKey<FormState>();
  List<String> listasexo = ['Masculino', 'Feminino', 'Não Informado'];
  List<Usuario> listaemail = [];
  String? sexoSelecionado;
  bool loading = false;
  bool valido = false;
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


  @override
  void initState() {
    super.initState();
  }


  Future registrar() async {
    setState(() => loading = true);
    try {
      // await context
      // .read<ServicoAutenticacao>()
      // .registrar(nome.text, email.text, senha.text);
      await daoUsuario.salvarUsuario(Usuario(
        nome: nome.text,
        genero: sexoSelecionado,
        idade: int.parse(idade.text),
        email: email.text,
        senha: senha.text,
      ));
    } catch (e) {
      setState(() => loading = false);
      final snackBar = SnackBar(
        content: const Text('Cadastro invalido.'),
        action: SnackBarAction(
          label: 'Recolher',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              padding: EdgeInsets.all(32),
              children: [
            Form(
                key: formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  buildNome(),
                  const SizedBox(
                    height: 16,
                    width: 8,
                  ),
                  buildGenero(),
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
      validator: (valor) {
        if (valor!.isEmpty) {
          return 'Digite sua senha!';
        } else if (valor.length < 6) {
          return 'Senha precisa ser maior que 6 digitos';
        }
        return null;
      });

  Widget buildConfirmacaoSenha() => TextFormField(
      keyboardType: TextInputType.visiblePassword,
      controller: confirmacaosenha,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Confirmar Senha',
        border: OutlineInputBorder(),
      ),
      validator: (valor) {
        if (valor!.isEmpty) {
          return 'Digite sua senha!';
        } else if (valor.length < 6) {
          return 'Senha precisa ser maior que 6 digitos';
        } else if (valor != senha.text){
          return 'Senha nao confere.';
        }
        return null;
      });

  Widget buildIdade() => TextFormField(
      keyboardType: TextInputType.number,
      controller: idade,
      decoration: const InputDecoration(
        labelText: 'Idade',
        border: OutlineInputBorder(),
      ),
      validator: (valor) {
        if (valor!.isEmpty) {
          return 'Digite sua idade !';
        } else if (int.parse(valor) <= 17) {
          return 'Usuario precisa ser maior de 18 anos.';
        }
        return null;
      });

  Widget buildConfirmar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        minimumSize: Size.fromHeight(50),
        shape: StadiumBorder(),
      ),
      onPressed: () async {
        final form = formKey.currentState!;
        final isValid = form.validate();
        try {
          await getUser(email.text);
          final snackBar = SnackBar(
              content: const Text(
                  'Email ja cadastrado. Favor digitar outro !'),
              action: SnackBarAction(
                label: 'Recolher',
                onPressed: () {},
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }  catch (e) {
          if (isValid) {
            try {
                registrar().then((value) => getUser(email.text).then((value) =>
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TelaPrincipal(usuario: usuario)))));
            } catch (e) {
              final snackBar = SnackBar(
                  content: Text('$e'),
                  action: SnackBarAction(
                    label: 'Recolher',
                    onPressed: () {},
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        }
      },
      child: const Text('Salvar'),
    );
  }

  // Widget buildTestar() {
  //   return ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       primary: Colors.red,
  //       minimumSize: Size.fromHeight(50),
  //       shape: StadiumBorder(),
  //     ),
  //     onPressed: () async {
  //       try {
  //         apagabanco();
  //         // findAll().then((usuarios) => print(usuarios));
  //         // ainda preciso validar o tipo
  //       } catch (e) {
  //         final snackBar = SnackBar(
  //           content: const Text(
  //               'Erro, Tente mais tarde ou entre em contato com Administração.'),
  //           action: SnackBarAction(
  //             label: 'Recolher',
  //             onPressed: () {},
  //           ),
  //         );
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       }
  //     },
  //     child: const Text('Localizar'),
  //   );
  // }

  Widget buildGenero() {
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
