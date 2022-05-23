import 'package:easy_med/telas/tela_alarme.dart';
import 'package:flutter/material.dart';

import '../database/dao/alarme_dao.dart';
import '../model/alarme.dart';

class confirmacao extends StatelessWidget {
  final Alarme? alarme;

  confirmacao({Key? key, this.alarme}) : super(key: key);

  final alarmeDao daoAlarme = alarmeDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmacao '),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Alarme:  ${alarme?.nome}',
                    style: const TextStyle(
                      fontSize: 23,
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Já usou o produto ${alarme?.idMedicamento} ?',
                    style: const TextStyle(
                      fontSize: 23,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.all(8),
                      // child: Text('teste'),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(50),
                          primary: Colors.green,
                          // minimumSize: Size.fromHeight(12),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          int? novaquantidade = await (alarme?.quantidade)! - 1;
                          await daoAlarme
                              .updateQuantidade(alarme?.idAlarme, novaquantidade)
                              .then((value) => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => TelaAlarme())));
                        },
                        child: const Text('SIM', style: TextStyle(fontSize: 23)),
                      )),
                  Padding(
                      padding: EdgeInsets.all(8),
                      // child: Text('teste'),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.all(50),
                          // minimumSize: Size.fromHeight(12),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TelaAlarme()));
                        },
                        child: const Text('NAO', style: TextStyle(fontSize: 23)),
                      )),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(50),
                  // child: Text('teste'),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.all(20),
                      // minimumSize: Size.fromHeight(12),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () async {
                      int? novaquantidade = await (alarme?.quantidade)! + 1;
                      await daoAlarme
                          .updateQuantidade(alarme?.idAlarme, novaquantidade)
                          .then((value) => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => TelaAlarme())));
                    },
                    child: const Text('Adicionar quantidade',
                        style: TextStyle(fontSize: 23)),
                  )),
              Padding(
                  padding: EdgeInsets.all(64),
                 
                  // child: Text('teste'),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.all(16),
                      maximumSize: Size.fromRadius(128),
                      // minimumSize: Size.fromHeight(12),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () async {
                      int? novaquantidade = await (alarme?.quantidade)! + 1;
                      await daoAlarme
                          .updateQuantidade(alarme?.idAlarme, novaquantidade)
                          .then((value) => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => TelaAlarme())));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.delete),
                          Text('Excluir alarme', style: TextStyle(fontSize: 23)),

                        ],
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}
