import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termosense/Provider/adm/funcprovider.dart';

class ListaFuncionarios extends StatefulWidget {
  const ListaFuncionarios({super.key});

  @override
  State<ListaFuncionarios> createState() => _ListaFuncionariosState();
}

class _ListaFuncionariosState extends State<ListaFuncionarios> {

 @override
  void initState() {
    super.initState();
    Provider.of<FuncionarioProvider>(context, listen: false).fetchFuncionarios();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários Cadastrados'),
      ),
      body: Consumer<FuncionarioProvider>(
        builder: (context, funcionariop, child) {
          if (funcionariop.funcionarios.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Expanded(
            child: ListView.builder(
              itemCount: funcionariop.funcionarios.length,
              itemBuilder: (context, index) {
                final funcionario = funcionariop.funcionarios[index];
                return ListTile(
                  title: Text(funcionario.nomeUsuario),
                  subtitle: Text('ID: ${funcionario.idFunc}'),
                  trailing:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
                    ],
                  )
                );
              },
            ),
          );
        },
      ),
    );
  }
}
