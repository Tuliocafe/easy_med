class Usuario {
  final int? idUsuario;
  final String? nome;
  final String? sexo;
  final int? idade;
  final String? email;
  final String? senha;
  final String? tipo;

  Usuario(
      {this.idUsuario,
      this.nome,
      this.sexo,
      this.idade,
      this.email,
      this.senha,
      this.tipo});

  factory Usuario.fromJson(Map<String, Object?> json) => Usuario(
      idUsuario: json["idUsuario"] as int?,
      nome: json["nome"] as String,
      sexo: json["sexo"] as String,
      idade: json["idade"] as int?,
      email: json["email"] as String,
      senha: json["senha"] as String,
      tipo: json["tipo"] as String);

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'nome': nome,
      'sexo': sexo,
      'idade': idade,
      'email': email,
      'senha': senha,
      'tipo': tipo,
    };
  }

  @override
  String toString() {
    return 'Usuario{idUsuario: $idUsuario, nome: $nome, sexo: $sexo, idade: $idade, email: $email, senha: $senha,'
        ' tipo: $tipo }';
  }
}
