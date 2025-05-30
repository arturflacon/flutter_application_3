import 'package:flutter/material.dart';
import 'package:flutter_application_4/DadosTemporarios.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chácara Recanto Verde'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DadosTemporarios.informacoesChacara['nome'] as String,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DadosTemporarios.informacoesChacara['endereco'] as String,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      DadosTemporarios.informacoesChacara['cidade'] as String,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.people, color: Colors.green[600]),
                        const SizedBox(width: 8),
                        Text(
                          'Capacidade: ${DadosTemporarios.informacoesChacara['capacidadeMaxima']} pessoas',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: Colors.green[600]),
                        const SizedBox(width: 8),
                        Text(
                          'Diária: R\$ ${(DadosTemporarios.informacoesChacara['valorDiaria'] as double).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/agendamentos');
              },
              icon: const Icon(Icons.calendar_today),
              label: const Text('Ver Agendamentos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/novo-agendamento');
              },
              icon: const Icon(Icons.add),
              label: const Text('Novo Agendamento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Comodidades:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount:
                    (DadosTemporarios.informacoesChacara['comodidades'] as List)
                        .length,
                itemBuilder: (context, index) {
                  final comodidade =
                      (DadosTemporarios.informacoesChacara['comodidades']
                          as List)[index] as String;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: Colors.green[600], size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              comodidade,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
