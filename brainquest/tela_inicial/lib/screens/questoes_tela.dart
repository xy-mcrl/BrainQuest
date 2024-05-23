import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: QuestoesTela(),
  ));
}

class QuestoesTela extends StatelessWidget {
  // Definindo o estilo de texto comum para todas as entradas
  final TextStyle _textStyle = TextStyle(
    color: Colors.white,
    fontSize: 26,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questões'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildButton(
              label: 'Matemática',
              color: Colors.blue,
              url: 'https://www.mesalva.com/app/conteudos/enem2020mat165?contexto=exercicios-e-provas%2Fexercicios-matematica&lista=KGEF4F9Hb2cD8YYWvGrVXjvP&modulo=GhMmi1tF416quoh8QyYEk9zg',
            ),
            _buildButton(
              label: 'Biologia',
              color: Colors.green,
              url: 'https://www.mesalva.com/app/exercicios-e-provas/exercicios-biologia',
            ),
            _buildButton(
              label: 'Química',
              color: Colors.red,
              url: 'https://www.mesalva.com/app/exercicios-e-provas/exercicios-quimica',
            ),
            _buildButton(
              label: 'Filosofia',
              color: Colors.purple,
              url: 'https://www.mesalva.com/app/exercicios-e-provas/exercicios-filosofia',
            ),
            _buildButton(
              label: 'História',
              color: Colors.orange,
              url: 'https://www.mesalva.com/app/exercicios-e-provas/exercicios-historia',
            ),
             _buildButton(
              label: 'Língua Portuguesa',
              color: Color.fromARGB(255, 239, 66, 94),
              url: 'https://www.mesalva.com/app/exercicios-e-provas/exercicios-portugues',
            ),
            _buildButton(
              label: 'Inglês',
              color: Color.fromARGB(255, 32, 222, 219),
              url: 'https://www.mesalva.com/app/exercicios-e-provas/exercicios-ingles',
            ),
            _buildButton(
              label: 'Literatura',
              color: Color.fromARGB(255, 74, 231, 142),
              url: 'https://www.mesalva.com/app/exercicios-e-provas/exercicios-literatura',
            ),
            _buildButton(
              label: 'Humanas',
              color: Color.fromARGB(255, 221, 248, 14),
              url: 'https://www.mesalva.com/app/exercicios-e-provas/exercicios-humanas',
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir um botão com base nos parâmetros fornecidos
  Widget _buildButton({required String label, required Color color, required String url}) {
    return InkWell(
      onTap: () {
        _launchURL(url);
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: _textStyle, // Utilizando o estilo de texto definido anteriormente
          ),
        ),
      ),
    );
  }

  // Função para lançar uma URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o link $url';
    }
  }
}
