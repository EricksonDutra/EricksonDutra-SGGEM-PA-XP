class Musicos {
  int? _musicoId;
  String? _nome;
  String? _telefone;
  String? _email;
  String? _endereco;

  Musicos({int? musicoId, String? nome, String? telefone, String? email, String? endereco}) {
    if (musicoId != null) {
      _musicoId = musicoId;
    }
    if (nome != null) {
      _nome = nome;
    }
    if (telefone != null) {
      _telefone = telefone;
    }
    if (email != null) {
      _email = email;
    }
    if (endereco != null) {
      _endereco = endereco;
    }
  }
  int? get musicoId => _musicoId;
  set musicoId(int? musicoId) => _musicoId = musicoId;
  set nome(String? nome) => _nome = nome;
  set telefone(String? telefone) => _telefone = telefone;
  set email(String? email) => _email = email;
  set endereco(String? endereco) => _endereco = endereco;

  Musicos.fromJson(Map<String, dynamic> json) {
    _musicoId = json['musicoId'];
    _nome = json['nome'];
    _telefone = json['telefone'];
    _email = json['email'];
    _endereco = json['endereco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['musicoId'] = _musicoId;
    data['nome'] = _nome;
    data['telefone'] = _telefone;
    data['email'] = _email;
    data['endereco'] = _endereco;
    return data;
  }
}
