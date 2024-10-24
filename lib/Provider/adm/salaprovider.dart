import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:termosense/Models/sala.dart';
import 'package:http/http.dart' as http;

class AmbienteProvider with ChangeNotifier {


  bool _cadastrado = false;
  bool get cadastrado => _cadastrado;

  bool _carregando = false;
  bool get carregando => _carregando;

  String _menssagem = "";
  String get menssagem => _menssagem;

  List<Ambiente> _ambientes = [];

  List<Ambiente> get ambientes => _ambientes;

  String? token;

Future<void> pegarToken() async {
    _carregando = true;
    var dados = await SharedPreferences.getInstance();
    token = dados.getString("token");
}

  
  Future<void> cadastrarAmbiente(Ambiente ambiente) async {
    const url = 'https://temmaxima.azurewebsites.net/api/Ambiente';
    
    try {
      await pegarToken();
      final response = await http.post(
        Uri.parse(url),
        headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
        body: json.encode(ambiente.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
         _cadastrado = true;
         _carregando = false;
         _menssagem = "Sala Cadastrada com sucesso!";
        notifyListeners();
      } else {
        _cadastrado = false;
         _carregando = false;
         _menssagem = "Erro ao cadastrar Sala!";
         notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

   Future<void> fetchAmbientes() async {
    const url = 'https://temmaxima.azurewebsites.net/api/Ambiente';
    
    try {
      await pegarToken();
      final response = await http.get(Uri.parse(url),
       headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _ambientes = data.map((json) => Ambiente.fromJson(json)).toList();
         _carregando = false;
        notifyListeners();
      } else {
        _carregando = false;
         notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }
}
