import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termosense/Models/sala.dart';
import 'package:termosense/Provider/adm/salaprovider.dart';
import 'package:termosense/Utils/mensagem.dart';

class CadastroAmbiente extends StatefulWidget {
  const CadastroAmbiente({super.key});

  @override
  _CadastroAmbienteState createState() => _CadastroAmbienteState();
}

class _CadastroAmbienteState extends State<CadastroAmbiente> {
  final _nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Ambiente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Ambiente'),
            ),
            const SizedBox(height: 20),
             Consumer<AmbienteProvider>(
              builder: (context, salaProvider, child) {
              return salaProvider.carregando ? const CircularProgressIndicator(): ElevatedButton(
              onPressed: () async {
                final ambiente = Ambiente(idAmbiente: 0, nomeAmbiente:  _nomeController.text);
                await salaProvider.cadastrarAmbiente(ambiente);
                if (salaProvider.cadastrado == true ){
                  _nomeController.clear();
                } 
                showMessage( message: salaProvider.menssagem, context: context);
              },
              child: const Text('Cadastrar'),
            );
              }),
          ],
        ),
      ),
    );
  }
}