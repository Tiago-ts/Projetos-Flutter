import 'package:flutter/material.dart';

class AlterarSenha extends StatefulWidget {
  @override
  _AlterarSenhaState createState() => _AlterarSenhaState();
}

class _AlterarSenhaState extends State<AlterarSenha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),

      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Alterar senha")


            ],
          ),
        ),
      ),
      
    );
  }
}
