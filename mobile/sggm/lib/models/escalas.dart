class Escalas {
  int? _escalaId;
  String? _dataEscala;
  int? _musico;
  int? _evento;

  Escalas({int? escalaId, String? dataEscala, int? musico, int? evento}) {
    if (escalaId != null) {
      _escalaId = escalaId;
    }
    if (dataEscala != null) {
      _dataEscala = dataEscala;
    }
    if (musico != null) {
      _musico = musico;
    }
    if (evento != null) {
      _evento = evento;
    }
  }

  int? get escalaId => _escalaId;
  set escalaId(int? escalaId) => _escalaId = escalaId;
  String? get dataEscala => _dataEscala;
  set dataEscala(String? dataEscala) => _dataEscala = dataEscala;
  int? get musico => _musico;
  set musico(int? musico) => _musico = musico;
  int? get evento => _evento;
  set evento(int? evento) => _evento = evento;

  Escalas.fromJson(Map<String, dynamic> json) {
    _escalaId = json['escalaId'];
    _dataEscala = json['dataEscala'];
    _musico = json['musico'];
    _evento = json['evento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['escalaId'] = _escalaId;
    data['dataEscala'] = _dataEscala;
    data['musico'] = _musico;
    data['evento'] = _evento;
    return data;
  }
}
