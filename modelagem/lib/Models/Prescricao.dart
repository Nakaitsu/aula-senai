class Prescricao {
  late int id;
  int idMedicamento;
  String posologia;
  static List<Prescricao> Lista = [];

  Prescricao(this.idMedicamento, this.posologia);
}