import 'package:flutter/material.dart';
import 'package:flutter_application_4/agendamentos.dart';
import 'package:flutter_application_4/detalheagenda.dart';
import 'package:flutter_application_4/home.dart';
import 'package:flutter_application_4/novoagendamento.dart';

void main() {
  runApp(const ChacaraApp());
}

class ChacaraApp extends StatelessWidget {
  const ChacaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agendamento Chácara',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/agendamentos': (context) => const AgendamentosScreen(),
        '/novo-agendamento': (context) => const NovoAgendamentoScreen(),
        '/detalhes-agendamento': (context) => const DetalhesAgendamentoScreen(),
      },
    );
  }
}
