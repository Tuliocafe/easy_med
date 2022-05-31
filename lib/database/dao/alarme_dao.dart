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

  Future<List<Alarme>> getAlarmeUsuario(idusuario) async {
    final Database db = await getDatabase();
    final lista =
        await db.rawQuery('SELECT * FROM alarme WHERE idUsuario = $idusuario');
    print(lista);
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
    await db
        .rawUpdate('UPDATE alarme SET nome = "$nome" WHERE idAlarme = $idalarme');
    // return Alarme.fromJson(lista);
  }

  //inner join que nao consegui fazer
  Future<List<Map>> selectAgenda() async {
    final Database db = await getDatabase();
    final lista = await db.rawQuery('SELECT alarme.idAlarme, alarme.idUsuario, '
        'alarme.nome, alarme.hora, alarme.minuto, medicamento.nome, medicamento.dosagem'
        ' FROM alarme INNER JOIN medicamento ON alarme.idMedicamento = medicamento.idMedicamento');

    print(lista);
    return lista;
  }
}
//
// final maps = await db.rawQuery('SELECT Agenda.idAgenda, Agenda.idUsuario, Agenda.Quantidade, Agenda.hora, Agenda.minuto, Medicamento.Nome,'
// ' Medicamento.dosagem, FROM Agenda INNER JOIN Medicamento, ON Agenda.idMedicamento = Medicamento.idMedicamento');
