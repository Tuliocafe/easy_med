class Alarme {
  final int? idAlarme;
  final int? idUsuario;
  final int? idMedicamento;
  final String? nome;
  final String? hora;
  final String? minuto;
  final int? quantidade;

  Alarme({
    this.idAlarme,
    this.idUsuario,
    this.idMedicamento,
    this.nome,
    this.hora,
    this.minuto,
    this.quantidade,
  });

  factory Alarme.fromJson(Map<String, Object?> json) => Alarme(
        idAlarme: json["idAlarme"] as int?,
        idUsuario: json["idUsuario"] as int?,
        idMedicamento: json["idMedicamento"] as int?,
        nome: json["nome"] as String,
        hora: json["hora"] as String,
        minuto: json["minuto"] as String,
        quantidade: json["quantidade"] as int?,
      );

  Map<String, dynamic> toJson() {
    return {
      'idAlarme': idAlarme,
      'idUsuario': idUsuario,
      'idMedicamento': idMedicamento,
      'nome': nome,
      'hora': hora,
      'minuto': minuto,
      'quantidade': quantidade,
    };
  }

  @override
  String toString() {
    return 'Alarme{idAlarme: $idAlarme, idUsuario: $idUsuario,'
        ' idMedicamento: $idMedicamento, nome: $nome, hora: $hora, minuto: $minuto,'
        ' quantidade: $quantidade}';
  }
}
