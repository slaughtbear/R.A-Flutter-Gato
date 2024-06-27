import 'package:flutter/material.dart';
import 'package:gto/config/config.dart';
import 'controles.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ControlesState> _controlesKey = GlobalKey<ControlesState>();

  int victoriasX = 0;
  int victoriasO = 0;
  int empates = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Color de fondo del AppBar
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset(
                'imagenes/gato.png', // Ruta de la imagen que deseas utilizar como logo
                height: 40, // Altura de la imagen
                width: 40, // Ancho de la imagen
                fit: BoxFit.contain, // Ajuste de la imagen dentro del contenedor
              ),
            ),
            const Text(
              "E l   G a t o",
              style: TextStyle(
                color: Colors.purple, // Cambia el color del texto del título
                fontFamily: 'Kanit', // Usa el nombre de la familia de fuentes definida en pubspec.yaml
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.black, // Color de fondo del PopupMenuButton
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
                Controles(key: _controlesKey, onGameEnd: _actualizarContadoresJuego),
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
                  'Victorias X: $victoriasX',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                ),
                Text(
                  'Victorias O: $victoriasO',
                  style: TextStyle(fontSize: 18.0, color: Colors.pink),
                ),
                Text(
                  'Empates: $empates',
                  style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black, // Color de fondo del BottomAppBar
        child: Container(
          height: 60.0, // Altura del BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.purple), // Icono "refresh" con color morado (purple)
                onPressed: () {
                  _mostrarConfirmacion(context, "¿Reiniciar juego?", "¿Estás seguro que deseas reiniciar el juego?", () {
                    _controlesKey.currentState?.reiniciarJuego();
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app, color: Colors.purple), // Icono "exit_to_app" con color morado (purple)
                onPressed: () {
                  _mostrarConfirmacion(context, "¿Salir de la aplicación?", "¿Estás seguro que deseas salir de la aplicación?", () {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        ),
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

  void _actualizarContadoresJuego(int victoriasCruz, int victoriasCirculo, int empates) {
    setState(() {
      victoriasX = victoriasCruz;
      victoriasO = victoriasCirculo;
      this.empates = empates;
    });
  }
}
