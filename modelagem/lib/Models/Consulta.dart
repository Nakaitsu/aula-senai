import 'package:modelagem/Models/Prescricao.dart';

class Consulta {
  late int id;
  int idMedico;
  int idPaciente;
  DateTime data;
  Prescricao? prescricao;
  static List<Consulta> Lista = [];

  Consulta(this.idMedico, this.idPaciente, this.data);
}