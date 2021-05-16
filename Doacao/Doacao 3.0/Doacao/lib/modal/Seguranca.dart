import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart' show timeDilation;


class Seguranca extends StatefulWidget {
  @override
  _SegurancaState createState() => _SegurancaState();
}

class _SegurancaState extends State<Seguranca>
    with SingleTickerProviderStateMixin{

  TextEditingController _controllerRecupera = TextEditingController();


  AnimationController _controller;
  Animation<double> _animacaoBlur;
  Animation<double> _animacaoFade;
  Animation<double> _animacaoSize;

  String _mensagemErro = "";
  String _mensagem = "Insira seu email";

  ValidarEmail(){

    String email = _controllerRecupera.text.trim();

    final bool verificar = EmailValidator.validate(email);


    if (email.isNotEmpty ) {

      if (email.isNotEmpty && email.contains("@")) {

        if (verificar == true) {

          RecuperarSenha(email);

          _mensagem = "Verifique seu Email foi enviado um link de recuperação para o seu Email.";
          _mensagemErro = " ";
          print( verificar);
          print( email);

        } else {
          _mensagemErro = "Email inválido, por favor insira um email válido.";
          _mensagem = "Insira seu email";

          print( verificar);
          print( email);

        }

      } else {
        _mensagemErro = "Verifique o Email e tente novamente!";
        _mensagem = "Insira seu email";


      }

    } else {
      _mensagemErro = "Insira um email!";
      _mensagem = "Insira seu email";

    }

  }

  RecuperarSenha(String email){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.sendPasswordResetEmail(email: email);


  }


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
       duration: Duration(milliseconds: 100),
        //duration: Duration(seconds: 3),
        vsync: this

    );



    _animacaoBlur = Tween<double>(
        begin: 5,
        end: 0
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    _animacaoFade = Tween<double>(
        begin: 0,
        end: 1
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint));


    _animacaoSize = Tween<double>(
        begin: 0,
        end: 500
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _controller.forward();


  }


  @override
  Widget build(BuildContext context) {
    timeDilation = 1;

    return Scaffold(

      appBar: AppBar(
        // centerTitle: true,
        title: Text(""),
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

      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[


              AnimatedBuilder(

                animation: _animacaoBlur,
                builder: (context, widget) {
                  return Container(

                    height: 200,
                    //color: Colors.redAccent,
/*
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("imagens/fundo1.png"),
                            fit: BoxFit.fill
                        )
                    ),
*/
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _animacaoBlur.value,
                        sigmaY: _animacaoBlur.value,
                      ),

                      child: Stack(
                        children: [
                          Center(
                            child: Positioned(
                              left: 10,
                              child: FadeTransition(
                                opacity: _animacaoFade,
                                child: Image.asset(
                                  //"imagens/LogoBranca.png",
                                  "imagens/cadeado.png",
                                  width: 110,
                                  height: 110,

                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),




              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(children: [

                  AnimatedBuilder(
                    animation: _animacaoSize,
                    builder: (context, widget) {
                      return Container(

                        width: _animacaoSize.value,

                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 15,
                                spreadRadius: 4,
                              ),
                            ]
                        ),

                        child: Column(children: <Widget>[

                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
                            child: Text(
                              "Esqueceu sua senha?",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 100, 127, 1),
                                  //color: Colors.red

                              ),
                            ),
                          ),
                          Container(
                            //alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Por favor, informe o E-mail associado a sua conta que"
                                  " enviaremos um link para o mesmo com as instruções para "
                                  "restauração de sua senha.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,


                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              _mensagem,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                 //color: Colors.red

                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(8),
                            child: TextField(
                             controller: _controllerRecupera,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.mail),
                                  hintText: "Email",

                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 18
                                  )
                              ),
                            ),
                          ),
                        ],
                        ),
                      );
                    },
                  ),


                //  SizedBox(height: 10,),

                  Padding(
                    padding: EdgeInsets.only(top: 0.5),
                    child: Center(
                      child: Text(
                        _mensagemErro,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),

                  AnimatedBuilder(

                    animation: _animacaoSize,
                    builder: (context, widget) {

                      return RaisedButton(

                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),

                        onPressed: () {
                          ValidarEmail();
                          setState(() {
                            _mensagemErro;
                            _mensagem;

                          });

                        },

                        child: Container(
                          width: _animacaoSize.value,
                          height: 50,
                          child: Center(
                            child: Text("Enviar", style: TextStyle(
                                color: Colors.white, fontSize: 20,

                                fontWeight: FontWeight.bold
                            ),
                            ),
                          ),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(186, 18, 18, 1),
                                  Color.fromRGBO(220, 30, 35, 1)

                                  //Color.fromRGBO(223, 51, 56, 25),
                                  // Color.fromRGBO(234, 85, 63, 25)

                                  // Color.fromRGBO(255, 30, 35, 1)
                                ]
                            ),
                          ),
                        ),

                      );
                    },
                  ),

                  SizedBox(height: 8,),




                ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
