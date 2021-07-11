import 'package:flutter/material.dart';
import 'dart:async';
import '../api/meteo.dart';

class MeteoScreen extends StatefulWidget {
  MeteoScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MeteoScreenState createState() => _MeteoScreenState();
}

class _MeteoScreenState extends State<MeteoScreen> {
  double _progress = 0;
  int maxSeconds = 60;
  late Future rennes;
  late Future paris;
  late Future nantes;
  late Future bordeaux;
  late Future lyon;
  List townsList = [];
  List waitingMessages = [
    'Nous téléchargeons les données...',
    'C\'est presque fini...',
    'Plus que quelques secondes avant d\'avoir le résultat'
  ];
  late String currentWaitingMessages;

  void reset() {
    setState(() {
      townsList = [];
      currentWaitingMessages = waitingMessages[0];
      _progress = 1;
    });
  }

  void startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_progress == maxSeconds) {
            townsList.addAll([rennes, paris, nantes, bordeaux, lyon]);
            return timer.cancel();
          }

          /// fetch data
          if (_progress == 0)
            rennes = MeteoApi.getMeteo('rennes');
          if (_progress == 0)
            paris = MeteoApi.getMeteo('paris');
          if (_progress == 0)
            nantes = MeteoApi.getMeteo('nantes');
          if (_progress == 0)
            bordeaux = MeteoApi.getMeteo('bordeaux');
          if (_progress == 0)
            lyon = MeteoApi.getMeteo('lyon');

          /// update waiting message
          var remainder = _progress % 6;
          if (remainder == 0) {
            for (var i = 0; i < waitingMessages.length; i++) {
              if (_progress == 0) break;
              if (waitingMessages[i] == currentWaitingMessages) {
                setState(() {
                  currentWaitingMessages = i == waitingMessages.length - 1
                    ? waitingMessages[0]
                    : waitingMessages[i + 1];
                });
                break;
              }
            }
          }

          _progress += 1;
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    currentWaitingMessages = waitingMessages[0];
    super.initState();
  }

  Widget getMeteo() {
    if (_progress == maxSeconds) {
      return Column(children: 
        townsList.map((town) => 
          FutureBuilder(
            future: town,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(snapshot.data.name),
                    Text(snapshot.data.main.temp.toString()),
                  ]
                );
              }
              return Container();
            }
          ), 
        ).toList()
      );
    }

    return Text(currentWaitingMessages);
  }

  Widget getLoading() {
    if (_progress == maxSeconds) {
      return Center(child: ElevatedButton(
        onPressed: () {
          reset();
          startTimer();
        },
        child: Text('Recommencer')
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: LinearProgressIndicator(
          backgroundColor: Colors.cyanAccent,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          value: _progress * (100 / maxSeconds) / 100
        )),
        Text((_progress * (100 / maxSeconds)).toInt().toString() + '%')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(child: getMeteo()),
            Column(
              children: [
                Text('Chargement de votre météo'),
                SafeArea(child: getLoading())
              ]
            ),
          ]
        )
      )
    );
  }
}
