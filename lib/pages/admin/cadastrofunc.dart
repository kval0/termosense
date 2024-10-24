import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termosense/Models/func.dart';
import 'package:termosense/Provider/adm/funcprovider.dart';

class CadastroFunc extends StatefulWidget {
  const CadastroFunc({super.key});

  @override
  _CadastroFuncState createState() => _CadastroFuncState();
}

class _CadastroFuncState extends State<CadastroFunc> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Funcionário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CPF';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final funcionario = Funcionario(
                      idFunc: 0, // Defina um ID se necessário
                      nomeUsuario: _nomeController.text,
                      email: _emailController.text,
                      senha: _senhaController.text,
                      cpf: _cpfController.text,
                      adm: false, // Ajuste conforme necessário
                    );

                    final provider = Provider.of<FuncionarioProvider>(context, listen: false);
                    await provider.cadastrarFuncionario(funcionario);

                    // Exibe um SnackBar com a mensagem de feedback
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(provider.menssagem)),
                    );

                    // Limpa os campos após o cadastro
                    _nomeController.clear();
                    _emailController.clear();
                    _senhaController.clear();
                    _cpfController.clear();

                    // Navega para a tela de lista de funcionários
                    Navigator.pushReplacementNamed(context, '/listafunc');
                  }
                },
                child: const Text('Cadastrar Funcionário'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
