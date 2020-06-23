import 'package:flutter/material.dart';


class EntradaSwitch extends StatefulWidget {
  @override
  _EntradaSwitchState createState() => _EntradaSwitchState();
}

class _EntradaSwitchState extends State<EntradaSwitch> {

bool _escolhaUsuario = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada Switch"),
      ),

      body: Container(
        child: Column(
          children: <Widget>[

            SwitchListTile(
                title: Text("Receber novidades"),
              subtitle: Text("ativado"),
                //activeColor: Colors.red,
                selected: true,
                secondary: Icon(Icons.access_alarm),

                value: _escolhaUsuario,
                onChanged:(bool valor){
                  setState(() {
                    _escolhaUsuario = valor;
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
                print(" res: " + _escolhaUsuario.toString());
              },
            )


            /*
            Switch(
                value: _escolhaUsuario,
                onChanged: (bool valor){
                  setState(() {
                    _escolhaUsuario = valor;
                  });
                }
            ),
            Text("Receber notificação")
            */
          ],
        ),
      ),
    );
  }
}
