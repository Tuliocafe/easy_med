import 'package:easy_med/database/dao/medicamento_dao.dart';
import 'package:easy_med/telas/tela_cadastro_usuario.dart';
import 'package:easy_med/telas/tela_notificacao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../api/notificacao_api.dart';
import '../database/app_database.dart';
import '../database/dao/usuario_dao.dart';
import '../model/medicamento.dart';
import '../model/usuario.dart';
import '../servico/servico_autenticacao.dart';
import '../servico/servico_autenticacao_google.dart';
import '../servico/servico_cadastro.dart';

class telalogin extends StatefulWidget {

  final Usuario? usuario;
  const telalogin({Key? key, this.usuario}) : super(key: key) ;

  @override
  _telaloginState createState() => _telaloginState();
}

class _telaloginState extends State<telalogin> {
  final medicamentoDao daoMedicamento = medicamentoDao();
  final usuarioDao daoUsuario = usuarioDao();
  final formKey = GlobalKey<FormState>();
  Usuario? usuario ;

  final email = TextEditingController();
  final senha = TextEditingController();
  final novoemail = 'tuliocafe@teste.com.br';
  bool loading = false;

Future getUser()async{
  final usuario = await daoUsuario.getUsuarioBD('tuliocafe@teste.com.br');

  setState(() {
    this.usuario = usuario;
  });

}

  // late TextEditingController controllerValidarEmail;
  // late TextEditingController controllerValidarSenha;

  @override
  void initState() {
    super.initState();
    // initUser();
  }

  // void initUser() {
  //   final email = widget.usuario == null ? '': widget.usuario!.email;
  //   final senha = widget.usuario == null ? '': widget.usuario!.senha;
  //
  //
  //   setState(() {
  //     controllerValidarEmail = TextEditingController(text: email);
  //     controllerValidarSenha = TextEditingController(text: senha);
  //
  //   });
  // }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<ServicoAutenticacao>().login(email.text, senha.text);
    } on ExceptionAutenticacao catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }


  @override
  Widget build(BuildContext context) {
    // ServicoCadastro usuario = Provider.of<ServicoCadastro>(context);
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
                Padding(padding: EdgeInsets.all(8),
                   child: Image.asset('lib/imagens/ez_med.png'),),
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
                    onPressed: () async{
                      // print(controllerValidarEmail.text);
                      // print(controllerValidarSenha.text);
                      // List<Usuario> usuario = getUsuario('tuliocafe@teste.com.br');
                      // Future <List<Map>> usuario = getUsuario('tuliocafe@teste.com.br');
                      // getUsuario('tuliocafe@teste.com.br');
                      //  = readAll('tuliocafe@teste.com.br');
                      // print(teste);
                      // getUser();
                      // print(usuario);

                      daoMedicamento.salvarMedicamento(Medicamento(idMedicamento: 0, nome: 'Dorflex', dosagem: '1g', quantidade: 30, laboratorio: 'De nos todos', ));
                      // daoMedicamento.getMedicamento();
                      print('ola');


                      // createDatabase();
                      // alterar();
                      // banco();
                      // print(db.query('usuario'))
                      // findAll().then((usuarios) => print(usuarios.toString()));
                      // validarEmailSenha(controllerValidarEmail.text, controllerValidarSenha.text);
                      // print(listaemail);

                    // daoUsuario.salvarUsuario(Usuario(id: 0, 'maria', 'masculino', 31, 'tuliocafe@yahoo.com.br', '123', 'normal')).then((id) {
                    //     findAll().then((usuarios) => debugPrint(usuarios.toString()));
                      // });
                      // await Navigator.of(context).push(MaterialPageRoute(builder: (context) => notificacao(usuario: usuario)));

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
                      ] : [
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: Size.fromHeight(50),
                      shape: StadiumBorder(),
                    ),

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
                      ] : [
                        const FaIcon(FontAwesomeIcons.google, color: Colors.red,),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Logar com o Google',
                            style: TextStyle(fontSize: 20, color: Colors.grey),

                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      final provider = Provider.of<ServicoAutenticacaoGoogle>(context, listen:false);
                      provider.googleLogin();

                    },

                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),

                  child: GestureDetector(
                    child:
                    Text(
                     'Não tem cadastro ? click aqui!',

                  style: TextStyle(
                    fontSize: 23,
                    // fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  cadastroUsuario())),
                ),
                // TextButton(
                //   onPressed: () => setFormAction(!isLogin),
                //   child: Text(toggleButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
