import 'dart:io';
import 'dart:math';
import 'package:modelagem/Models/Consulta.dart';
import 'package:modelagem/Models/Medicamento.dart';
import 'package:modelagem/Models/Medico.dart';
import 'package:modelagem/Models/Prescricao.dart';

import '../lib/Models/Paciente.dart';
import '../lib/Models/Constants.dart';

void main(List<String> arguments) {
  int escolha;
  int idMenu = Menus.PRINCIPAL;

  do {
    MenuPrincipal();
    print('Escolha uma opção: ');
    escolha = int.parse(stdin.readLineSync().toString());

    if(escolha == AcoesMenuPrincipal.CADASTROS) {
      idMenu = Menus.CADASTROS;

      while(idMenu == Menus.CADASTROS && escolha != 4) {
        MenuCadastros();
        print('Escolha uma opção: ');
        escolha = int.parse(stdin.readLineSync().toString());

        if(escolha == AcoesMenuCadastros.PACIENTE) {
          print('Informe o nome do paciente: ');
          Paciente p = new Paciente(stdin.readLineSync().toString());
          p.id = Paciente.Lista.length > 0 ? Paciente.Lista.last.id + 1 : 1;
          Paciente.Lista.add(p);

          print('id: ${p.id} nome: ${p.nome}');
        }
        else if(escolha == AcoesMenuCadastros.MEDICO) {
          print('Informe o nome do Medico: ');
          Medico m = new Medico(stdin.readLineSync().toString());
          m.id = Medico.Lista.length > 0 ? Medico.Lista.last.id + 1 : 1;
          Medico.Lista.add(m);

          print('id: ${m.id} nome: ${m.nome}');
        }
        else if(escolha == AcoesMenuCadastros.MEDICAMENTO) {
          print('Informe o nome do Medicamento: ');
          String nomeMedicamento = stdin.readLineSync().toString();
          print('Informe a quantidade do Medicamento: ');
          int quantidade = int.parse(stdin.readLineSync().toString());

          Medicamento m = new Medicamento(nomeMedicamento, quantidade);
          m.id = Medicamento.Lista.length > 0 ? Medicamento.Lista.last.id + 1 : 1;
          Medicamento.Lista.add(m);

          print('id: ${m.id} nome: ${m.nome} quantidade:${m.quantidade}');
        }
        else if(escolha == AcoesMenuCadastros.VOLTAR) {
          idMenu = Menus.PRINCIPAL;
        }

        print('');
      }

      escolha = 0;
    }
    else if(escolha == AcoesMenuPrincipal.REGISTRAR_CONSULTA_E_PRESCRICAO) {
      print('Informe o id do médico: ');
      int idMedico = int.parse(stdin.readLineSync().toString());
      print('Informe o id do paciente: ');
      int idPaciente = int.parse(stdin.readLineSync().toString());
      print('Informe a data nesse formato: aaaa-mm-dd');
      String data = stdin.readLineSync().toString();

      print('Informe o id do medicamento: ');
      int idMedicamento = int.parse(stdin.readLineSync().toString());
      print('Descreva a posologia: ');
      String posologia = stdin.readLineSync().toString();

      Consulta consulta = new Consulta(idMedico, idPaciente, DateTime.parse(data));
      Prescricao prescricao = new Prescricao(idMedicamento, posologia);

      consulta.id = Consulta.Lista.length > 0 ? Consulta.Lista.last.id + 1 : 1;
      prescricao.id = Prescricao.Lista.length > 0 ? Prescricao.Lista.last.id + 1 : 1;
      consulta.prescricao = prescricao;
      Consulta.Lista.add(consulta);
      Prescricao.Lista.add(prescricao);

      Medico.Lista.firstWhere((m) => m.id == consulta.idMedico).atendimentos++;
      print('');
    }
    else if(escolha == AcoesMenuPrincipal.RELATORIOS) {
      idMenu = Menus.RELATORIOS;

      while(idMenu == Menus.RELATORIOS && escolha != AcoesMenuRelatorio.VOLTAR ) {
        MenuRelatorios();
        print('Escolha uma opção: ');
        escolha = int.parse(stdin.readLineSync().toString());

        if(escolha == AcoesMenuRelatorio.CONSULTA) {
          Consulta.Lista.forEach((consulta) {
            String nomePaciente = Paciente.Lista.firstWhere((p) => p.id == consulta.idPaciente).nome;
            String nomeMedico = Medico.Lista.firstWhere((m) => m.id == consulta.idMedico).nome;
            String medicamento = Medicamento.Lista.firstWhere((m) => m.id == consulta.prescricao!.idMedicamento).nome;

            [
              'Consulta: ${consulta.id}',
              'Paciente: ${nomePaciente}',
              'Medico: ${nomeMedico}',
              'Data: ${consulta.data}',
              'Posologia: ${consulta.prescricao!.posologia}',
              'Medicamento: ${medicamento}',
              ''
            ].forEach(print);
          });
        }
        else if(escolha == AcoesMenuRelatorio.MEDICO) {
          Medico.Lista.forEach((medico) => print(
              'id: ${medico.id} nome: ${medico.nome} atendimentos: ${medico.atendimentos}'
          ));
        }
        else if(escolha == AcoesMenuRelatorio.MEDICAMENTO_MAIS_UTILIZADO) {
          int idMaisUtilizado = Prescricao.Lista.fold(0, (prev, prescricao) => prescricao.idMedicamento > prev ? prescricao.idMedicamento : prev);
          Medicamento medicamento = Medicamento.Lista.firstWhere((m) => m.id == idMaisUtilizado);

          print('medicamento: ${medicamento.nome} quantidade em estoque: ${medicamento.quantidade}');
        }
        else if(escolha == AcoesMenuPrincipal.SAIR) {
          idMenu = Menus.PRINCIPAL;
        }

        print('');
      }

      escolha = 0;
    }
  } while (idMenu == Menus.PRINCIPAL && escolha != 4);
}

void MenuRelatorios() {
  [
    '--Menu Relatório--',
    '[1] - Exibir dados da consulta por paciente.',
    '[2] - Exibir dados da consulta por médico.',
    '[3] - Exibir medicamento mais utilizado.',
    '[4] - Voltar'
  ].forEach(print);
}

void MenuPrincipal() {
  [
    '--Menu Principal--',
    '[1] - Cadastros.',
    '[2] - Registrar Consulta e Prescrição.',
    '[3] - Relatórios.',
    '[4] - Sair.'
  ].forEach(print);
}

void MenuCadastros() {
  [
    '--Menu de Cadastros--',
    '[1] - Paciente.',
    '[2] - Médico.',
    '[3] - Medicamento.',
    '[4] - Voltar'
  ].forEach(print);
}
