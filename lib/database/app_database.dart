import 'package:easy_med/model/alarme.dart';
import 'package:easy_med/model/medicamento.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/usuario.dart';

Future<Database> getDatabase() async {
  final versao = 1;
  // final String dbPath = await getDatabasesPath();
  final String path = join(await getDatabasesPath(), 'easymed.db');
  return await openDatabase(
    path,
    version: versao,
    onCreate:
        // _criarBanco
        (db, version) async {
      await db.execute(sqlUsuario);
      await db.execute(sqlMedicamento);
      await db.execute(sqlAlarme);

    },
      // onConfigure: _onConfigure
    // onDowngrade: onDatabaseDowngradeDelete
  );
}

  _onConfigure(Database db) async {
await db.execute('PRAGMA foreign_keys = ON');
}

const sqlUsuario = 'CREATE TABLE usuario('
    'idUsuario INTEGER PRIMARY KEY,nome TEXT,idade INTEGER,sexo TEXT,email TEXT,senha TEXT,tipo TEXT)';

const sqlMedicamento = 'CREATE TABLE medicamento('
    'idMedicamento INTEGER PRIMARY KEY,'
    'nome TEXT,'
    'dosagem TEXT,'
    'quantidade INTEGER,'
    'laboratorio TEXT)';

const sqlAlarme = 'CREATE TABLE alarme ('
    'idAlarme	INTEGER PRIMARY KEY,'
    'nome TEXT,'
    'hora	TEXT,'
    'minuto TEXT,'
    'idUsuario	INTEGER,'
    'idMedicamento	INTEGER,'
    'quantidade INTEGER,'
    'FOREIGN KEY(idUsuario) REFERENCES usuario(idUsuario)'
    'FOREIGN KEY(idMedicamento) REFERENCES Medicamento(idMedicamento))';



void apagabanco() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'easymed.db');
  await deleteDatabase(path);
  print(path);
}

// Future close() async {
//   final Database db = await getDatabase();
//   db.close();
// }
