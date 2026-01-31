import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sggm/models/eventos.dart';

class EventoProvider with ChangeNotifier {
  List<Evento> _eventos = [];
  // final String apiUrl = 'http://127.0.0.1:8000/api/eventos/';
  // final String apiUrl = 'http://192.168.100.9:8000/api/eventos/';
  // static const String _baseUrl = 'http://168.227.211.82/api/eventos/';
  static const String _baseUrl = 'http://172.19.141.245:8000/api/eventos/';

  List<Evento> get eventos => _eventos;

  Future<void> listarEventos() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes)); 
        _eventos = data.map((item) => Evento.fromJson(item)).toList();
        notifyListeners();
      } else {
        print('Erro API: ${response.statusCode} - ${response.body}');
        throw Exception('Falha ao carregar eventos');
      }
    } catch (e) {
      print('Erro de conexão: $e');
      rethrow;
    }
  }

  Future<void> adicionarEvento(Evento evento) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(evento.toJson()),
      );

      if (response.statusCode == 201) {
        final novoEvento = Evento.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        _eventos.add(novoEvento);
        notifyListeners();
      } else {
        throw Exception('Falha ao adicionar: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizarEvento(int id, Evento novoEvento) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(novoEvento.toJson()),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final index = _eventos.indexWhere((evento) => evento.id == id);
      if (index != -1) {
        _eventos[index] = novoEvento;
        notifyListeners();
      }
    } else {
      throw Exception('Falha ao atualizar evento');
    }
  }

  Future<void> deletarEvento(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl$id/'));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      _eventos.removeWhere((evento) => evento.id == id);
      notifyListeners();
    } else {
      throw Exception('Falha ao deletar evento');
    }
  }
}
