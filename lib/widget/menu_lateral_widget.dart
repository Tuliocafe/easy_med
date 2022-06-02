import 'package:easy_med/model/usuario.dart';
import 'package:easy_med/telas/tela_relatorio.dart';
import 'package:flutter/material.dart';
import '../servico/notificacao.dart';
import '../telas/tela_login.dart';

class MenuLateralWidget extends StatelessWidget {
  Usuario? usuario;
  bool Visualizar = false;

  MenuLateralWidget({
    this.usuario,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (usuario?.email == 'admin@admin.com.br'){
      Visualizar = true;
    }
    return Drawer(
        child: Column(
      children: [
        UserAccountsDrawerHeader(
            accountName: Text('${usuario?.nome}'),
            accountEmail: Text('${usuario?.email}')),
        itemMenuLateral(
            apresentar: Visualizar,
            text: 'Menu Especial',
            icon: Icons.vpn_key,
            onClicked: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => notificacao(
                        usuario: usuario,
                      )));
            }),
        itemMenuLateral(
            apresentar: true,
            text: 'Relatorio',
            icon: Icons.description,
            onClicked: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TelaRelatorio(
                        usuario: usuario,
                      )));
            }),
        itemMenuLateral(
          apresentar: true,
            text: 'Sair',
            icon: Icons.logout,
            onClicked: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) => telalogin()),
                      (route) => false);
            }),
      ],

    ));

  }

  Widget itemMenuLateral(
      {required String text, required IconData icon, VoidCallback? onClicked, apresentar}) {
    final cor = Colors.black;
    return Visibility(
        visible: apresentar,
        child: ListTile(
          selected: false,
          leading: Icon(
            icon,
            color: cor,
          ),
          title: Text(text, style: TextStyle(color: cor)),
          onTap: onClicked,
        ));
  }
}
