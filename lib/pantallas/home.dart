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
  Widget build(BuildContext context) { // Widget de fondo
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Stack(
          children: [
            Image.asset("imagenes/board.png"),
            Controles()
          ],
        ),
      ),
    );
  }
}
