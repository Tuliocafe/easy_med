import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final versao = 1;
  final String path = join(await getDatabasesPath(), 'easymed.db');
  return await openDatabase(
    path,
    version: versao,
    onCreate: (db, version) async {
      await db.execute(sqlUsuario);
      await db.execute(sqlMedicamento);
      await db.execute(sqlAlarme);
      await db.execute(sqlRelatorio);
    },
  );
}

_onConfigure(Database db) async {
  await db.execute('PRAGMA foreign_keys = ON');
}

const sqlUsuario = 'CREATE TABLE usuario('
    'idUsuario INTEGER PRIMARY KEY,nome TEXT,idade INTEGER,genero TEXT,email TEXT,senha TEXT)';

const sqlMedicamento = 'CREATE TABLE medicamento('
    'idMedicamento INTEGER PRIMARY KEY,'
    'nome TEXT,'
    'dosagem TEXT,'
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

const sqlRelatorio = 'CREATE TABLE ocorrenciaAlarme ('
    'idOcorrencia INTEGER PRIMARY KEY,'
    'idAlarme INTEGER,'
    'dataRegistro TEXT,'
    'confirmacaoUso TEXT,'
    'FOREIGN KEY(idAlarme) REFERENCES alarme(idAlarme))';

void apagabanco() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'easymed.db');
  await deleteDatabase(path);
}

Future close() async {
  final Database db = await getDatabase();
  db.close();
}
