import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sggm/models/eventos.dart';

class EventoProvider with ChangeNotifier {
  List<Eventos> _eventos = [];
  final String apiUrl = 'http://127.0.0.1:8000/api/eventos/';

  List<Eventos> get eventos => _eventos;

  // Método para listar eventos
  Future<void> listarEventos() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _eventos = data.map((item) => Eventos.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar eventos');
    }
  }

  // Método para adicionar um evento
  Future<void> adicionarEvento(Eventos evento) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(evento.toJson()),
    );
    if (response.statusCode == 201) {
      _eventos.add(evento);
      notifyListeners();
    } else {
      throw Exception('Falha ao adicionar evento');
    }
  }

  // Método para atualizar um evento
  Future<void> atualizarEvento(int id, Eventos novoEvento) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(novoEvento.toJson()),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final index = _eventos.indexWhere((evento) => evento.eventoId == id);
      if (index != -1) {
        _eventos[index] = novoEvento;
        notifyListeners();
      }
    } else {
      throw Exception('Falha ao atualizar evento');
    }
  }

  // Método para deletar um evento
  Future<void> deletarEvento(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl$id/'));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      _eventos.removeWhere((evento) => evento.eventoId == id);
      notifyListeners();
    } else {
      throw Exception('Falha ao deletar evento');
    }
  }
}
