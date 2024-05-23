import 'package:flutter/material.dart';
import 'package:tela_principal/modules/usuario.dart';
import 'package:tela_principal/screens/cadastro_tela.dart';
import 'package:tela_principal/widgets/myDialog.dart';
import 'package:tela_principal/widgets/social_button.dart';

TextEditingController emsailCLogin = TextEditingController();
TextEditingController senhaCLogin = TextEditingController();

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  void _login(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _register(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CadastroTela()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Login'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          width: 330,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Conectar-se com:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SocialButton(icon: Icons.facebook, color: Colors.blue),
                  SocialButton(icon: Icons.g_mobiledata, color: Colors.red),
                  SocialButton(icon: Icons.apple, color: Colors.black),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailC,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: senhaC,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (emailC.text.isNotEmpty && senhaC.text.isNotEmpty) {
                    
                    if (usuarios
                            .where(
                              (usuario) => usuario.email == emailC.text,
                            ).isNotEmpty) {
                      if (usuarios
                              .where(
                                (usuario) => usuario.email == emailC.text,
                              )
                              .first
                              .senha ==
                          senhaC.text) {
                        _login(context);
                      } else {
                        dialog(
                            context: context,
                            titulo: 'Erro:',
                            texto: 'Senha Incorreta');
                      }
                    } else {
                        dialog(
                          context: context,
                          titulo: 'Erro:',
                          texto: 'Usuário não encontrado');
                    }
                  } else {
                    dialog(
                        context: context,
                        titulo: 'Login Inválido:',
                        texto: 'Preencha o email e a senha.');
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => _register(context),
                child: const Text('Não tem uma conta? Cadastrar-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}