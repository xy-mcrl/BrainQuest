import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: AppTela(),
  ));
}

class AppTela extends StatelessWidget {
  // Definindo o estilo de texto comum para todas as entradas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App e Sites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildImageButton(
              imageAsset: '../images/fotos_app/quizlet.png',
              url: 'https://quizlet.com/br',
            ),
            _buildImageButton(
              imageAsset: '../images/fotos_app/floresta.png',
              url: 'https://www.forestapp.cc/',
            ),
            _buildImageButton(
              imageAsset: '../images/fotos_app/khan.png',
              url: 'https://pt.khanacademy.org/',
            ),
            _buildImageButton(
              imageAsset: '../images/fotos_app/aprovado.jpeg',
              url: 'https://aprovadoapp.com/',
            ),
            _buildImageButton(
              imageAsset: '../images/fotos_app/lexilize.jpeg',
              url: 'https://lexilize.com/',
            ),
            _buildImageButton(
              imageAsset: '../images/fotos_app/trello.png',
              url: 'https://trello.com/home',
            ),
            // Adicione mais imagens com links conforme necessário
          ],
        ),
      ),
    );
  }

  // Método para construir um botão de imagem com base nos parâmetros fornecidos
  Widget _buildImageButton({required String imageAsset, required String url}) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(
          imageAsset,
          fit: BoxFit.cover,
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
