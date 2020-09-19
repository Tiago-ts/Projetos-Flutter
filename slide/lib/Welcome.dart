import 'package:flutter/material.dart';
import 'package:slide/widgets/SlideItem.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
          children: <Widget>[
            Expanded(
              child: SlideItem(),
            ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              FlatButton(
                  child: Text(
                      "Cadastra-se",
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(15),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {},

                /*
                {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => Home()
                                )
                            );
                          },
                 */

              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Já possui conta?",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  FlatButton(
                      onPressed: null,
                      child: Text(
                          "Faça Login!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black

                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
     ),
    ),
    );
  }
}
