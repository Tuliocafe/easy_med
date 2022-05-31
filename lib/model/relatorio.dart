class Relatorio {
  final int? idRelatorio;
  final int? idAlarme;
  final String? dataRegistro;
  final String? confirmacaoUso;
  final String? nome;

  Relatorio({
    this.idRelatorio,
    this.idAlarme,
    this.dataRegistro,
    this.confirmacaoUso,
    this.nome,
  });

  factory Relatorio.fromJson(Map<String, Object?> json) => Relatorio(
        idRelatorio: json["idRelatorio"] as int?,
        idAlarme: json["idAlarme"] as int?,
        dataRegistro: json["dataRegistro"] as String,
        confirmacaoUso: json["confirmacaoUso"] as String,
        nome: json["nome"] as String?,
      );

  Map<String, dynamic> toJson() {
    return {
      'idRelatorio': idRelatorio,
      'idAlarme': idAlarme,
      'dataRegistro': dataRegistro,
      'confirmacaoUso': confirmacaoUso,
      'nome': nome
    };
  }

  @override
  String toString() {
    return 'Alarme{idRelatorio: $idRelatorio, idAlarme: $idAlarme,'
        ' dataRegistro: $dataRegistro, confirmacaoUso: $confirmacaoUso , nome: $nome}';
  }
}
