import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String titulo;
  final String descricao;

  Slide({
    @required this.imageUrl,
    @required this.titulo,
    @required this.descricao,
  });
}

final slideList = [
  Slide(
    imageUrl: 'imagens/01.png',
    titulo: 'A Cool Way to Get Start',
    descricao: ' Donec dapibus tincidunt bibendum. Maecenas porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: 'imagens/02.jpg',
    titulo: 'Design Interactive App UI',
    descricao: ' Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: 'imagens/03.png',
    titulo: 'It\'s Just the Beginning',
    descricao: 's tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
];
