import 'dart:ui';

import 'package:Doacao/modal/Usuario.dart';
import 'package:Doacao/modal/Seguranca.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'Cadastro.dart';
import 'CadastroMain.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
      with SingleTickerProviderStateMixin{


  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  //TextEditingController _controllerEmail = TextEditingController(text: "teste@gmail.com");
  //TextEditingController _controllerSenha = TextEditingController(text: "1234567");

  String _mensagemErro = "";
  bool _carregando = false;
  bool _showSenha = false;

  AnimationController _controler;
  Animation<double> _animacaoBlur;
  Animation<double> _animacaoFade;
  Animation<double> _animacaoSize;


  _validarCampos(){

    //Recuperar dados dos campos
    String email = _controllerEmail.text.trim();
    String senha = _controllerSenha.text.trim();

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
        _mensagemErro = "Preencha um email válido";
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
      _mensagemErro = "Ops... Email ou senha incorreto! Verifique o email e senha e tente novamente!";
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

    _controler = AnimationController(
     // duration: Duration(milliseconds: 3000),
      duration: Duration(seconds: 3),
      vsync: this

    );

    _animacaoBlur = Tween<double>(
      begin: 5,
      end: 0
    ).animate(CurvedAnimation(parent: _controler, curve: Curves.ease));

    _animacaoFade = Tween<double>(
        begin: 0,
        end: 1
    ).animate(CurvedAnimation(parent: _controler, curve: Curves.easeInOutQuint));


    _animacaoSize = Tween<double>(
        begin: 0,
        end: 500
    ).animate(CurvedAnimation(parent: _controler, curve: Curves.decelerate));

    _controler.forward();


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

                      height: 390,
                      //color: Colors.redAccent,

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
                          children:[
                          Center(
                            child: Positioned(
                              left: 10,
                              child: FadeTransition(
                                opacity: _animacaoFade,
                                child: Image.asset(
                                  "imagens/LogoBranca.png",
                                  width: 270,
                                  height: 270,
                                ),

                              ),
                            ),

                          ),

 /*

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
   */

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

                              TextField(
                              controller: _controllerEmail,
                              //autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              decoration:InputDecoration(
                                  icon: Icon(Icons.person),
                                  border: InputBorder.none,
                                  hintText: "  Email",
                                  hintStyle: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 18

                                  )
                              ),
                            ),

                              SizedBox(height: 8,),



                                 TextField(
                                controller: _controllerSenha,
                                obscureText:  _showSenha == false ? true : false,

                                keyboardType: TextInputType.emailAddress,
                                decoration:InputDecoration(
                                    icon: Icon(Icons.lock),
                                    hintText: "Senha",
                                    filled: true,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 18

                                    ),
                                  suffixIcon: GestureDetector(
                                    child: Icon(_showSenha == true ? Icons.visibility_off : Icons.visibility, color: Colors.grey,),
                                    onTap: (){
                                      setState(() {
                                        _showSenha = !_showSenha;

                                      });
                                    },
                                  ),
                                ),
                              ),

                            ],
                            ),
                          );
                        },
                    ),
                    

                    SizedBox(height: 2,),

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

                    SizedBox(height: 10,),

                    AnimatedBuilder(

                        animation: _animacaoSize,
                        builder: (context, widget){

                          return RaisedButton(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                               ),

                            onPressed: (){
                              _validarCampos();
                            },
                            child: Container(
                              width: _animacaoSize.value,
                              height: 50,
                              child: Center(
                                child: Text("Entrar", style:  TextStyle(
                                    color: Colors.white, fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                    colors:[
                                      Color.fromRGBO(186, 18, 18, 1),
                                      Color.fromRGBO(220, 30, 35, 1)
                                     // Color.fromRGBO(255, 30, 35, 1)
                                    ],

                                ),
                              ),

                            ),

                          );
                        },
                    ),

                    SizedBox(height: 10,),

                    Center(
                      child: GestureDetector(
                        child: Text(
                          "Não tem conta? cadastre-se!",
                          style: TextStyle(color: Colors.black, fontSize: 14),

                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
                        },
                      ),
                    ),
                    _carregando
                        ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),)
                        : Container(),

                    SizedBox(height: 10,),


                    GestureDetector(
                     // opacity: _animacaoFade,
                      child:    Text("Esqueci minha senha!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 100, 127, 1),
                            fontWeight: FontWeight.bold
                        ) ,
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Seguranca()));
                      },

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
