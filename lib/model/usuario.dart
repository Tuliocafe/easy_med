class Usuario {
  final int? idUsuario;
  final String? nome;
  final String? genero;
  final int? idade;
  final String? email;
  final String? senha;

  Usuario(
      {this.idUsuario,
      this.nome,
      this.genero,
      this.idade,
      this.email,
      this.senha});

  factory Usuario.fromJson(Map<String, Object?> json) => Usuario(
      idUsuario: json["idUsuario"] as int?,
      nome: json["nome"] as String,
      genero: json["genero"] as String,
      idade: json["idade"] as int?,
      email: json["email"] as String,
      senha: json["senha"] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'nome': nome,
      'genero': genero,
      'idade': idade,
      'email': email,
      'senha': senha,
    };
  }

  @override
  String toString() {
    return 'Usuario{idUsuario: $idUsuario, nome: $nome, genero: $genero, idade: $idade, email: $email, senha: $senha}';
  }
}
