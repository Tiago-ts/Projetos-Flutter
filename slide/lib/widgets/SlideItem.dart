import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage("imagens/01.png"),
                  fit: BoxFit.cover
              )
          ),
        ),
        SizedBox(
          height: 40,
        ),

        Text(
            "Bem vindo!",
            style: TextStyle(
              fontSize: 22,
              color: Theme.of(context).primaryColor,
            )
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Bem vindo ao Motorcycle faça seu cadastro",
          style: TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
