import 'package:easy_med/servico/servico_cadastro.dart';
import 'package:easy_med/telas/tela_login.dart';
import 'package:easy_med/telas/tela_principal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificarAuthWidget extends StatefulWidget {
  const VerificarAuthWidget({Key? key}) : super(key: key);

  @override
  _VerificarAuthWidgetState createState() => _VerificarAuthWidgetState();
}

class _VerificarAuthWidgetState extends State<VerificarAuthWidget> {
  @override
  Widget build(BuildContext context) {
    ServicoCadastro auth = Provider.of<ServicoCadastro>(context);


    if (auth.novousuario == null) {
      return telalogin();
    } else {
      // return CreateSheetsPage();
      return TelaPrincipal();
    }
  }
}
