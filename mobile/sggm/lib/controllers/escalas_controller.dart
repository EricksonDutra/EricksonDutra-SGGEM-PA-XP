import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sggm/models/escalas.dart';
import 'package:http/http.dart' as http;

class EscalasProvider extends ChangeNotifier {
  List<Escalas> _escalas = [];
  // final String apiUrl = 'http://127.0.0.1:8000/api/escalas/';
  final String apiUrl = 'http://192.168.100.9:8000/api/escalas/';

  List<Escalas> get escalas => _escalas;

  Future<void> listarEscalas() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _escalas = data.map((item) => Escalas.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar escalas.');
    }
  }

  // Método para adicionar um musico
  Future<void> adicionarEvento(Escalas musico) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(musico.toJson()),
    );
    if (response.statusCode == 201) {
      _escalas.add(musico);
      notifyListeners();
    } else {
      throw Exception('Falha ao adicionar musico');
    }
  }

  // Método para atualizar um musico
  Future<void> atualizarEvento(int id, Escalas novoMusico) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(novoMusico.toJson()),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final index = _escalas.indexWhere((musico) => musico.escalaId == id);
      if (index != -1) {
        _escalas[index] = novoMusico;
        notifyListeners();
      }
    } else {
      throw Exception('Falha ao atualizar musico');
    }
  }

  // Método para deletar um musico
  Future<void> deletarEvento(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl$id/'));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      _escalas.removeWhere((escala) => escala.escalaId == id);
      notifyListeners();
    } else {
      throw Exception('Falha ao deletar musico');
    }
  }
}
