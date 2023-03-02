import 'dart:io';
import 'package:modelagem/Models/Consulta.dart';
import 'package:modelagem/Models/Medicamento.dart';
import 'package:modelagem/Models/Medico.dart';
import 'package:modelagem/Models/Prescricao.dart';

import '../lib/Models/Paciente.dart';
import '../lib/Models/Constants.dart';

void main(List<String> arguments) {
  int escolha;
  int idMenu;

  MenuPrincipal();
  escolha = int.parse(stdin.readLineSync().toString());

  if(escolha == AcoesMenuPrincipal.CADASTROS) {
    MenuCadastros();
    escolha = int.parse(stdin.readLineSync().toString());

    if(escolha == AcoesMenuCadastros.PACIENTE) {
      print('Informe o nome do paciente: ');
      Paciente p = new Paciente(stdin.readLineSync().toString());
      p.id = Paciente.Lista.last.id! + 1;
      Paciente.Lista.add(p);
    }
    else if(escolha == AcoesMenuCadastros.MEDICO) {
      print('Informe o nome do Medico: ');
      Medico m = new Medico(stdin.readLineSync().toString());
      m.id = Medico.Lista.last.id! + 1;
      Medico.Lista.add(m);
    }
    else if(escolha == AcoesMenuCadastros.MEDICAMENTO) {
      print('Informe o nome do Medicamento: ');
      Medicamento m = new Medicamento(stdin.readLineSync().toString());
      m.id = Medicamento.Lista.last.id! + 1;
      Medicamento.Lista.add(m);
    }
    else if(escolha == AcoesMenuCadastros.VOLTAR) {

    }
  }
  else if(escolha == AcoesMenuPrincipal.REGISTRAR_CONSULTA_E_PRESCRICAO) {
    print('Informe o id do médico: ');
    int idMedico = int.parse(stdin.readLineSync().toString());
    print('Informe o id do paciente: ');
    int idPaciente = int.parse(stdin.readLineSync().toString());

    Consulta.Lista.add(new Consulta(idMedico, idPaciente));

    print('Informe o id do medicamento: ');
    int idMedicamento = int.parse(stdin.readLineSync().toString());
    print('Descreva a posologia: ');
    String posologia = stdin.readLineSync().toString();

    Prescricao.Lista.add(new Prescricao(idMedicamento, posologia));
  }
  else if(escolha == AcoesMenuPrincipal.RELATORIOS) {
    MenuRelatorios();
    escolha = int.parse(stdin.readLineSync().toString());

    if(escolha == AcoesMenuRelatorio.PACIENTE) {
      Paciente.Lista.forEach((paciente) => print('id: ${paciente.id} nome: ${paciente.nome}'));
    }
    else if(escolha == AcoesMenuRelatorio.MEDICO) {
      Medico.Lista.forEach((medico) => print('id: ${medico.id} nome: ${medico.nome}'));
    }
    else if(escolha == AcoesMenuRelatorio.MEDICAMENTO_MAIS_UTILIZADO) {
      var contador = <int, int>{};

      Prescricao.Lista.forEach((prescricao) {
        if(contador.containsKey(prescricao.idMedicamento))
          contador[prescricao.idMedicamento] = contador[prescricao.idMedicamento]! +1;
        else
          contador[prescricao.idMedicamento] = 1;
      });
      
    }
  }
  else if(escolha == AcoesMenuPrincipal.SAIR) {

  }
}

void MenuRelatorios() {
  [
    'Menu Relatório',
    '[1] - Exibir dados da consulta por paciente.',
    '[2] - Exibir dados da consulta por médico.',
    '[3] - Exibir medicamento mais utilizado.',
    '[4] - Voltar'
  ].forEach(print);
}

void MenuPrincipal() {
  print('''
Menu Principal
[1] - Cadastros.
[2] - Registrar Consulta e Prescrição.
[3] - Relatórios.
[4] - Sair.
  ''');
}

void MenuCadastros() {
  print('''
Menu de Cadastros
[1] - Paciente.
[2] - Médico.
[3] - Medicamento.
[4] - Voltar
    ''');
}
