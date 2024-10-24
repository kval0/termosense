import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termosense/Provider/adm/salaprovider.dart';


class ListaAmbientes extends StatefulWidget {
  const ListaAmbientes({super.key});

  @override
  _ListaAmbientesState createState() => _ListaAmbientesState();
}

class _ListaAmbientesState extends State<ListaAmbientes> {
  @override
  void initState() {
    super.initState();
    // Carregar os ambientes ao iniciar a tela
    Provider.of<AmbienteProvider>(context, listen: false).fetchAmbientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambientes'),
        actions: [
          TextButton(onPressed: (){Navigator.pushNamed(context, '/cadsala');}, child: const Text(("Nova Sala")))
        ],
      ),
      body: Consumer<AmbienteProvider>(
        builder: (context, ambienteProvider, child) {
          if (ambienteProvider.ambientes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Expanded(
            child: ListView.builder(
              itemCount: ambienteProvider.ambientes.length,
              itemBuilder: (context, index) {
                final ambiente = ambienteProvider.ambientes[index];
                return ListTile(
                  title: Text(ambiente.nomeAmbiente),
                  subtitle: Text('ID: ${ambiente.idAmbiente}'),
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