class Eventos {
  int? _eventoId;
  String? _nome;
  String? _dataEvento;
  String? _local;
  String? _descricao;

  Eventos({int? eventoId, String? nome, String? dataEvento, String? local, String? descricao}) {
    if (eventoId != null) {
      _eventoId = eventoId;
    }
    if (nome != null) {
      _nome = nome;
    }
    if (dataEvento != null) {
      _dataEvento = dataEvento;
    }
    if (local != null) {
      _local = local;
    }
    if (descricao != null) {
      _descricao = descricao;
    }
  }

  int? get eventoId => _eventoId;
  set eventoId(int? eventoId) => _eventoId = eventoId;
  String? get nome => _nome;
  set nome(String? nome) => _nome = nome;
  String? get dataEvento => _dataEvento;
  set dataEvento(String? dataEvento) => _dataEvento = dataEvento;
  String? get local => _local;
  set local(String? local) => _local = local;
  String? get descricao => _descricao;
  set descricao(String? descricao) => _descricao = descricao;

  Eventos.fromJson(Map<String, dynamic> json) {
    _eventoId = json['eventoId'];
    _nome = json['nome'];
    _dataEvento = json['dataEvento'];
    _local = json['local'];
    _descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventoId'] = _eventoId;
    data['nome'] = _nome;
    data['dataEvento'] = _dataEvento;
    data['local'] = _local;
    data['descricao'] = _descricao;
    return data;
  }
}
