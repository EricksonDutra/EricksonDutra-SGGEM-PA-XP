import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sggm/models/musicos.dart';
import 'package:http/http.dart' as http;

class MusicosProvider extends ChangeNotifier {
  List<Musicos> _musicos = [];
  // final String apiUrl = 'http://127.0.0.1:8000/api/musicos/';
  final String apiUrl = 'http://192.168.100.9:8000/api/musicos/';

  List<Musicos> get musicos => _musicos;

  Future<void> listarMusicos() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _musicos = data.map((item) => Musicos.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar músicos.');
    }
  }

  // Método para adicionar um musico
  Future<void> adicionarEvento(Musicos musico) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(musico.toJson()),
    );
    if (response.statusCode == 201) {
      _musicos.add(musico);
      notifyListeners();
    } else {
      throw Exception('Falha ao adicionar musico');
    }
  }

  // Método para atualizar um musico
  Future<void> atualizarEvento(int id, Musicos novoMusico) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(novoMusico.toJson()),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final index = _musicos.indexWhere((musico) => musico.musicoId == id);
      if (index != -1) {
        _musicos[index] = novoMusico;
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
      _musicos.removeWhere((musico) => musico.musicoId == id);
      notifyListeners();
    } else {
      throw Exception('Falha ao deletar musico');
    }
  }
}
