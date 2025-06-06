import 'package:flutter/material.dart';
import 'package:flutter_application_4/DadosTemporarios.dart';


class AgendamentosScreen extends StatefulWidget {
  const AgendamentosScreen({super.key});

  @override
  State<AgendamentosScreen> createState() => _AgendamentosScreenState();
}

class _AgendamentosScreenState extends State<AgendamentosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              final result =
                  await Navigator.pushNamed(context, '/novo-agendamento');
              if (result == true) {
                setState(() {}); 
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: DadosTemporarios.agendamentos.length,
        itemBuilder: (context, index) {
          final agendamento = DadosTemporarios.agendamentos[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: CircleAvatar(
                backgroundColor:
                    _getStatusColor(agendamento['status'] as String),
                child: Text(
                  (agendamento['nomeCliente'] as String)[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                agendamento['nomeCliente'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    '${_formatarData(agendamento['dataInicio'] as DateTime)} - ${_formatarData(agendamento['dataFim'] as DateTime)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.people, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text('${agendamento['quantidadePessoas']} pessoas'),
                      const SizedBox(width: 16),
                      Icon(Icons.attach_money,
                          size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                          'R\$ ${(agendamento['valorTotal'] as double).toStringAsFixed(2)}'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(agendamento['status'] as String),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      agendamento['status'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  '/detalhes-agendamento',
                  arguments: agendamento,
                );
                if (result == true) {
                  setState(() {}); 
                }
              },
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmado':
        return Colors.green;
      case 'Pendente':
        return Colors.orange;
      case 'Cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }
}
