
import 'package:sqflite/sqflite.dart';

import '../../model/relatorio.dart';
import '../app_database.dart';

class relatorioDao{

  Future<int> salvarRelatorio(Relatorio relatorio) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> relatorioMap = Map();
    relatorioMap['idAlarme'] = relatorio.idAlarme;
    relatorioMap['dataRegistro'] = relatorio.dataRegistro;
    relatorioMap['confirmacaoUso'] = relatorio.confirmacaoUso;
    return db.insert('relatorio', relatorioMap);
    // });
  }

  Future<List<Relatorio>> findAllRelatorio() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> resultado = await db.query('usuario');
  final List<Relatorio> listrelatorio = [];
  for (Map<String, dynamic> row in resultado) {
    final Relatorio relatorio = Relatorio(
      idRelatorio: row['idRelatorio'],
      idAlarme: row['idAlarme'],
      dataRegistro: row['dataRegistro'],
      confirmacaoUso: row['confirmacaoUso'],
    );
    listrelatorio.add(relatorio);
  }
  print(listrelatorio);
  return listrelatorio;
}



  Future<List<Relatorio>> getRelatorio() async{
    final Database db = await getDatabase();
    final lista = await db.rawQuery('SELECT * FROM relatorio');
    return lista.map((json)  => Relatorio.fromJson(json)).toList();
  }

  Future<List<Relatorio>> getRelatorioUsuario(idusuario) async{
    final Database db = await getDatabase();
    final lista = await db.rawQuery('SELECT relatorio.* FROM relatorio '
        'INNER JOIN alarme ON relatorio.idAlarme = alarme.idAlarme '
        // 'INNER JOIN usuario on alarme.idUsuario = usuario.idUsuario '
        'where alarme.idUsuario = $idusuario');
    return lista.map((json)  => Relatorio.fromJson(json)).toList();
  }

  Future<List<Relatorio>> getRelatorioMedicamento(idusuario) async{
    final Database db = await getDatabase();
    final lista = await db.rawQuery('SELECT relatorio.*, medicamento.nome  FROM relatorio '
        'INNER JOIN alarme ON relatorio.idAlarme = alarme.idAlarme '
        'INNER JOIN medicamento on alarme.idMedicamento = medicamento.idMedicamento '
        'where alarme.idUsuario = $idusuario');
    // print(lista);
    return lista.map((json)  => Relatorio.fromJson(json)).toList();
  }



// Future<List<Alarme>> getAlarmeBD() async {
  //   final Database db = await getDatabase();
  //   final lista = await db.rawQuery('SELECT * FROM alarme');
  //   print(lista);
  //   return lista.map((json) {
  //     return Alarme.fromJson(json);
  //   }).toList();
  // }

}