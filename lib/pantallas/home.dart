import 'package:flutter/material.dart';
import 'package:gto/config/config.dart';
import 'controles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ControlesState> _controlesKey = GlobalKey<ControlesState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "El Gato",
          style: TextStyle(
            color: Colors.purple, // Cambia el color del texto del título
          ),
        ),
        backgroundColor: Colors.black, // Cambia el color de fondo de la AppBar
        actions: [
          PopupMenuButton<String>(
            color: Colors.black, // Cambia el color de fondo del PopupMenuButton
            onSelected: (value) {
              if (value == "restart") {
                _controlesKey.currentState?.reiniciarJuego();
              } else if (value == "exit") {
                Navigator.pop(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "restart",
                child: Text(
                  "Reiniciar",
                  style: TextStyle(color: Colors.purple), // Cambia el color del texto del MenuItem "Reiniciar"
                ),
              ),
              const PopupMenuItem<String>(
                value: "exit",
                child: Text(
                  "Salir",
                  style: TextStyle(color: Colors.purple), // Cambia el color del texto del MenuItem "Salir"
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.grey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.asset("imagenes/board.png"),
                Controles(key: _controlesKey),
              ],
            ),
          ),
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
