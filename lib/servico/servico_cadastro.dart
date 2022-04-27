import 'package:easy_med/model/usuario.dart';
import 'package:easy_med/servico/servico_autenticacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../database/app_database.dart';
import '../database/dao/usuario_dao.dart';

class ServicoCadastro extends ChangeNotifier{
  final usuarioDao daoUsuario = usuarioDao();
  late final Future<Usuario?> usuario;


  ServicoCadastro() {
    getUsuario();
  }

  getUsuario(){

    // ServicoAutenticacao auth = Provider.of<ServicoAutenticacao>(context);
     usuario = daoUsuario.getUsuarioBD('tuliocafe@teste.com.br');
     print('testamos aqui');
    print(this.usuario);
  notifyListeners();
  }



}