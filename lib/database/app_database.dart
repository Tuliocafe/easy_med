import 'package:easy_med/model/alarme.dart';
import 'package:easy_med/model/medicamento.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/usuario.dart';



Future<Database> getDatabase() async {
  // final String dbPath = await getDatabasesPath();
  final String path = join(await getDatabasesPath(), 'easymed.db');
  return  await openDatabase(
    path,
    version: 2,
    onCreate: _criarBanco

    //     (db, version) {
    //   db.execute('CREATE TABLE usuario('
    //       'id INTEGER PRIMARY KEY, '
    //       'nome TEXT, '
    //       'idade INTEGER,'
    //       'sexo TEXT, '
    //       'email TEXT, '
    //       'senha TEXT,'
    //       'tipo TEXT)');
    // },
    // onDowngrade: onDatabaseDowngradeDelete
  );
}

Future<void> _criarBanco(Database db, int novaVersao) async {
  List<String> queryes = [
    'CREATE TABLE usuario('
    'id INTEGER PRIMARY KEY,nome TEXT,idade INTEGER,sexo TEXT,email TEXT,senha TEXT,tipo TEXT)',
    'CREATE TABLE medicamento('
    'id INTEGER PRIMARY KEY,nome TEXT,dosagem TEXT,quantidade INTEGER,laboratorio TEXT)',
    'CREATE TABLE alarme ('
        'id INTEGER PRIMARY KEY, nome TEXT, data FLOAT,);',
  ];
  for (String query in queryes) {
    await db.execute(query);
  }
}



Future<int> salvarAgenda(Usuario usuario) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> usuarioMap = Map();
  // usuarioMap['id'] = usuario.id;
  usuarioMap['nome'] = usuario.nome;
  usuarioMap['sexo'] = usuario.sexo;
  usuarioMap['idade'] = usuario.idade;
  usuarioMap['email'] = usuario.email;
  usuarioMap['senha'] = usuario.senha;
  usuarioMap['tipo'] = usuario.tipo;
  return db.insert('usuario', usuarioMap);
  // });
}


Future<List<Alarme>> getAgendaBD() async {
  final Database db = await getDatabase();
  final lista = await db.rawQuery('SELECT * FROM agenda');
  return lista.map((json){return Alarme.fromJson(json);}).toList();
}



Future close() async {
  final Database db = await getDatabase();
  db.close();
}
