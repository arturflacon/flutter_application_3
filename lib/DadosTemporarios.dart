class DadosTemporarios {
  static final List<Map<String, dynamic>> agendamentos = [
    {
      'id': 1,
      'nomeCliente': 'João Silva',
      'telefone': '(11) 99999-9999',
      'email': 'joao@email.com',
      'dataInicio': DateTime(2025, 6, 15),
      'dataFim': DateTime(2025, 6, 16),
      'quantidadePessoas': 20,
      'valorTotal': 800.0,
      'status': 'Confirmado',
      'observacoes': 'Festa de aniversário',
    },
    {
      'id': 2,
      'nomeCliente': 'Maria Santos',
      'telefone': '(11) 88888-8888',
      'email': 'maria@email.com',
      'dataInicio': DateTime(2025, 6, 22),
      'dataFim': DateTime(2025, 6, 23),
      'quantidadePessoas': 15,
      'valorTotal': 600.0,
      'status': 'Pendente',
      'observacoes': 'Reunião familiar',
    },
    {
      'id': 3,
      'nomeCliente': 'Pedro Costa',
      'telefone': '(11) 77777-7777',
      'email': 'pedro@email.com',
      'dataInicio': DateTime(2025, 7, 1),
      'dataFim': DateTime(2025, 7, 2),
      'quantidadePessoas': 30,
      'valorTotal': 1000.0,
      'status': 'Confirmado',
      'observacoes': 'Evento corporativo',
    },
  ];

  static const Map<String, dynamic> informacoesChacara = {
    'nome': 'Chácara Recanto Verde',
    'endereco': 'Frente aos 3 Morrinhos',
    'cidade': 'Terra Rica - PR',
    'capacidadeMaxima': 50,
    'valorDiaria': 450.0,
    'comodidades': [
      'Piscina',
      'Churrasqueira',
      'Salão de festas',
      'Riacho',
      'Área verde',
      'Estacionamento'
    ],
  };
}
