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
    titulo: 'Bem vindo ao Gota da vida!',
    descricao: ' Somos uma empresa que sabe o valor que a vida tem e que acredita que cada gota de sangue é valiosa',
  ),
  Slide(
    imageUrl: 'imagens/02.jpg',
    titulo: 'Como funciona a Doação?',
    descricao: 'Basta apenas fazer um rápido cadastro no botão abaixo e aguardar a requisição!',
  ),
  Slide(
    imageUrl: 'imagens/gota.png',
    titulo: 'Vamos dar inicio a essa parceira perfeita e salvar vidas?',
    descricao: 'Desfrute da facilidade da tecnologia e faça sua doação! Clique em Cadastre-se!',
  ),
];
