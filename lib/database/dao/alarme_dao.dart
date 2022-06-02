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
    alarmeMap['hora'] = alarme.hora;
    alarmeMap['minuto'] = alarme.minuto;
    alarmeMap['quantidade'] = alarme.quantidade;
    return db.insert('alarme', alarmeMap);
  }


  Future<List<Alarme>> getAlarmeUsuario(idusuario) async {
    final Database db = await getDatabase();
    final lista =
        await db.rawQuery('SELECT * FROM alarme WHERE idUsuario = $idusuario');
    return lista.map((json) {
      return Alarme.fromJson(json);
    }).toList();
  }

  deletarAlarme(int? id) async {
    final Database db = await getDatabase();
    db.delete('alarme', where: 'idAlarme = $id');
  }

  getIdUltimoAlarme() async {
    final Database db = await getDatabase();
    final maps = await db.rawQuery('SELECT idAlarme FROM alarme');
    final mapsatualizado = await maps.last.values.toString();
    return int.parse(mapsatualizado[1]);
  }

  Future<Alarme> getultimoAlarmeBD() async {
    final Database db = await getDatabase();
    final lista = await db.rawQuery('SELECT * FROM alarme');
    return Alarme.fromJson(lista.last);
  }

  updateQuantidade(idalarme, quantidade) async {
    final Database db = await getDatabase();
    await db.rawUpdate(
        'UPDATE alarme SET quantidade = $quantidade WHERE idAlarme = $idalarme');
  }

  updateNome(idalarme, nome) async {
    final Database db = await getDatabase();
    await db.rawUpdate(
        'UPDATE alarme SET nome = "$nome" WHERE idAlarme = $idalarme');
  }
}
