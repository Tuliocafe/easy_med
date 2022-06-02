
import 'package:sqflite/sqflite.dart';
import '../../model/Ocorrencia_Alarme.dart';
import '../app_database.dart';

class ocorrenciaDao{

  Future<int> salvarRelatorio(OcorrenciaAlarme ocorrenciaAlarme) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> relatorioMap = Map();
    relatorioMap['idAlarme'] = ocorrenciaAlarme.idAlarme;
    relatorioMap['dataRegistro'] = ocorrenciaAlarme.dataRegistro;
    relatorioMap['confirmacaoUso'] = ocorrenciaAlarme.confirmacaoUso;
    return db.insert('ocorrenciaAlarme', relatorioMap);
    // });
  }


  Future<List<OcorrenciaAlarme>> getRelatorioMedicamento(idusuario) async{
    final Database db = await getDatabase();
    final lista = await db.rawQuery('SELECT ocorrenciaAlarme.*, medicamento.nome  FROM ocorrenciaAlarme '
        'INNER JOIN alarme ON ocorrenciaAlarme.idAlarme = alarme.idAlarme '
        'INNER JOIN medicamento on alarme.idMedicamento = medicamento.idMedicamento '
        'where alarme.idUsuario = $idusuario');
    return lista.map((json)  => OcorrenciaAlarme.fromJson(json)).toList();
  }
















// Future<List<Alarme>> getAlarmeBD() async {
  //   final Database db = await getDatabase();
  //   final lista = await db.rawQuery('SELECT * FROM alarme');
  //   print(lista);
  //   return lista.map((json) {
  //     return Alarme.fromJson(json);
  //   }).toList();
  // }

//   Future<List<OcorrenciaAlarme>> findAllRelatorio() async {
//   final Database db = await getDatabase();
//   final List<Map<String, dynamic>> resultado = await db.query('usuario');
//   final List<OcorrenciaAlarme> listrelatorio = [];
//   for (Map<String, dynamic> row in resultado) {
//     final OcorrenciaAlarme ocorrenciaAlarme = OcorrenciaAlarme(
//       idOcorrencia: row['idOcorrencia'],
//       idAlarme: row['idAlarme'],
//       dataRegistro: row['dataRegistro'],
//       confirmacaoUso: row['confirmacaoUso'],
//     );
//     listrelatorio.add(ocorrenciaAlarme);
//   }
//   return listrelatorio;
// }



// Future<List<OcorrenciaAlarme>> getRelatorio() async{
//   final Database db = await getDatabase();
//   final lista = await db.rawQuery('SELECT * FROM ocorrenciaAlarme');
//   return lista.map((json)  => OcorrenciaAlarme.fromJson(json)).toList();
// }

// Future<List<OcorrenciaAlarme>> getRelatorioUsuario(idusuario) async{
//   final Database db = await getDatabase();
//   final lista = await db.rawQuery('SELECT ocorrenciaAlarme.* FROM ocorrenciaAlarme '
//       'INNER JOIN alarme ON ocorrenciaAlarme.idAlarme = alarme.idAlarme '
//       'where alarme.idUsuario = $idusuario');
//   return lista.map((json)  => OcorrenciaAlarme.fromJson(json)).toList();
// }


}