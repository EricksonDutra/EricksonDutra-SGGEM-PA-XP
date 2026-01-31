class Evento {
  final int? id; 
  final String nome;
  final String dataEvento;
  final String local;
  final String? descricao;
  
  Evento({
    this.id,
    required this.nome,
    required this.dataEvento,
    required this.local,
    this.descricao,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json['id'], 
      nome: json['nome'],
      dataEvento: json['data_evento'] ?? '', 
      local: json['local'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'data_evento': dataEvento, 
      'local': local,
      'descricao': descricao,
    };
  }
}