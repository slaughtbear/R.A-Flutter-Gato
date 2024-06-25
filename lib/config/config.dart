import 'package:flutter/material.dart';

enum estados { vacio, cruz, circulo }

List<estados> tablero = List.filled(9, estados.vacio);
int victoriasCruz = 0;
int victoriasCirculo = 0;
int empates = 0;

void reiniciarResultados() {
  victoriasCruz = 0;
  victoriasCirculo = 0;
  empates = 0;
}

Map<estados, bool> resultados = {estados.cruz: false, estados.circulo: false};
