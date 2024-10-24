import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:termosense/Models/func.dart';
import 'package:http/http.dart' as http;

class FuncionarioProvider with ChangeNotifier {
  bool _cadastrado = false;
  bool get cadastrado => _cadastrado;

  bool _carregando = false;
  bool get carregando => _carregando;

  String _menssagem = "";
  String get menssagem => _menssagem;

  List<Funcionario> _funcionarios = [];
  List<Funcionario> get funcionarios => _funcionarios;

  String? token;

  Future<void> pegarToken() async {
    var dados = await SharedPreferences.getInstance();
    token = dados.getString("token");
  }

  Future<void> cadastrarFuncionario(Funcionario funcionario) async {
    const url = 'https://temmaxima.azurewebsites.net/api/Funcionario';

    try {
      await pegarToken();
      _carregando = true; // Iniciar o carregamento
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(funcionario.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _cadastrado = true;
        _menssagem = "Funcionário cadastrado com sucesso!";
        await fetchFuncionarios(); // Atualiza a lista de funcionários após o cadastro
      } else {
        _cadastrado = false;
        _menssagem = "Erro ao cadastrar funcionário: ${response.body}";
      }
    } catch (error) {
      _cadastrado = false;
      _menssagem = "Erro ao cadastrar funcionário: $error";
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> fetchFuncionarios() async {
    const url = 'https://temmaxima.azurewebsites.net/api/Funcionario';

    try {
      await pegarToken();
      _carregando = true; 
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

  
    
      if (response.statusCode == 200) {
       
        final List<dynamic> data = json.decode(response.body);
     
        _funcionarios = data.map((json) => Funcionario.fromJson(json)).toList();
      } else {
        _menssagem = "Erro ao buscar funcionários: ${response.body}";
      }
    } catch (error) {
      _menssagem = "Erro ao buscar funcionários: $error";
    } finally {
      _carregando = false; // Parar o carregamento no final
      notifyListeners();
    }
  }
}

