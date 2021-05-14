import 'package:Doacao/modal/Usuario.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  //TextEditingController _controllerEmail = TextEditingController(text: "teste@gmail.com");
  //TextEditingController _controllerSenha = TextEditingController(text: "1234567");
  String _mensagemErro = "";
  bool _carregando = false;


  AnimationController _controller;
  Animation<double> _animacaoBlur;
  Animation<double> _animacaoFade;
  Animation<double> _animacaoSize;

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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          /*
            image: DecorationImage(
                image: AssetImage("imagens/fundo2.jpg"),
                fit: BoxFit.cover
            )
                */
        ),
        padding: EdgeInsets.all(10),

        child: Center(

          child: SingleChildScrollView(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: <Widget>[



                Container(

                  height: 390,
                  //color: Colors.redAccent,

                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("imagens/fundo1.png"),
                          fit: BoxFit.fill
                      )
                  ),
                ),


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


                TextField(
                  controller: _controllerSenha,
                  obscureText: true,

                  keyboardType: TextInputType.emailAddress,
                  decoration:InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: "Senha",
                      filled: true,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18

                      )
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),

                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),

                    onPressed: (){
                      _validarCampos();
                    },
                    child: Container(
                     // width: _animacaoSize.value,
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

                  ),

                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Não tem conta? cadastre-se!",
                      style: TextStyle(color: Colors.black, fontSize: 17),

                    ),
                    onTap: (){
                      Navigator.pushNamed(context, "/cadastro");
                    },
                  ),
                ),
                _carregando
                    ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),)
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),

                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
