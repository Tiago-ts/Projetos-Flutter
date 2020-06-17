import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllergasolina = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
      title: Text("Álcool ou Gasolina"),
        backgroundColor: Colors.blueAccent,
      ),
      
      body: Container(

        padding: EdgeInsets.all(32),
        child: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("imagens/logo.png"),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Saiba qual a melhor opção para seu veiculo",
                  textAlign: TextAlign.center,
                  style: TextStyle(

                      fontSize: 25,
                      fontWeight: FontWeight.bold

                  ),
                ),
              ),


              TextField(

                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço Álcool, ex: 1.62",
                ),
                style: TextStyle(
                    fontSize: 22
                ),

                controller: _controllerAlcool,
              ),


              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço Gasolina, ex: 3.99",

                ),

                style: TextStyle(
                    fontSize: 22
                ),
                controller: _controllergasolina,

              ),



              Padding(

                padding: EdgeInsets.only(top: 20),
                child: RaisedButton(

                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(

                      "Calcular",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    onPressed: (){}
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Resultado",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),

              )


            ],
          ),
        )
      ),
      
    );
  }
}
