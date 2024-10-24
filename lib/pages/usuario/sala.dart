import 'package:flutter/material.dart';
import 'package:termosense/DataUser/saladados.dart';
import 'package:termosense/style/colors.dart';

class Sala extends StatefulWidget {
  const Sala({super.key});

  @override
  State<Sala> createState() => _SalaState();
}

class _SalaState extends State<Sala> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.branco,
        appBar: AppBar(
          backgroundColor: AppColors.branco,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/icon.png'),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: salas.length,
                itemBuilder: (context, index) {
                  final sala = salas[index];
                  return ListTile(
                    title: Text('Sala: ${sala['sala']}'),
                    subtitle: Text('Temperatura: ${sala['temperatura']}°C'),
                  );
                },
              ),
            ),
             ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/listarambiente');
                },
                child: const Text('Cadastrar sala'))
          ],
        ));
  }
}

// Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             const Text(
//               'Salas',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontFamily: 'inter18',
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.azulTitulo,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, 'sala1');
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.zero,
//                 backgroundColor: Colors.transparent,
//                 fixedSize: const Size(150, 150),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ).copyWith(
//                 backgroundColor: WidgetStateProperty.all(Colors.transparent),
//               ),
//               child: Ink(
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [AppColors.azulDegrade2, AppColors.azulDegrade1],
//                     begin: Alignment.topRight,
//                     end: Alignment.bottomLeft,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Container(
//                   alignment: Alignment.center,
//                   child: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       'Sala 1',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),