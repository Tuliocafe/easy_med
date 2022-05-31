import 'package:easy_med/model/usuario.dart';
import 'package:easy_med/servico/servico_cadastro.dart';
import 'package:easy_med/telas/tela_relatorio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../telas/tela_alarme.dart';
import '../telas/tela_login.dart';
import '../telas/tela_notificacao.dart';

class MenuLateralWidget extends StatelessWidget {
  Usuario? usuario;
  // final padding = EdgeInsets.symmetric(horizontal: 20);


  MenuLateralWidget({this.usuario,Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('${usuario?.nome}'),
              accountEmail: Text('${usuario?.email}')),
          itemMenuLateral(
              text: 'Menu Especial',
              icon: Icons.vpn_key,
              onClicked: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => notificacao(usuario: usuario,)));
              }),
          itemMenuLateral(
              text: 'Relatorio',
              icon: Icons.description,
              onClicked: () {


                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TelaRelatorio(
                          usuario: usuario,
                        )));
              }),
          itemMenuLateral(
              text: 'Sair',
              icon: Icons.logout,
              onClicked: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => telalogin()));
                // Navigator.popUntil(ModalRoute.withName('/telalogin'), (route) => false);
              }),
        ],

        // leading: Icon(Icons.logout),
        // title: Text('Sair'),
        // hoverColor: Colors.red,
        // onTap: (){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => telalogin()));
      ));


    //pode colocar cor diferente aqui
  }

  Widget itemMenuLateral(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final cor = Colors.black;
    return ListTile(
      leading: Icon(
        icon,
        color: cor,
      ),
      title: Text(text, style: TextStyle(color: cor)),
      onTap: onClicked,
    );
  }
}
