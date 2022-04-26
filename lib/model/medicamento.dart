class Medicamento {
  final int? id;
  final String? nome;
  final String? dosagem;
  final int? quantidade;
  final String? laboratorio;

  Medicamento(
      {this.id, this.nome, this.dosagem, this.quantidade, this.laboratorio});

  factory Medicamento.fromJson(Map<String, Object?> json) => Medicamento(
        id: json["id"] as int,
        nome: json["nome"] as String,
        dosagem: json["dosagem"] as String,
        quantidade: json["quantidade"] as int,
        laboratorio: json["laboratorio"] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'dosagem': dosagem,
      'quantidade': quantidade,
      'laboratorio': laboratorio,
    };
  }

  @override
  String toString() {
    return 'Medicamento{id: $id, nome: $nome, dosagem: $dosagem, quantidade: $quantidade,}';
  }
}
