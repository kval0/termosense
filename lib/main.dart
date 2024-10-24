import 'package:flutter/material.dart';
import 'package:termosense/Provider/adm/funcprovider.dart';
import 'package:termosense/Provider/adm/salaprovider.dart';
import 'package:termosense/Provider/login/loginuser.dart';
import 'package:termosense/pages/usuario/cadastro.dart';
import 'package:termosense/pages/admin/cadastrofunc.dart';
import 'package:termosense/pages/admin/listfunc.dart';
import 'package:termosense/pages/admin/salaadmin.dart';
import 'package:termosense/pages/homepage.dart';
import 'package:termosense/pages/login.dart';
import 'package:termosense/pages/usuario/cadsala.dart';
import 'package:termosense/pages/usuario/cadusuario.dart';
import 'package:termosense/pages/usuario/listsala.dart';
import 'package:termosense/pages/usuario/sala.dart';
import 'package:provider/provider.dart';

void main () {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Logar()),
      ChangeNotifierProvider(create: (_) => AmbienteProvider()),
      ChangeNotifierProvider(create: (_) => FuncionarioProvider()),
    ],
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Homepage(),
        '/login': (context) => const Login(),
        '/salas': (context) => const Sala(),
        '/cadastro': (context) => const Cadastro(),
        '/salaadmin': (context) => const SalaAdmin(),
        '/cadsala': (context) => const  CadastroAmbiente(),
        '/listarambiente': (context) => const  ListaAmbientes(),
        '/cadfunc': (context) => const CadastroFunc(),
        '/listafunc': (context) => const ListaFuncionarios(),
        '/caduser': (context) => const CadUser()
      },
      debugShowCheckedModeBanner: false,
    ),
  ));
} 