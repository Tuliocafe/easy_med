class OcorrenciaAlarme {
  final int? idOcorrencia;
  final int? idAlarme;
  final String? dataRegistro;
  final String? confirmacaoUso;
  final String? nome;

  OcorrenciaAlarme({
    this.idOcorrencia,
    this.idAlarme,
    this.dataRegistro,
    this.confirmacaoUso,
    this.nome,
  });

  factory OcorrenciaAlarme.fromJson(Map<String, Object?> json) => OcorrenciaAlarme(
    idOcorrencia: json["idRelatorio"] as int?,
        idAlarme: json["idAlarme"] as int?,
        dataRegistro: json["dataRegistro"] as String,
        confirmacaoUso: json["confirmacaoUso"] as String,
        nome: json["nome"] as String?,
      );

  Map<String, dynamic> toJson() {
    return {
      'idOcorrencia': idOcorrencia,
      'idAlarme': idAlarme,
      'dataRegistro': dataRegistro,
      'confirmacaoUso': confirmacaoUso,
      'nome': nome
    };
  }

  @override
  String toString() {
    return 'Alarme{idOcorrencia: $idOcorrencia, idAlarme: $idAlarme,'
        ' dataRegistro: $dataRegistro, confirmacaoUso: $confirmacaoUso , nome: $nome}';
  }
}
