

import 'package:easy_med/model/usuario.dart';
import 'package:easy_med/servico/servico_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuLateralWidget extends StatelessWidget {
  Usuario? usuario;
  final padding = EdgeInsets.symmetric(horizontal: 20);

  MenuLateralWidget({Key? key, this.usuario}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // ServicoCadastro usuario = Provider.of<ServicoCadastro>(context);
    return Drawer(
      child: Column(
          children: [
            UserAccountsDrawerHeader(accountName: Text('${usuario?.nome}'), accountEmail: Text('${usuario?.email}')),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              hoverColor: Colors.red,
              onTap: (){

              },
            )
          ],

          //pode colocar cor diferente aqui

        ),
      );

  }
}
