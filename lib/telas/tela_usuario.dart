import 'package:easy_med/telas/tela_login.dart';
import 'package:easy_med/telas/tela_notificacao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../teste.dart';

class TelaUsuario extends StatelessWidget {
  const TelaUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData){
            return teste();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something Went Wrong!'));
          } else {
            return telalogin();
          }
        },
      ),
    );
  }
}
