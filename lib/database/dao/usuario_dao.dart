

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/usuario.dart';
import '../app_database.dart';

class usuarioDao {


Future<int> salvarUsuario(Usuario usuario) async {
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
}

// Future<List<Usuario>> findAll() async {
//   final Database db = await getDatabase();
//   final List<Map<String, dynamic>> resultado = await db.query('usuario');
//   final List<Usuario> usuarios = [];
//   for (Map<String, dynamic> row in resultado) {
//     final Usuario usuario = Usuario(
//       print(row);
//       // row['id'],
//       // row['nome'],
//       // row['sexo'],
//       // row['idade'],
//       // row['email'],
//       // row['senha'],
//       // row['tipo'],
//     );
//     usuarios.add(usuario);
//   }
//   return usuarios;
// }

// Future<Database> alterarUsuario() {
//   return getDatabasesPath().then((dbPath) {
//     final String path = join(dbPath, 'easymed.db');
//     return openDatabase(path, onCreate: (db, version) {
//       db.execute('ALTER TABLE usuario(ADD COLUMN idade INTEGER)');
//     }, version: 2);
//   });
// }



validarEmail(emailnovo, senha) async {
  final Database db = await getDatabase();
  final List<Map> emails = await db.rawQuery('SELECT email FROM usuario');
  for (var item in emails) {
    if (item.containsValue(emailnovo)) return true;
  };
  return false;
}

validarEmailSenha(emailnovo, senha) async {
  print(emailnovo);
  print(senha);
  final Database db = await getDatabase();
  final List<Map> emails =
  await db.rawQuery('SELECT email, senha FROM usuario');
  print(emails);
  for (var item in emails) {
    if (item['email'] == emailnovo) {
      if (item['senha'] == senha) {
        return true;
      }
    }
  }
  // print('achou nada nao jovem');
  return false;
}


  Future<Usuario> getUsuarioBD(email) async {
  final Database db = await getDatabase();
  final maps = await db.rawQuery('SELECT * FROM usuario WHERE email = "$email"');
  return Usuario.fromJson(maps.first);
}

Future<Usuario> getAllUsuario() async {
  final Database db = await getDatabase();
  final maps = await db.rawQuery('SELECT * FROM usuario');
  return Usuario.fromJson(maps.first);

}

}