import 'dart:async';

import 'package:Doacao/view/Home.dart';
import 'package:flutter/material.dart';

import 'Welcome.dart';

class Splash extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    // tempo de abertura do splash
    Timer(Duration(seconds: 5),(){



      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Welcome() ));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

/*
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("imagens/gota.png"),
                fit: BoxFit.cover
            )
        ),
*/

      //  color: Color(0xffDB2E11),

        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(223, 51, 56, 25),
                Color.fromRGBO(234, 85, 63, 25)
                // Color.fromRGBO(255, 30, 35, 1)
              ]
          ),
        ),


        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  "imagens/LogoPreta.png",
                  width: 300,
                  height: 300,
                ),
              ),

            /*  Align(
                alignment: Alignment.center,
                child: Icon(Icons.place,
                  size: 120,
                  //color: Colors.red,
                  color: Color(0xffBA1212),
                ),
              ),

              Align(
                child: Text(
                  "Gota da Vida",
                  style: TextStyle(
                      fontSize: 40,
                      //color:  Colors.red,
                      color:  Color(0xffBA1212),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                  ),
                ),
              ),
        */
            ],
          ),
        ),
      ),
    );
  }
}
