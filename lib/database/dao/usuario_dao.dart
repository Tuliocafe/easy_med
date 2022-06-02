import 'package:sqflite/sqflite.dart';
import '../../model/usuario.dart';
import '../app_database.dart';

class usuarioDao {


Future<int> salvarUsuario(Usuario usuario) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> usuarioMap = Map();
  usuarioMap['nome'] = usuario.nome;
  usuarioMap['genero'] = usuario.genero;
  usuarioMap['idade'] = usuario.idade;
  usuarioMap['email'] = usuario.email;
  usuarioMap['senha'] = usuario.senha;
  return db.insert('usuario', usuarioMap);
}


validarEmail(emailnovo, senha) async {
  final Database db = await getDatabase();
  final List<Map> emails = await db.rawQuery('SELECT email FROM usuario');
  for (var item in emails) {
    if (item.containsValue(emailnovo)) return true;
  };
  return false;
}

validarEmailSenha(emailnovo, senha) async {
  final Database db = await getDatabase();
  final List<Map> emails =
  await db.rawQuery('SELECT email, senha FROM usuario');
  for (var item in emails) {
    if (item['email'] == emailnovo) {
      if (item['senha'] == senha) {
        return true;
      }
    }
  }
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