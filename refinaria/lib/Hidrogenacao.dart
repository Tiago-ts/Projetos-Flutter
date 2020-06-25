import 'package:flutter/material.dart';

class Hidrogenacao extends StatefulWidget {
  @override
  _HidrogenacaoState createState() => _HidrogenacaoState();
}

class _HidrogenacaoState extends State<Hidrogenacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hidrogenação"),
        backgroundColor: Color(0xFFf45d27),
      ),

      body: Center(
        child: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Calcule sua produção",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 65,
                      padding: EdgeInsets.only(
                          top: 0, left: 20, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(50)
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 5
                            )
                          ]

                      ),

                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Quanto foi sua produção?",
                            icon: Icon(Icons.invert_colors,
                              color: Colors.grey,
                            )
                        ),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                        controller: null,
                      ),
                    )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 15, left: 0, right: 0, bottom: 30),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 20),

                      child: Text(
                            "texto2" ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              RaisedButton(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize:23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  color: Color(0xFFf5851f),

                  onPressed: (){

                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)
                  )
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}

