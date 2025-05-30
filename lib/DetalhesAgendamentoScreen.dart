import 'package:flutter/material.dart';
import 'package:flutter_application_4/DadosTemporarios.dart';

class DetalhesAgendamentoScreen extends StatefulWidget {
  const DetalhesAgendamentoScreen({super.key});

  @override
  State<DetalhesAgendamentoScreen> createState() =>
      _DetalhesAgendamentoScreenState();
}

class _DetalhesAgendamentoScreenState extends State<DetalhesAgendamentoScreen> {
  @override
  Widget build(BuildContext context) {
    final agendamento =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Agendamento'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'editar') {
                _mostrarDialogoEdicao(context, agendamento);
              } else if (value == 'excluir') {
                _mostrarDialogoExclusao(context, agendamento);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'editar',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Editar'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'excluir',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Excluir', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            _getStatusColor(agendamento['status'] as String),
                        radius: 30,
                        child: Text(
                          (agendamento['nomeCliente'] as String)[0]
                              .toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              agendamento['nomeCliente'] as String,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(
                                    agendamento['status'] as String),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                agendamento['status'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informações de Contato',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.phone, 'Telefone',
                      agendamento['telefone'] as String),
                  if (agendamento['email'] != null)
                    _buildInfoRow(
                        Icons.email, 'E-mail', agendamento['email'] as String),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detalhes do Agendamento',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.calendar_today,
                    'Data início',
                    _formatarData(agendamento['dataInicio'] as DateTime),
                  ),
                  _buildInfoRow(
                    Icons.calendar_today,
                    'Data fim',
                    _formatarData(agendamento['dataFim'] as DateTime),
                  ),
                  _buildInfoRow(
                    Icons.people,
                    'Pessoas',
                    '${agendamento['quantidadePessoas']} pessoas',
                  ),
                  _buildInfoRow(
                    Icons.attach_money,
                    'Valor total',
                    'R\$ ${(agendamento['valorTotal'] as double).toStringAsFixed(2)}',
                  ),
                  if (agendamento['observacoes'] != null)
                    _buildInfoRow(Icons.notes, 'Observações',
                        agendamento['observacoes'] as String),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green[600], size: 20),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
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

  void _mostrarDialogoEdicao(
      BuildContext context, Map<String, dynamic> agendamento) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alterar Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const CircleAvatar(
                  backgroundColor: Colors.orange, radius: 10),
              title: const Text('Pendente'),
              onTap: () {
                setState(() {
                  agendamento['status'] = 'Pendente';
                });
                Navigator.pop(context);
                Navigator.pop(
                    context, true); 
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Status alterado para Pendente')),
                );
              },
            ),
            ListTile(
              leading:
                  const CircleAvatar(backgroundColor: Colors.green, radius: 10),
              title: const Text('Confirmado'),
              onTap: () {
                setState(() {
                  agendamento['status'] = 'Confirmado';
                });
                Navigator.pop(context);
                Navigator.pop(
                    context, true); 
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Status alterado para Confirmado')),
                );
              },
            ),
            ListTile(
              leading:
                  const CircleAvatar(backgroundColor: Colors.red, radius: 10),
              title: const Text('Cancelado'),
              onTap: () {
                setState(() {
                  agendamento['status'] = 'Cancelado';
                });
                Navigator.pop(context);
                Navigator.pop(
                    context, true); 
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Status alterado para Cancelado')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoExclusao(
      BuildContext context, Map<String, dynamic> agendamento) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
            'Deseja realmente excluir o agendamento de ${agendamento['nomeCliente']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              DadosTemporarios.agendamentos
                  .removeWhere((item) => item['id'] == agendamento['id']);
              Navigator.pop(context); // Fecha o diálogo
              Navigator.pop(context,
                  true); // Volta para a lista com indicação de alteração
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Agendamento excluído com sucesso')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
