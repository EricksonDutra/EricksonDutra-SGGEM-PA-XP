import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sggm/models/eventos.dart';
import 'package:sggm/util/constants.dart';

class EventoProvider with ChangeNotifier {
  List<Evento> _eventos = [];
  final String apiUrl = AppConstants.eventosEndpoint;

  List<Evento> get eventos => _eventos;

  Future<void> listarEventos() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

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
        Uri.parse(apiUrl),
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
      Uri.parse('$apiUrl/$id'),
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
    final response = await http.delete(Uri.parse('$apiUrl$id/'));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      _eventos.removeWhere((evento) => evento.id == id);
      notifyListeners();
    } else {
      throw Exception('Falha ao deletar evento');
    }
  }
}
