import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import necessário para usar o input formatter
import 'package:provider/provider.dart';
import 'package:termosense/Provider/login/loginuser.dart';
import 'package:termosense/Utils/mensagem.dart';
import 'package:termosense/style/colors.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  bool isObscured = true;
  bool stayConnected = false;

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
      body: SafeArea(
        // Envolve toda a estrutura com o SafeArea
        child: SingleChildScrollView(
          // Adiciona rolagem ao conteúdo
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Consumer<Logar>(builder: (context, confirmUser, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinhar os itens à esquerda
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Cadastro',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.azulTitulo,
                    ),
                  ),
                  const SizedBox(height: 80),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: null,
                      filled: true,
                      fillColor: AppColors.branco,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _cpfController,
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                      border: null,
                      filled: true,
                      fillColor: AppColors.branco,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _senhaController,
                    obscureText: isObscured,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: null,
                      filled: true,
                      fillColor: AppColors.branco,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    obscureText: isObscured,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Senha',
                      border: null,
                      filled: true,
                      fillColor: AppColors.branco,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        value: stayConnected,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        onChanged: (bool? value) {
                          setState(() {
                            stayConnected = value!;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text('Continuar Conectado'),
                    ],
                  ),
                  const SizedBox(height: 70),
                  SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Color.fromARGB(255, 75, 162, 255),
                            AppColors.azulDegrade1,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          await confirmUser.confirmarUsuario(_emailController.text, _senhaController.text, _cpfController.text);
                          if (confirmUser.criado == true){
                            showMessage(message: confirmUser.msgError, context: context);
                            Navigator.of(context).pushNamed('/login');
                          } else {
                            showMessage(message: confirmUser.msgError, context: context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Cadastro',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
