import 'package:flutter/material.dart';

class EntradaSlider extends StatefulWidget {
  @override
  _EntradaSliderState createState() => _EntradaSliderState();
}

class _EntradaSliderState extends State<EntradaSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Entrada Swite",

          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.yellow,

      ),

      body: Container(
        padding: EdgeInsets.all(60),
        child: Column(
          children: <Widget>[

            Slider(
                value: 5,
                min: 0,
                max: 10,
                onChanged: null
            ),
            RaisedButton(
                child: Text(
                  "Salvar",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                onPressed: (){}
            )



          ],
        ),
      ),
    );
  }
}
