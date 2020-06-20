import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();

  String _textoResultado = " ";
  String _Resultado = " ";

    void _calcular(){

    double precoAlcool = double.tryParse(_controllerAlcool.text);
    double precoGasolina = double.tryParse(_controllerGasolina.text);

    if ( precoAlcool== null || precoGasolina == null){
      print("Número inválido, digite números maiores que 0 e utilizando ( . )");
      setState(() {
        _Resultado = "Número inválido, digite números maiores que 0 e utilizando ( . )";
        _textoResultado = " ";
      });
    }else{
      if( (precoAlcool / precoGasolina ) >= 0.7){
      setState(() {
        _textoResultado = "Melhor abastecer com gasolina";
        _Resultado = " ";

      });

      }else{
        setState(() {
          _textoResultado = "Melhor abastecer com álcool";
          _Resultado = " ";

        });

      }

    }

    _limpar();

  }

  void _limpar(){
      _controllerAlcool.text = "";
      _controllerGasolina.text = "";
  }


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
                  labelText: "Preço Álcool, Ex: 1.62",
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22
                ),

                controller: _controllerAlcool,
              ),


              TextField(

                keyboardType: TextInputType.number,

                decoration: InputDecoration(

                  labelText: "Preço Gasolina, Ex: 3.99",


                ),

                style: TextStyle(
                  color: Colors.black,
                    fontSize: 22,



                ),
                controller: _controllerGasolina,

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
                    onPressed: _calcular
                ),

              ),
              Padding(padding: EdgeInsets.only(top: 30),
                child: Text(_Resultado ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),



              Padding(padding: EdgeInsets.only(top: 0),
                child: Text(_textoResultado ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green,
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
