import 'package:flutter/material.dart';
import 'package:flutter_application_4/DadosTemporarios.dart';

class NovoAgendamentoScreen extends StatefulWidget {
  const NovoAgendamentoScreen({super.key});

  @override
  State<NovoAgendamentoScreen> createState() => _NovoAgendamentoScreenState();
}

class _NovoAgendamentoScreenState extends State<NovoAgendamentoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _pessoasController = TextEditingController();
  final _observacoesController = TextEditingController();

  DateTime? _dataInicio;
  DateTime? _dataFim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Agendamento'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dados do Cliente',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome completo *',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _telefoneController,
                      decoration: const InputDecoration(
                        labelText: 'Telefone *',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
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
                      'Dados do Agendamento',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: const Icon(Icons.calendar_today),
                            title: const Text('Data início'),
                            subtitle: Text(
                              _dataInicio != null
                                  ? _formatarData(_dataInicio!)
                                  : 'Selecionar',
                            ),
                            onTap: () => _selecionarData(context, true),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ListTile(
                            leading: const Icon(Icons.calendar_today),
                            title: const Text('Data fim'),
                            subtitle: Text(
                              _dataFim != null
                                  ? _formatarData(_dataFim!)
                                  : 'Selecionar',
                            ),
                            onTap: () => _selecionarData(context, false),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pessoasController,
                      decoration: const InputDecoration(
                        labelText: 'Quantidade de pessoas *',
                        prefixIcon: Icon(Icons.people),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        final int? pessoas = int.tryParse(value);
                        if (pessoas == null || pessoas <= 0) {
                          return 'Valor inválido';
                        }
                        if (pessoas >
                            DadosTemporarios
                                .informacoesChacara['capacidadeMaxima']) {
                          return 'Máximo ${DadosTemporarios.informacoesChacara['capacidadeMaxima']} pessoas';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _observacoesController,
                      decoration: const InputDecoration(
                        labelText: 'Observações',
                        prefixIcon: Icon(Icons.notes),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvarAgendamento,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Salvar Agendamento'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selecionarData(BuildContext context, bool isInicio) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isInicio) {
          _dataInicio = picked;
          if (_dataFim != null && _dataFim!.isBefore(picked)) {
            _dataFim = null;
          }
        } else {
          if (_dataInicio == null ||
              picked.isAfter(_dataInicio!) ||
              picked.isAtSameMomentAs(_dataInicio!)) {
            _dataFim = picked;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Data fim deve ser posterior à data início')),
            );
          }
        }
      });
    }
  }

  void _salvarAgendamento() {
    if (_formKey.currentState!.validate()) {
      if (_dataInicio == null || _dataFim == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione as datas de início e fim')),
        );
        return;
      }

      final int dias = _dataFim!.difference(_dataInicio!).inDays + 1;
      final double valorTotal =
          dias * (DadosTemporarios.informacoesChacara['valorDiaria'] as double);
      final novoAgendamento = {
        'id': DadosTemporarios.agendamentos.length + 1,
        'nomeCliente': _nomeController.text,
        'telefone': _telefoneController.text,
        'email': _emailController.text.isEmpty ? null : _emailController.text,
        'dataInicio': _dataInicio!,
        'dataFim': _dataFim!,
        'quantidadePessoas': int.parse(_pessoasController.text),
        'valorTotal': valorTotal,
        'status': 'Pendente',
        'observacoes': _observacoesController.text.isEmpty
            ? null
            : _observacoesController.text,
      };

      setState(() {
        DadosTemporarios.agendamentos.add(novoAgendamento);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agendamento salvo com sucesso!')),
      );

      Navigator.pop(context);
    }
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _pessoasController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }
}
