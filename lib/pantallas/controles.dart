import 'package:flutter/material.dart';
import 'package:gto/config/config.dart';

import '../widget/celda.dart';

class Controles extends StatefulWidget {
  final Function(int, int, int) onGameEnd;

  const Controles({Key? key, required this.onGameEnd}) : super(key: key);

  @override
  State<Controles> createState() => ControlesState();
}

class ControlesState extends State<Controles> {
  estados inicial = estados.cruz;
  int contador = 0;
  int victoriasCruz = 0;
  int victoriasCirculo = 0;
  int empates = 0;

  List<estados> tablero = List.filled(9, estados.vacio);

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
        ],
      ),
    );
  }

  void pressi(int index, BuildContext context) {
    debugPrint("Presionado");
    if (tablero[index] == estados.vacio) {
      setState(() {
        tablero[index] = inicial;
        contador++;
      });

      bool hayGanador = false;
      if (contador >= 5) {
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
      }

      if (hayGanador) {
        if (tablero[index] == estados.cruz) {
          victoriasCruz++;
        } else {
          victoriasCirculo++;
        }
        // Mostrar mensaje de victoria y reiniciar el juego después de un tiempo
        _mostrarMensajeVictoria(context, "¡Ganó ${tablero[index] == estados.cruz ? 'X' : 'O'}!");
      } else if (contador == 9) {
        // Empate
        empates++;
        // Mostrar mensaje de empate y reiniciar el juego después de un tiempo
        _mostrarMensajeEmpate(context, "¡Empate!");
      } else {
        setState(() {
          inicial = inicial == estados.cruz ? estados.circulo : estados.cruz;
        });
      }
    }
  }

  bool Iguales(int a, int b, int c) {
    if (tablero[a]!= estados.vacio &&
        tablero[a] == tablero[b] &&
        tablero[a] == tablero[c]) {
      return true;
    }
    return false;
  }

  void _mostrarMensajeVictoria(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¡Partida terminada!"),
          content: Text(mensaje),
          actions: [
            TextButton(
              child: Text("Aceptar"),
              onPressed: () {
                widget.onGameEnd(victoriasCruz, victoriasCirculo, empates);
                reiniciarJuego();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _mostrarMensajeEmpate(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¡Partida terminada!"),
          content: Text(mensaje),
          actions: [
            TextButton(
              child: Text("Aceptar"),
              onPressed: () {
                widget.onGameEnd(victoriasCruz, victoriasCirculo, empates);
                reiniciarJuego();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void reiniciarJuego() {
    setState(() {
      for (int i = 0; i < tablero.length; i++) {
        tablero[i] = estados.vacio;
      }
      inicial = estados.cruz;
      contador = 0;
    });
  }
}