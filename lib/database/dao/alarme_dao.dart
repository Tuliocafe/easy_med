import 'package:easy_med/model/alarme.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

class alarmeDao {
  Future<int> salvarAlarme(Alarme alarme) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> alarmeMap = Map();
    alarmeMap['nome'] = alarme.nome;
    alarmeMap['idMedicamento'] = alarme.idMedicamento;
    alarmeMap['idUsuario'] = alarme.idUsuario;
    alarmeMap['data'] = alarme.data;
    return db.insert('alarme', alarmeMap);
    // });
  }

  Future<List<Alarme>> getAlarmeBD() async {
    final Database db = await getDatabase();
    final lista = await db.rawQuery('SELECT * FROM alarme');
    print(lista);
    return lista.map((json) {
      return Alarme.fromJson(json);
    }).toList();
  }
}
