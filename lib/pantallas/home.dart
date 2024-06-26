import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'controles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Contenido principal
          Expanded(
            child: Stack(
              children: [
                Image.asset("imagenes/board.png"),
                Controles(),
              ],
            ),
          ),
          // Widget de contadores
          Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Victorias X: 0',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                ),
                Text(
                  'Victorias O: 0',
                  style: TextStyle(fontSize: 18.0, color: Colors.pink),
                ),
                Text(
                  'Empates: 0',
                  style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
