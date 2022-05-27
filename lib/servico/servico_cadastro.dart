import 'package:easy_med/model/usuario.dart';
import 'package:easy_med/servico/servico_autenticacao.dart';
import 'package:easy_med/telas/tela_principal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../database/app_database.dart';
import '../database/dao/usuario_dao.dart';



class ServicoCadastro extends ChangeNotifier {
  final usuarioDao daoUsuario = usuarioDao();
  Usuario? novousuario;
  bool isValid = false;


  ServicoCadastro() {
    verificarAuth();
  }

  getUsuario(usuario) {
    print(usuario);
    print('testamos aqui');
    print(novousuario);
    notifyListeners();
  }

  verificarAuth() async{
    novousuario == await daoUsuario.getUsuarioBD('tuliocafe@yahoo.com.br');
    notifyListeners();
  }






}