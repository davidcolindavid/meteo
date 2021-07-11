import 'package:flutter/material.dart';
import './meteo.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  void _goToMeteo(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MeteoScreen(title: 'Méteo')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenue!',
            ),
            ElevatedButton(
              onPressed: () => _goToMeteo(context),
              child: Text('Entrer')
            )
          ],
        ),
      ),
    );
  }
}
