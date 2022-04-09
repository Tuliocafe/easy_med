import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExceptionAutenticacao implements Exception {
  String message;
  ExceptionAutenticacao(this.message);
}


class ServicoAutenticacao extends ChangeNotifier {
  FirebaseAuth _autenticacao = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;
  bool isValid = false;

  ServicoAutenticacao() {
    _verificarAutenticacao();
  }

  _verificarAutenticacao() {
    _autenticacao.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _autenticacao.currentUser;
    // print(_auth.currentUser);
    notifyListeners();
  }

  registrar(String username, email, String password) async {
    try {
      await _autenticacao.createUserWithEmailAndPassword(
          email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ExceptionAutenticacao('A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw ExceptionAutenticacao('Este email já está cadastrado');
      }
    }
  }

  login(String email, String password) async {
    //Para essas execoes podemos colocar somente erro de login e senha invalido.
    try {
      await _autenticacao.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ExceptionAutenticacao('Email não encontrado. Favor Cadastrar.');
      } else if (e.code == 'wrong-password') {
        throw ExceptionAutenticacao('Senha incorreta. Tente novamente.');
      }
    }
  }

  logout() async {
    await _autenticacao.signOut();
    _getUser();
  }
}
