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

}