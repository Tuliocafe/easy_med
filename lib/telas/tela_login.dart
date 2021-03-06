import 'package:easy_med/database/dao/medicamento_dao.dart';
import 'package:easy_med/telas/tela_cadastro_usuario.dart';
import 'package:easy_med/telas/tela_principal.dart';
import 'package:flutter/material.dart';
import '../database/dao/alarme_dao.dart';
import '../database/dao/usuario_dao.dart';
import '../model/usuario.dart';

class telalogin extends StatefulWidget {
  final Usuario? usuario;

  const telalogin({Key? key, this.usuario}) : super(key: key);

  @override
  _telaloginState createState() => _telaloginState();
}

class _telaloginState extends State<telalogin> {
  Usuario? usuario;

  final medicamentoDao daoMedicamento = medicamentoDao();
  final usuarioDao daoUsuario = usuarioDao();
  final alarmeDao daoAlarme = alarmeDao();
  final formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final senha = TextEditingController();
  bool loading = false;
  bool valido = false;

  void initState() {
    super.initState();
  }

  Future getUser(emailvalidador) async {
    final usuario = await daoUsuario.getUsuarioBD(emailvalidador);

    setState(() {
      this.usuario = usuario;
    });
  }

  validar(email, senha) async {
    if (await daoUsuario.validarEmailSenha(email, senha) == true) {
      return true;
    } else {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem Vindo'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset('lib/imagens/ez_med.png'),
                ),
                // const Text(
                //   'Seja bem vindo !!',
                //   style: TextStyle(
                //     fontSize: 30,
                //     fontWeight: FontWeight.bold,
                //     letterSpacing: -1.5,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'E-mail invalido. Favor digitar e-mail valido.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                  child: TextFormField(
                    controller: senha,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite sua senha.';
                      } else if (value.length < 6) {
                        return 'Senha deve ter mais de 6 digitos.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      minimumSize: Size.fromHeight(50),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () async {

                      // daoUsuario.getAllUsuario();

                      final form = formKey.currentState!;
                      final isValid = form.validate();
                      if (isValid) {
                        // if (email.text == '1') {
                        //   await getUser('tuliocafe@yahoo.com.br').then((value) =>
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) =>
                        //           TelaPrincipal(usuario: usuario)))
                        //   );
                        // } else {
                        valido = await validar(email.text, senha.text);
                        // try {
                        if (valido == true) {
                          // if (valido == true) {
                          //   getUser(email.text).then((value) =>
                          // print('Certo'));
                          await getUser(email.text);
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  TelaPrincipal(usuario: usuario)));
                        } else {
                          final snackBar = SnackBar(
                              content: Text('Email ou senha invalido.'),
                              action: SnackBarAction(
                                label: 'Recolher',
                                onPressed: () {},
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (loading)
                          ? [
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ]
                          : [
                              const Icon(Icons.check),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),

                // Implementacao futura: logar com google, funcionalidade aguardando ajuste no banco de dados.
                //
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.white,
                //       minimumSize: Size.fromHeight(50),
                //       shape: StadiumBorder(),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: (loading)
                //           ? [
                //               const Padding(
                //                 padding: EdgeInsets.all(16),
                //                 child: SizedBox(
                //                   width: 24,
                //                   height: 24,
                //                   child: CircularProgressIndicator(
                //                     color: Colors.white,
                //                   ),
                //                 ),
                //               )
                //             ]
                //           : [
                //               const FaIcon(
                //                 FontAwesomeIcons.google,
                //                 color: Colors.red,
                //               ),
                //               const Padding(
                //                 padding: EdgeInsets.all(16.0),
                //                 child: Text(
                //                   'Logar com o Google',
                //                   style: TextStyle(
                //                       fontSize: 20, color: Colors.grey),
                //                 ),
                //               ),
                //             ],
                //     ),
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => notificacao(usuario: usuario,)));
                //       // final provider = Provider.of<ServicoAutenticacaoGoogle>(
                //       //     context,
                //       //     listen: false);
                //       // provider.googleLogin();
                //     },
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: GestureDetector(
                    child: Row(
                      children: const [
                        Text(
                          'N??o tem cadastro ?  ',
                          style: TextStyle(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            letterSpacing: -1.5,
                          ),
                        ),
                        Text(
                          ' Click Aqui!!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            // fontWeight: FontWeight.bold,
                            // letterSpacing: -1.5,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => cadastroUsuario())),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
