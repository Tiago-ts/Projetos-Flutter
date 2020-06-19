import 'package:flutter/material.dart';

class EntradaCheckbox extends StatefulWidget {
  @override
  _EntradaCheckboxState createState() => _EntradaCheckboxState();
}

class _EntradaCheckboxState extends State<EntradaCheckbox> {

  var valor = true;

  bool _SelecionadoBrasil = false;
  bool _SelecionadoMexico = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            
            CheckboxListTile(

              title: Text("Comida brasileira"),
                subtitle: Text(" Preço RS 10,00") ,

                activeColor: Colors.green,
                selected: false,
                secondary: Icon(Icons.add_box),

                value: _SelecionadoBrasil,
                onChanged: (bool valor) {

                  setState(() {
                    _SelecionadoBrasil = valor;

                  });
                }
                
            ),

            CheckboxListTile(

                title: Text("Comida Mexicana"),
                subtitle: Text(" Preço RS 8,00") ,

                activeColor: Colors.green,
                selected: false,
                secondary: Icon(Icons.add_box),

                value: _SelecionadoMexico,
                onChanged: (bool valor) {

                  setState(() {
                    _SelecionadoMexico = valor;

                  });
                }

            ),

            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text(
                  "Salvar",
                style: TextStyle(
                  fontSize: 20,

                ),
              ),
              onPressed: (){
                print(" Comida brasileira " + _SelecionadoBrasil.toString()
                    + " Comida mexicana "  + _SelecionadoMexico.toString());
              },
            )


            /*
            Text("Comida Brasileira"),
            Checkbox(value: _Selecionado, onChanged: (bool valor){
              setState(() {
                _Selecionado = valor;

              });
              print("Checkbox " + valor.toString());
            } )
            */
            
            
          ],
        ),
      ),
    );
  }
}
