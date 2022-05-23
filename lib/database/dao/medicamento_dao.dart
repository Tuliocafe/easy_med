import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/medicamento.dart';
import '../app_database.dart';


class medicamentoDao{

Future<int> salvarMedicamento(Medicamento medicamento) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> medicamentoMap = Map();
  // usuarioMap['id'] = usuario.id;
  medicamentoMap['nome'] = medicamento.nome;
  medicamentoMap['dosagem'] = medicamento.dosagem;
  medicamentoMap['quantidade'] = medicamento.quantidade;
  medicamentoMap['laboratorio'] = medicamento.laboratorio;
  return db.insert('medicamento', medicamentoMap);
}

Future<List<Medicamento>> getMedicamento() async{
  final Database db = await getDatabase();
  final lista = await db.rawQuery('SELECT * FROM medicamento');
  print(lista);
  return lista.map((json)  => Medicamento.fromJson(json)).toList();
}

Future<List<Medicamento>> getMedicamentoNome() async{
  final Database db = await getDatabase();
  final lista = await db.rawQuery('SELECT idMedicamento, nome FROM medicamento');
  print(lista);
  return lista.map((json)  => Medicamento.fromJson(json)).toList();
}

Future<Medicamento> getMedicamentoId(idmedicamento) async{
  final Database db = await getDatabase();
  final map = await db.rawQuery('SELECT * FROM medicamento WHERE idMedicamento = "$idmedicamento"');
  print(map);
  return Medicamento.fromJson(map.first);

}


}