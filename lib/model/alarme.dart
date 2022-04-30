class Alarme {
  final int? idAlarme;
  final int? idUsuario;
  final int? idMedicamento;
  final String? nome;

  // final DateTime? data;
  final String? data;

  Alarme(
      {this.idAlarme,
      this.idUsuario,
      this.idMedicamento,
      this.nome,
      this.data});

  factory Alarme.fromJson(Map<String, Object?> json) => Alarme(
        idAlarme: json["idAlarme"] as int?,
        idUsuario: json["idUsuario"] as int?,
        idMedicamento: json["idMedicamento"] as int?,
        nome: json["nome"] as String,
        // data: json["data"] as DateTime,
        data: json["data"] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'idAlarme': idAlarme,
      'idUsuario': idUsuario,
      'idMedicamento': idMedicamento,
      'nome': nome,
      // 'data': data?.toIso8601String(),
      'data': data,
    };
  }

  @override
  String toString() {
    return 'Usuario{idAlarme: $idAlarme, idUsuario: $idUsuario, idMedicamento: $idMedicamento, nome: $nome, data: $data}';
  }
}
