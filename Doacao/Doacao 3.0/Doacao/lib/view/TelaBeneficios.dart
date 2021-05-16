import 'package:flutter/material.dart';

class TelaBeneficios extends StatefulWidget {
  @override
  _TelaBeneficiosState createState() => _TelaBeneficiosState();
}

class _TelaBeneficiosState extends State<TelaBeneficios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        // centerTitle: true,
        title: Text("Benefícios da doação"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color.fromRGBO(223, 51, 56, 25),
                    Color.fromRGBO(234, 85, 63, 25)
                  ])
          ),
        ),
      ),

      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                  child:  Text(
                    "Período gestacional",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                    ),
                  ),
                ),
              ),


              Container(
                //alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                  child:  Text(
                    "Período ara ate maior de idade com documento gestacional"
                        "eríodo ara ate maior de idade com documento gestacional",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 17,

                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }
}