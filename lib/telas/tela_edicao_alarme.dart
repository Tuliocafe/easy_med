import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:easy_med/database/dao/alarme_dao.dart';
import 'package:easy_med/telas/tela_principal.dart';
import 'package:flutter/material.dart';
import '../model/alarme.dart';
import '../model/usuario.dart';


class EditarAlarme extends StatefulWidget {
  Usuario? usuario;
  Alarme? alarme;

  EditarAlarme({Key? key, this.usuario, this.alarme}) : super(key: key);

  @override
  State<EditarAlarme> createState() => _EditarAlarmeState();
}

class _EditarAlarmeState extends State<EditarAlarme> {

  late TextEditingController nomeAlarme;
  late  TextEditingController quantidadeAlarme;



  final alarmeDao daoAlarme = alarmeDao();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initAlarme();
  }

  void initAlarme(){
    final nome = widget.alarme == null ? '' : widget.alarme!.nome;
    final quantidade = widget.alarme == null ? '' : widget.alarme!.quantidade.toString();
    setState(() {
      nomeAlarme = TextEditingController(text: nome);
      quantidadeAlarme = TextEditingController(text: quantidade);
    });
  }





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Material(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nomeAlarme,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome do Alarme'),
                        cursorColor: Colors.white,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      TextFormField(
                        controller: quantidadeAlarme,
                        decoration: const InputDecoration(
                          labelText: 'Quantidade Atual',
                          border: OutlineInputBorder(),
                        ),
                        cursorColor: Colors.white,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: Size.fromHeight(50),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          if (widget.alarme?.nome != nomeAlarme.text){
                            await daoAlarme.updateNome(widget.alarme?.idAlarme, nomeAlarme.text);
                          }
                          if (widget.alarme?.quantidade.toString() != quantidadeAlarme.text) {
                            await daoAlarme.updateQuantidade(widget.alarme?.idAlarme, quantidadeAlarme.text);
                          }
                            await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (context) => TelaPrincipal(usuario: widget.usuario)),
                                    (route) => false);
                        },
                        child: const Text('Salvar Alteração'),
                      ),
                      const Divider(
                        height: 124,
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: Size.fromRadius(24),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          try{
                            await daoAlarme.deletarAlarme(widget.alarme?.idAlarme);
                            await AndroidAlarmManager.cancel(widget.alarme!.idAlarme!);
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (context) => TelaPrincipal(usuario: widget.usuario)),
                                    (route) => false);

                          }catch(e){}
                        },
                        child: Text('Excluir Alarme'),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
