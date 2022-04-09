import 'package:easy_med/servico/servico_autenticacao_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class teste extends StatelessWidget {
  const teste({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Parabens'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Usuario', style: TextStyle(fontSize: 24),),
            SizedBox(height: 32),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.photoURL!),
          ),
            SizedBox(height: 8,),
            Text('Name: ' + user.displayName!,style: TextStyle(fontSize: 16)),
            SizedBox(height: 8,),
            Text('E-mail: ' + user.email!,style: TextStyle(fontSize: 16)),
            ElevatedButton(onPressed: () async{
              final provider = Provider.of<ServicoAutenticacaoGoogle>(context, listen:false);
              provider.logout();
            }, child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
