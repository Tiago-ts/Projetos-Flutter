import 'package:flutter/material.dart';
import 'package:olx/Widget/BotaoCustomizado.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text("Novo Anúncio"),
      ),

      body: SingleChildScrollView(

        child: Container(

          padding: EdgeInsets.all(16),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                //imagens
               // FormField(builder: null),

                //Menus
                Row(
                  children: [
                    Text("Estado"),
                    Text("Categoria"),
                  ],
                ),

                //texto e botoes
                Text("caixa"),

                BotaoCustomizado(
                  texto: "Cadastrar anúncio",
                  onPressed: (){
                    if(_formKey.currentState.validate()){

                    }
                  },
                ),

              ],
            ),
          ),
        ),

      ),
    );
  }
}
