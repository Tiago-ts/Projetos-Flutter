import 'package:flutter/material.dart';
import 'package:slide/modal/Slide.dart';

class SlideItem extends StatelessWidget {

  final int index;
  SlideItem(this.index);

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
              image: DecorationImage(image: AssetImage(slideList[index].imageUrl),
                  fit: BoxFit.cover
              )
          ),
        ),
        SizedBox(
          height: 40,
        ),

        Text(
            slideList[index].titulo,
            style: TextStyle(
              fontSize: 22,
              color: Theme.of(context).primaryColor,
            )
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          slideList[index].descricao,
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
