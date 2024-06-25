import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:gto/config/config.dart';
import 'package:gto/widget/celda.dart';

class Controles extends StatefulWidget {
  const Controles({super.key});

  @override
  State<Controles> createState() => _ControlesState();
}

class _ControlesState extends State<Controles> {
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
                    press: () => pressi(0)),
                Celda(
                    inicial: tablero[1],
                    alto: ancho / 3,
                    ancho: ancho / 3,
                    press: () => pressi(1)),
                Celda(
                    inicial: tablero[2],
                    alto: ancho / 3,
                    ancho: ancho / 3,
                    press: () => pressi(2))
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
                    press: () => pressi(3)),
                Celda(
                    inicial: tablero[4],
                    alto: ancho / 3,
                    ancho: ancho / 3,
                    press: () => pressi(4)),
                Celda(
                    inicial: tablero[5],
                    alto: ancho / 3,
                    ancho: ancho / 3,
                    press: () => pressi(5))
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
                    press: () => pressi(6)),
                Celda(
                    inicial: tablero[7],
                    alto: ancho / 3,
                    ancho: ancho / 3,
                    press: () => pressi(7)),
                Celda(
                    inicial: tablero[8],
                    alto: ancho / 3,
                    ancho: ancho / 3,
                    press: () => pressi(8))
              ],
            ),
          ),
          const Text(
            'Ejemplo de texto con fuente personalizada',
            style: TextStyle(
              fontFamily:
              'Kanit', // Nombre de la fuente definido en pubspec.yaml
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void pressi(int index) {
    debugPrint("Presionado");
    if (tablero[index] == estados.vacio) {
      setState(() {
        tablero[index] = inicial;
        inicial = inicial == estados.cruz ? estados.circulo : estados.cruz;
        contador++;
      });

      // Verificar si alguien ganó
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

      // Si hay un ganador, mostrar el mensaje y reiniciar
      if (hayGanador) {
        mostrarMensaje(context, "¡Ganador!", "¡${inicial == estados.cruz ? 'O' : 'X'} ha ganado!");
      } else if (contador == 9) {
        // Si no hay ganador y contador llega a 9, es empate
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
      barrierDismissible: false, // Evita cerrar el dialogo al tocar fuera de él
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: const Text("Continuar"),
              onPressed: () {
                reiniciarJuego();
                Navigator.of(context).pop(); // Cierra el dialogo
              },
            ),
            TextButton(
              child: const Text("Salir"),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el dialogo
                Navigator.of(context).pop(); // Cierra la aplicación
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
