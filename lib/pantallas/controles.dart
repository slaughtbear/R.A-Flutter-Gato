import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gto/config/config.dart';
import 'package:gto/widget/celda.dart';

class Controles extends StatefulWidget {
  const Controles({super.key});

  @override
  State<Controles> createState() => ControlesState();
}

class ControlesState extends State<Controles> {
  estados inicial = estados.cruz;
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    double ancho, alto;
    ancho = MediaQuery.of(context).size.width;
    alto = MediaQuery.of(context).size.height;

    return SizedBox(
      width: ancho,
      height: ancho,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Celda(
                  inicial: tablero[0],
                  alto: ancho / 3,
                  ancho: ancho / 3,
                  press: () => pressi(0, context),
                ),
                Celda(
                  inicial: tablero[1],
                  alto: ancho / 3,
                  ancho: ancho / 3,
                  press: () => pressi(1, context),
                ),
                Celda(
                  inicial: tablero[2],
                  alto: ancho / 3,
                  ancho: ancho / 3,
                  press: () => pressi(2, context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Celda(
                  inicial: tablero[3],
                  alto: ancho / 3,
                  ancho: ancho / 3,
                  press: () => pressi(3, context),
                ),
                Celda(
                  inicial: tablero[4],
                  alto: ancho / 3,
                  ancho: ancho / 3,
                  press: () => pressi(4, context),
                ),
                Celda(
                  inicial: tablero[5],
                  alto: ancho / 3,
                  ancho: ancho / 3,
                  press: () => pressi(5, context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Celda(
                  inicial: tablero[6],
                  alto: ancho / 3,
                  ancho: ancho / 3,
                  press: () => pressi(6, context),
                ),
                Celda(
                  inicial: tablero[7],
                  alto: ancho / 3,
                  ancho: ancho / 3,
                  press: () => pressi(7, context),
                ),
                Celda(
                  inicial: tablero[8],
                  alto: ancho / 3,
                  ancho: ancho / 3,
                  press: () => pressi(8, context),
                ),
              ],
            ),
          ),
          const Text(
            'Ejemplo de texto con fuente personalizada',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void pressi(int index, BuildContext context) {
    debugPrint("Presionado");
    if (tablero[index] == estados.vacio) {
      setState(() {
        tablero[index] = inicial;
        inicial = inicial == estados.cruz ? estados.circulo : estados.cruz;
        contador++;
      });

      bool hayGanador = false;
      for (int i = 0; i < tablero.length; i += 3) {
        if (Iguales(i, i + 1, i + 2)) {
          hayGanador = true;
          break;
        }
      }
      for (int i = 0; i < 3; i++) {
        if (Iguales(i, i + 3, i + 6)) {
          hayGanador = true;
          break;
        }
      }
      if (Iguales(0, 4, 8) || Iguales(2, 4, 6)) {
        hayGanador = true;
      }

      if (hayGanador) {
        mostrarMensaje(context, "¡Ganador!", "¡${inicial == estados.cruz ? 'O' : 'X'} ha ganado!");
      } else if (contador == 9) {
        mostrarMensaje(context, "Empate", "¡El juego ha terminado en empate!");
      }
    }
  }

  bool Iguales(int a, int b, int c) {
    if (tablero[a] != estados.vacio) {
      if (tablero[a] == tablero[b] && tablero[b] == tablero[c]) {
        resultados[tablero[a]] = true;
        return true;
      }
    }
    return false;
  }

  void mostrarMensaje(BuildContext context, String titulo, String mensaje) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: const Text("Continuar"),
              onPressed: () {
                reiniciarJuego();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Salir"),
              onPressed: () {
                Navigator.of(context).pop();
                salirDeLaAplicacion();
              },
            ),
          ],
        );
      },
    );
  }

  void reiniciarJuego() {
    setState(() {
      tablero = List.filled(9, estados.vacio);
      resultados = {estados.cruz: false, estados.circulo: false};
      inicial = estados.cruz;
      contador = 0;
    });
  }
}

void salirDeLaAplicacion() {
  SystemNavigator.pop();
}
