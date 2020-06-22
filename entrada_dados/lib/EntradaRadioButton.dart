import 'package:flutter/material.dart';

class EntradaRadioButton extends StatefulWidget {
  @override
  _EntradaRadioButtonState createState() => _EntradaRadioButtonState();
}

class _EntradaRadioButtonState extends State<EntradaRadioButton> {

  String _escolhaUsuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada Radio Button"),

      ),

      body: Container(
        child: Column(
          children: <Widget>[


            RadioListTile(
                title: Text("masculino"),
                value: "masculino",
                groupValue: _escolhaUsuario,
                onChanged: (String escolha){
                  setState(() {
                    _escolhaUsuario = escolha;
                    print("resultado: " + escolha);
                  });
                }
            ),

            RadioListTile(
                title: Text("feminino"),
                value: "feminino",
                groupValue: _escolhaUsuario,
                onChanged: (String escolha){
                  setState(() {
                    _escolhaUsuario = escolha;
                    print("resultado: " + escolha);
                  });
                }
            ),
            RadioListTile(
                title: Text("teste"),
                value: "teste",
                groupValue: _escolhaUsuario,
                onChanged: (String escolha){
                  setState(() {
                    _escolhaUsuario = escolha;
                    print("resultado: " + escolha);
                  });
                }
            ),



            /*
            Text("Masculino"),
            Radio(
                value: "masculino",
                groupValue: _escolhaUsuario,
                onChanged: (String escolha){
                  setState(() {
                    _escolhaUsuario = escolha;
                    print("resultado: " + escolha);
                  });
                }
            ),

            Text("Feminino"),
            Radio(
                value: "feminino",
                groupValue: _escolhaUsuario,
                onChanged: (String escolha){
                  setState(() {
                    _escolhaUsuario = escolha;
                    print("resultado: " + escolha);
                  });

                }
            ),*/

          ],
        ),
      ),

    );
  }
}
