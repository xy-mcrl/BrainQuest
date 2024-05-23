
import 'package:flutter/material.dart';

Future<void> dialog(
    {required BuildContext context,
    String titulo = '',
    String texto = ''}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(texto),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  ).then((value) => null);
}
