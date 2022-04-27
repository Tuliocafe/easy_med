import 'package:easy_med/model/alarme.dart';
import 'package:easy_med/model/medicamento.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/usuario.dart';
import '../app_database.dart';

Future<int> salvarAlarme(Alarme alarme) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> usuarioMap = Map();
  usuarioMap['nome'] = alarme.nome;
  usuarioMap['data'] = alarme.data;

  return db.insert('alarme', usuarioMap);
  // });
}


Future<List<Alarme>> getAlarmeBD() async {
  final Database db = await getDatabase();
  final lista = await db.rawQuery('SELECT * FROM alarme');
  return lista.map((json){return Alarme.fromJson(json);}).toList();
}