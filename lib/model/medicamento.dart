class Medicamento {
  final int? idMedicamento;
  final String? nome;
  final String? dosagem;
  final int? quantidade;
  final String? laboratorio;

  Medicamento(
      {this.idMedicamento,
      this.nome,
      this.dosagem,
      this.quantidade,
      this.laboratorio});

  factory Medicamento.fromJson(Map<String, Object?> json) => Medicamento(
        idMedicamento: json["idMedicamento"] as int?,
        nome: json["nome"] as String,
        dosagem: json["dosagem"] as String,
        quantidade: json["quantidade"] as int?,
        laboratorio: json["laboratorio"] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'idMedicamento': idMedicamento,
      'nome': nome,
      'dosagem': dosagem,
      'quantidade': quantidade,
      'laboratorio': laboratorio,
    };
  }

  @override
  String toString() {
    return 'Medicamento{idMedicamento: $idMedicamento, nome: $nome, dosagem: $dosagem, quantidade: $quantidade,}';
  }
}
