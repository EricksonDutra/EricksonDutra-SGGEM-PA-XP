class Musicas {
  int? _musicaId;
  String? _nome;
  String? _compositor;
  String? _duracao;

  Musicas({int? musicaId, String? nome, String? compositor, String? duracao}) {
    if (musicaId != null) {
      _musicaId = musicaId;
    }
    if (nome != null) {
      _nome = nome;
    }
    if (compositor != null) {
      _compositor = compositor;
    }
    if (duracao != null) {
      _duracao = duracao;
    }
  }

  set musicaId(int? musicaId) => _musicaId = musicaId;
  set nome(String? nome) => _nome = nome;
  set compositor(String? compositor) => _compositor = compositor;
  set duracao(String? duracao) => _duracao = duracao;

  Musicas.fromJson(Map<String, dynamic> json) {
    _musicaId = json['musicaId'];
    _nome = json['nome'];
    _compositor = json['compositor'];
    _duracao = json['duracao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['musicaId'] = _musicaId;
    data['nome'] = _nome;
    data['compositor'] = _compositor;
    data['duracao'] = _duracao;
    return data;
  }
}
