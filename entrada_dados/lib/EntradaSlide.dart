import 'package:flutter/material.dart';

class EntradaSlider extends StatefulWidget {
  @override
  _EntradaSliderState createState() => _EntradaSliderState();
}

class _EntradaSliderState extends State<EntradaSlider> {

double valor = 5;
String laber = "Valor selecionado";

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
                value: valor,
                min: 0,
                max: 10,
                label: laber,
                divisions: 5,
                activeColor: Colors.black,

                onChanged: (double novoValor){
                  print("valor selecionado:  " + novoValor.toString() );
                  setState(() {
                    valor = novoValor;
                    laber = "Valor " + novoValor.toString();

                  });
                }
            ),
            RaisedButton(
                child: Text(
                  "Salvar",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                onPressed: (){
                  
                }
            )



          ],
        ),
      ),
    );
  }
}
