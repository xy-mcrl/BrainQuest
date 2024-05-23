import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
  Gemini.init(
    apiKey: "AIzaSyDr5iK4v-g46nJNkPH6jMydtadWzEOOM_w",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RedacaoTela(),
    );
  }
}

class RedacaoTela extends StatefulWidget {
  @override
  _RedacaoScreenState createState() => _RedacaoScreenState();
}

NotaFinal _resultadoCorrecao = NotaFinal(total: '0', c1: '0', c2: '0', c3: '0', c4: '0', c5: '0');

class _RedacaoScreenState extends State<RedacaoTela> {
  TextEditingController _redacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redação'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Fundo mais claro
                borderRadius: BorderRadius.circular(12), // Cantos arredondados
              ),
              padding: const EdgeInsets.all(12.0),
              height: MediaQuery.of(context).size.height - 160,
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: _redacaoController,
                maxLines: 33, // Limite de linhas definido para 33
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Digite sua redação aqui',
                ),
              ),
            ), // Ajuste de altura entre a caixa de texto e o botão
            SizedBox(
              width: 50, // Definindo um tamanho menor para o botão
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  var resultado = await corrigirRedacao(_redacaoController.text);
                  setState(() {
                    _resultadoCorrecao = resultado;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultadoScreen(
                        textoCorrigido: _resultadoCorrecao,
                      ),
                    ),
                  );
                },
                child: Text('Corrigir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultadoScreen extends StatefulWidget {
  final NotaFinal textoCorrigido;

  const ResultadoScreen({Key? key, required this.textoCorrigido}) : super(key: key);

  @override
  State<ResultadoScreen> createState() => _ResultadoScreenState();
}

class _ResultadoScreenState extends State<ResultadoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft, // Alinhamento na parte superior esquerda
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: Colors.lightGreen[200],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Correção:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Competência 1: ${widget.textoCorrigido.c1}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Competência 2: ${widget.textoCorrigido.c2}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Competência 3: ${widget.textoCorrigido.c3}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Competência 4: ${widget.textoCorrigido.c4}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Competência 5: ${widget.textoCorrigido.c5}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Total: ${widget.textoCorrigido.total}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class NotaFinal {
  String total, c1, c2, c3, c4, c5;
  NotaFinal({required this.total, required this.c1, required this.c2, required this.c3, required this.c4, required this.c5});

  String getNotas() {
    return 'C1: $c1, C2: $c2, C3: $c3, C4: $c4, C5: $c5';
  }

  String getTotal() {
    return 'Total: $total';
  }
}

Future<NotaFinal> corrigirRedacao(String texto) async {
  try {
    const mensagemFixa =
        "Corrija esta redação utilizando as 5 competências avaliativas do Enem: "
        "competência 1. Demonstrar domínio da escrita formal em língua portuguesa; "
        "competência 2. Compreender a proposta de redação e aplicar conceitos de diversas áreas do conhecimento, dentro da estrutura do texto dissertativo-argumentativo; "
        "competência 3. Selecionar, relacionar, organizar e interpretar informações, fatos, opiniões e argumentos em defesa de um ponto de vista; "
        "competência 4. Demonstrar conhecimento dos mecanismos linguísticos necessários para a construção da argumentação; "
        "competência 5. Elaborar uma proposta de intervenção para o problema abordado, respeitando os direitos humanos. "
        "(cada competência vai de: 0 a 200 pontos, totalizando uma nota máxima de 1000. "
        "Retorne a pontuação por competência e o total.)"
        "Modelo de Resultado: Competência 1: 0 a 200; Competência 2: 0 a 200; Competência 3: 0 a 200, Competência 4: 0 a 200, Competência 5: 0 a 200, Resultado Total: 0 a 1000"
        "Coloque apenas as competências e suas devidas notas e o resultado final da redação, no formato [Total (notaTotal) ,C1 (nota1), C2 (nota2), etc.] :";

    final redacaoParaCorrecao = "$texto \n\n$mensagemFixa";

    // Movendo a inicialização do Gemini para dentro da função corrigirRedacao
    await Gemini.init(apiKey: "AIzaSyDr5iK4v-g46nJNkPH6jMydtadWzEOOM_w");
    final gemini = Gemini.instance;
    
    final rawResults = await gemini.streamGenerateContent(redacaoParaCorrecao).toList();
    
    var resultsList = [];

    rawResults.forEach((elm) {
      resultsList.add(elm.content!.parts!.first.text!.trim());
    });

    var processResults = resultsList.toString().split('C');
    var results = [];

    for (var r in processResults) {
      var my = r.split('(')[r.split('(').length - 1].split(')')[0];
      results.add(my);
    }

    NotaFinal minhaNota = NotaFinal(
      total: results[0],
      c1: results[1],
      c2: results[2],
      c3: results[3],
      c4: results[4],
      c5: results[5]
    );

    return minhaNota;

  } catch (e) {
    print('Erro ao corrigir redação: $e');
    return NotaFinal(total: '0', c1: '0', c2: '0', c3: '0', c4: '0', c5: '0');
  }
}