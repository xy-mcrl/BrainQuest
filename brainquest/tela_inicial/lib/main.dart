import 'package:flutter/material.dart';
import 'package:tela_principal/screens/app_tela.dart';
import 'package:tela_principal/screens/cronograma_tela.dart';
import 'package:tela_principal/screens/cronometro_tela.dart';
import 'package:tela_principal/screens/enem_tela.dart';
import 'package:tela_principal/screens/login.dart';
import 'package:tela_principal/screens/metodo_estudo_tela.dart';
import 'package:tela_principal/screens/questoes_tela.dart';
import 'package:tela_principal/screens/redacao_tela.dart';
import 'widgets/grid_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainQuest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Login(),
      routes: {
        '/home': (context) => const HomePage(),
        '/metodos': (context) => MetodoEstudoTela(),
        '/cronometro': (context) => CronometroTela(),
        '/provasenem' : (context) => EnemTela (),
        '/questoes': (context) => QuestoesTela(),
        '/cronograma': (context) => CronogramaTela(),
        '/redacao': (context) => RedacaoTela (),
        '/apps': (context) => AppTela(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BrainQuest'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: null,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 189, 245, 176),
              ),
            ),
            ListTile(
              leading: Icon(Icons.menu_book), // Adicione o ícone aqui
              title: const Text('Métodos de Estudo'),
              onTap: () {
                Navigator.pushNamed(context, '/metodos');
              },
            ),
            ListTile(
              leading: Icon(Icons.timer), // Adicione o ícone aqui
              title: const Text('Cronômetro'),
              onTap: () {
                Navigator.pushNamed(context, '/cronometro');
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment), // Adicione o ícone aqui
              title: const Text('Provas ENEM'),
              onTap: () {
                Navigator.pushNamed(context, '/provasenem');
              },
            ),
            ListTile(
              leading: Icon(Icons.help), // Adicione o ícone aqui
              title: const Text('Questões'),
              onTap: () {
                Navigator.pushNamed(context, '/questoes');
              },
            ),
            ListTile(
              leading: Icon(Icons.event), // Adicione o ícone aqui
              title: const Text('Cronograma de Estudos'),
              onTap: () {
                Navigator.pushNamed(context, '/cronograma');
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.reduce_capacity_outlined), // Adicione o ícone aqui
              title: const Text('Redação'),
              onTap: () {
                Navigator.pushNamed(context, '/redacao');
              },
            ),
            ListTile(
              leading: Icon(Icons.apps), // Adicione o ícone aqui
              title: const Text('Aplicativos'),
              onTap: () {
                Navigator.pushNamed(context, '/apps');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: GridView.count( 
          mainAxisSpacing: 10,
          crossAxisSpacing: 100,
          crossAxisCount: 4,
          children: <Widget>[
            GridItem(
              name: 'Métodos de Estudo',
              image: '../images/fotos_menu/metodos.png',
              route: '/metodos',
            ),
            GridItem(
              name: 'Cronômetro',
              image: '../images/fotos_menu/cronometro.png',
              route: '/cronometro',
            ),
            GridItem(
              name: 'Provas Enem',
              image: '../images/fotos_menu/enem.png',
              route: '/provasenem',
            ),
            GridItem(
              name: 'Questões',
              image: '../images/fotos_menu/questoes.png',
              route: '/questoes',
            ),
            GridItem(
              name: 'Cronograma de Estudos',
              image: '../images/fotos_menu/cronograma.png',
              route: '/cronograma',
            ),
            GridItem(
              name: 'Redação',
              image: '../images/fotos_menu/redacao.png',
              route: '/redacao',
            ),
            GridItem(
              name: 'Aplicativo',
              image: '../images/fotos_menu/apps.png',
              route: '/apps',
            ),
          ],
        ),
      ),
    );
  }
}