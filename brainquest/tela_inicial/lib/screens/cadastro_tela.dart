import 'package:flutter/material.dart';
import 'package:tela_principal/modules/usuario.dart';
import 'package:tela_principal/widgets/myDialog.dart';

TextEditingController nomeC = TextEditingController();
TextEditingController emailC = TextEditingController();
TextEditingController senhaC = TextEditingController();
TextEditingController matriculaC = TextEditingController();
TextEditingController serieC = TextEditingController();
TextEditingController instituicaoC = TextEditingController();

class CadastroTela extends StatefulWidget {
  const CadastroTela({Key? key}) : super(key: key);

  @override
  State<CadastroTela> createState() => CadastroTelaState();
}

class CadastroTelaState extends State<CadastroTela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 550,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[200],
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nomeC,
                decoration: const InputDecoration(
                  labelText: 'Nome *',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailC,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: senhaC,
                decoration: const InputDecoration(
                  labelText: 'Senha *',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: matriculaC,
                decoration: const InputDecoration(
                  labelText: 'Matrícula *',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: serieC,
                decoration: const InputDecoration(
                  labelText: 'Série *',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: instituicaoC,
                decoration: const InputDecoration(
                  labelText: 'Instituição',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  //_navigateToNextPage(context);
                  signUp(context: context, type: UsuarioType.aluno);
                },
                child: const Text(
                  'Cadastrar Aluno',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  //_navigateToNextPage(context);
                  signUp(context: context, type: UsuarioType.professor);
                },
                child: const Text(
                  'Cadastrar Professor',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void signUp({required BuildContext context, required UsuarioType type}) async {
  if (nomeC.text.isNotEmpty &&
      emailC.text.isNotEmpty &&
      senhaC.text.isNotEmpty &&
      matriculaC.text.isNotEmpty &&
      serieC.text.isNotEmpty) {
    usuarios.add(Usuario(
        nome: nomeC.text,
        email: emailC.text,
        senha: senhaC.text,
        matricula: matriculaC.text,
        serie: serieC.text,
        tipoUsuario: type,
        instituicao: instituicaoC.text));

    await dialog(
      context: context,
      titulo: 'Cadastro bem sucedido!',
    );
  } else {
    await dialog(
        context: context,
        titulo: 'Cadastro inválido!',
        texto: 'Por favor, preencha todos os campos obrigatórios. (*)');
  }
}