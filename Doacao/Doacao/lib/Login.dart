import 'dart:ui';

import 'package:Doacao/modal/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'InputCustomizado.dart';

import 'package:flutter/scheduler.dart' show timeDilation;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
      with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<double> _animacaoBlur;
  Animation<double> _animacaoFade;
  Animation<double> _animacaoSize;



  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  //TextEditingController _controllerEmail = TextEditingController(text: "teste@gmail.com");
  //TextEditingController _controllerSenha = TextEditingController(text: "1234567");
  String _mensagemErro = "";
  bool _carregando = false;

  _validarCampos(){

    //Recuperar dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    //validar campos
    if( email.isNotEmpty && email.contains("@") ){

      if( senha.isNotEmpty && senha.length > 6 ){

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario( usuario );

      }else{
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
        });
      }

    }else{
      setState(() {
        _mensagemErro = "Preencha o E-mail válido";
      });
    }

  }

  _logarUsuario( Usuario usuario ){

    setState(() {
      _carregando = true;
    });

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      _redirecionaPainelPorTipoUsuario( firebaseUser.user.uid );

    }).catchError((error){
      _mensagemErro = "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!";
    });

  }

  _redirecionaPainelPorTipoUsuario(String idUsuario) async {

    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot = await db.collection("usuarios")
        .document( idUsuario )
        .get();

    Map<String, dynamic> dados = snapshot.data;
    String tipoUsuario = dados["tipoUsuario"];

    setState(() {
      _carregando = false;
    });

    switch( tipoUsuario ){
      case "doador" :
        Navigator.pushReplacementNamed(context, "/painel-doador");
        break;
      case "hemocentro" :
        Navigator.pushReplacementNamed(context, "/painel-hemocentro");
        break;
    }

  }

  _verificarUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser usuarioLogado = await auth.currentUser();
    if( usuarioLogado != null ){
      String idUsuario = usuarioLogado.uid;
      _redirecionaPainelPorTipoUsuario(idUsuario);
    }

  }


  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();

    _controller = AnimationController(
      duration: Duration(milliseconds: 3000),
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
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              AnimatedBuilder(
                  animation: _animacaoBlur,
                  builder: (context, widget){

                    return Container(
                      height: 400,
                      // color: Colors.redAccent,

                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("imagens/fundo1.png"),
                              fit: BoxFit.fill
                          )
                      ),

                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: _animacaoBlur.value,
                            sigmaY: _animacaoBlur.value,
                        ),

                        child: Stack(
                          children: [


                            Positioned(
                              left: 10,
                              child: FadeTransition(
                                opacity: _animacaoFade,
                               // child: Image.asset("imagens/detalhe1.png"),
                              ),
                            ),


                            Positioned(
                              left: 50,
                              child: FadeTransition(
                                opacity: _animacaoFade,
                               // child: Image.asset("imagens/detalhe2.png"),
                              ),
                            ),
                          ],
                        ),

                      ),
                    );

                  },
              ),


              Padding(
                  padding: EdgeInsets.only(left: 30, right:30 ),
                  child: Column(children: [

                    AnimatedBuilder(
                        animation: _animacaoSize,
                        builder: (context, widget){

                          return  Container(

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

                            child: Column(children:<Widget> [

                            Container(
                            padding: EdgeInsets.all(8),
                            child:  TextField(
                              controller: _controllerEmail,
                              //autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              decoration:InputDecoration(
                                  icon: Icon(Icons.person),
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 18

                                  )
                              ),
                            ),


                          ),

                            Container(
                              padding: EdgeInsets.all(8),
                              child:  TextField(
                                controller: _controllerSenha,
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration:InputDecoration(
                                    icon: Icon(Icons.lock),
                                    hintText: "Senha",
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
                    

                    
                    SizedBox(height: 20,),

                    AnimatedBuilder(
                        animation: _animacaoSize,
                        builder: (context, widget){
                          return InkWell(
                            onTap: (){

                            },
                            child: Container(
                              width: _animacaoSize.value,
                              height: 50,
                              child: Center(
                                child: Text("Entrar", style:  TextStyle(
                                    color: Colors.white, fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors:[
                                      Color.fromRGBO(255, 100, 127, 1),
                                      Color.fromRGBO(255, 123, 145, 1)
                                    ]
                                ),
                              ),
                            ),
                          );
                        },
                    ),

                    SizedBox(height: 10,),
                    FadeTransition(
                      opacity: _animacaoFade,
                      child:    Text("Esqueci minha senha!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 100, 127, 1),
                            fontWeight: FontWeight.bold
                        ) ,
                      ),
                    ),
                  ],
                  ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
