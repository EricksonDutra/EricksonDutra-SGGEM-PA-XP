import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sggm/models/eventos.dart';
import 'package:sggm/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventoProvider with ChangeNotifier {
  List<Evento> _eventos = [];
  // final String apiUrl = 'http://127.0.0.1:8000/api/eventos/';
  // final String apiUrl = 'http://192.168.100.9:8000/api/eventos/';
  // static const String _baseUrl = 'http://168.227.211.82/api/eventos/';
  static const String _baseUrl = 'http://172.19.141.245:8000/api/eventos/';

  List<Evento> get eventos => _eventos;

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); 
    
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token', 
    };
  }

  Future<void> listarEventos() async {
    try {
      final headers = await _getHeaders(); // 2. Pega o cabeçalho pronto
      final response = await http.get(Uri.parse(_baseUrl), headers: headers); // 3. Envia
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        _eventos = data.map((item) => Evento.fromJson(item)).toList();
        notifyListeners();
      } else if (response.statusCode == 401) {
        // Token expirou ou inválido
        throw Exception('Não autorizado. Faça login novamente.');
      } else {
        throw Exception('Erro ${response.statusCode}');
      }
    } catch (e) {
      print("Erro Eventos: $e");
      rethrow;
    }
  }

  Future<void> adicionarEvento(Evento evento) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: headers, // <--- OBRIGATÓRIO
        body: json.encode(evento.toJson()),
      );

      if (response.statusCode == 201) {
        final novo = Evento.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        _eventos.add(novo);
        notifyListeners();
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

  Future<void> atualizarRepertorio(int eventoId, List<int> musicaIds) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl$eventoId/'), // PATCH no ID do evento
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          'repertorio_ids': musicaIds, // Envia a lista de IDs
        }),
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        // Atualiza a lista localmente para refletir a mudança na hora
        await listarEventos();
      } else {
        throw Exception('Falha ao atualizar setlist: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
