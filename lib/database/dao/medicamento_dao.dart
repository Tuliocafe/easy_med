import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/medicamento.dart';
import '../app_database.dart';



Future<int> salvarUsuario(Medicamento medicamento) async {
  final Database db = await getDatabase();
  // return createDatabase().then((db) {
  final Map<String, dynamic> medicamentoMap = Map();
  // usuarioMap['id'] = usuario.id;
  medicamentoMap['nome'] = medicamento.nome;
  medicamentoMap['sexo'] = medicamento.dosagem;
  medicamentoMap['idade'] = medicamento.quantidade;
  medicamentoMap['email'] = medicamento.laboratorio;
  return db.insert('medicamento', medicamentoMap);
  // });
}

Future<List<Medicamento>> getMedicamento() async{
  final Database db = await getDatabase();
  final lista = await db.rawQuery('SELECT * FROM agenda');
  return lista.map((json)  => Medicamento.fromJson(json)).toList();
}