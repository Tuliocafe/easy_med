import 'package:easy_med/model/alarme.dart';
import 'package:easy_med/model/medicamento.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/usuario.dart';



Future<Database> getDatabase() async {
  final versao = 4;
  // final String dbPath = await getDatabasesPath();
  final String path = join(await getDatabasesPath(), 'easymed.db');
  return  await openDatabase(
    path,
    version: versao,
    onCreate:
    // _criarBanco
        (db, version) async{
      await db.execute(sqlUsuario);
      await db.execute(sqlMedicamento);
    },
    // onDowngrade: onDatabaseDowngradeDelete
  );
}


final sqlUsuario = 'CREATE TABLE usuario('
    'id INTEGER PRIMARY KEY, '
    'nome TEXT, '
    'idade INTEGER,'
    'sexo TEXT, '
    'email TEXT, '
    'senha TEXT,'
    'tipo TEXT),';


final sqlMedicamento = 'CREATE TABLE medicamento('
    'idMedicamento INTEGER PRIMARY KEY,'
    'nome TEXT,'
    'dosagem TEXT,'
    'quantidade INTEGER,'
    'laboratorio TEXT)';


Future<void> _criarBanco(Database db, int novaVersao) async {
  List<String> queryes = [
    'CREATE TABLE usuario('
    'id INTEGER PRIMARY KEY,nome TEXT,idade INTEGER,sexo TEXT,email TEXT,senha TEXT,tipo TEXT)',
    'CREATE TABLE medicamento('
    'idMedicamento INTEGER PRIMARY KEY,nome TEXT,dosagem TEXT,quantidade INTEGER,laboratorio TEXT);',

    // 'CREATE TABLE alarme ('
    //     'idAlarme INTEGER PRIMARY KEY, nome TEXT, data FLOAT, FOREIGN KEY);',
  ];
  for (String query in queryes) {
    await db.execute(query);
  }
}



Future close() async {
  final Database db = await getDatabase();
  db.close();
}
