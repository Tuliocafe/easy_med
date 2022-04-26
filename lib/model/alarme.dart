class Alarme {
  final int? id;
  final String? nome;
  final DateTime? data;

  Alarme({this.id, this.nome, this.data});


  factory Alarme.fromJson(Map<String, Object?> json) => Alarme(
      id: json["id"] as int,
      nome: json["nome"] as String,
      data: json["data"] as DateTime,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'data': data,
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, data: $data}';
  }
}


