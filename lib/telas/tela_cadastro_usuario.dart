import 'package:flutter/material.dart';

class cadastroUsuario extends StatefulWidget {
  // final String? payload;

  const cadastroUsuario({Key? key, }) : super(key: key);

  @override
  _cadastroUsuarioState createState() => _cadastroUsuarioState();
}

class _cadastroUsuarioState extends State<cadastroUsuario> {
  final formKey = GlobalKey<FormState>();

  // String controllerNome = 'Tulio';
  // String controllerEmail = 'Tulio';
  // String controllerSenha = 'Tulio';

  final controllerNome = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerSenha = TextEditingController();

  //

  // @override
  // void initState() {
  //   super.initState();
  //
  //   initUser();
  // }
  //
  //
  // void initUser() {
  //   final nome = '';
  //   final email = '';
  //   final senha = '';
  //
  //
  //   setState(() {
  //     controllerNome = TextEditingController(text: nome);
  //     controllerEmail = TextEditingController(text: email);
  //     controllerSenha = TextEditingController(text: senha);
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Cadastro'),
        centerTitle: true,
      ),
        body: Center( child:ListView(
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
                    buildEmail(),
                    const SizedBox(
                      height: 16,
                    ),
                    buildSenha(),
                    const SizedBox(
                      height: 16,
                    ),
                    buildConfirmar(),
                    const SizedBox(
                      height: 16,
                    ),
                  ])),
            ]
        )

        ),
    );
  }

  Widget buildNome() => TextFormField(
        controller: controllerNome,
        decoration: InputDecoration(
          labelText: 'Nome',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite o seu nome' : null,
      );

  Widget buildEmail() => TextFormField(
        controller: controllerEmail,
        decoration: InputDecoration(
          labelText: 'E-mail',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite o seu e-mail' : null,
      );

  Widget buildSenha() => TextFormField(
        controller: controllerSenha,
        decoration: InputDecoration(
          labelText: 'Senha',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite sua senha' : null,
      );

Widget buildConfirmar() {
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
    }, child: const Text('Salvar'
  ),
  );
}

}
