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
          "E l   G a t o",
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
                _mostrarConfirmacion(context, "¿Reiniciar juego?", "¿Estás seguro que deseas reiniciar el juego?", () {
                  _controlesKey.currentState?.reiniciarJuego();
                });
              } else if (value == "exit") {
                _mostrarConfirmacion(context, "¿Salir de la aplicación?", "¿Estás seguro que deseas salir de la aplicación?", () {
                  Navigator.pop(context);
                });
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

  void _mostrarConfirmacion(BuildContext context, String titulo, String mensaje, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirmar"),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
