// import 'package:easy_med/model/usuario.dart';
// import 'package:flutter/material.dart';
// import '../database/dao/usuario_dao.dart';
//
//
//
// class ServicoCadastro extends ChangeNotifier {
//   final usuarioDao daoUsuario = usuarioDao();
//   Usuario? novousuario;
//   bool isValid = false;
//
//
//   ServicoCadastro() {
//     verificarAuth();
//   }
//
//   getUsuario(usuario) {
//     print(usuario);
//     print('testamos aqui');
//     print(novousuario);
//     notifyListeners();
//   }
//
//   verificarAuth() async{
//     novousuario == await daoUsuario.getUsuarioBD('tuliocafe@yahoo.com.br');
//     notifyListeners();
//   }
// }