import 'package:Doacao/modal/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'package:flutter/scheduler.dart' show timeDilation;


class CadastroMain extends StatefulWidget {
  @override
  _CadastroMainState createState() => _CadastroMainState();
}

class _CadastroMainState extends State<CadastroMain>
    with SingleTickerProviderStateMixin{

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerEndereco = TextEditingController();
  TextEditingController _controllerCidade = TextEditingController();


  AnimationController _controller;
  Animation<double> _animacaoBlur;
  Animation<double> _animacaoFade;
  Animation<double> _animacaoSize;


  bool _tipoUsuario = true;
  String _tipoUsuarioSangue = null;
  String _mensagemErro = "";

  //String _tipoUsuario = "null";

  _validarCampos(){

    //Recuperar dados dos campos
    String nome = _controllerNome.text;
    // String dataNascimento = _controllerDataNascimento.text;
    String tipoSangue = _tipoUsuarioSangue;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    String endereco = _controllerEndereco.text;
    String cidade = _controllerCidade.text;

    //validar campos
    if( nome.isNotEmpty ){

      if( email.isNotEmpty && email.contains("@") ){

        if( senha.isNotEmpty && senha.length > 4 ){

          if(_tipoUsuario == true && tipoSangue != null){


            Usuario usuario = Usuario();
            usuario.nome = nome;
            usuario.email = email;
            usuario.senha = senha;
            usuario.endereco = endereco;
            usuario.cidade = cidade;
            usuario.tipoSangue = tipoSangue;
            //usuario.dataNascimento = dataNascimento;
            usuario.tipoUsuario = usuario.verificaTipoUsuario(_tipoUsuario);

            _cadastrarUsuario( usuario );

          }else if(_tipoUsuario == false){

            if(endereco.isNotEmpty && cidade.isNotEmpty){


              Usuario usuario = Usuario();
              usuario.nome = nome;
              usuario.email = email;
              usuario.senha = senha;
              usuario.endereco = endereco;
              usuario.cidade = cidade;
              usuario.tipoSangue = null;
              //usuario.dataNascimento = dataNascimento;
              usuario.tipoUsuario = usuario.verificaTipoUsuario(_tipoUsuario);

              _cadastrarUsuario( usuario );


            } else{
              setState(() {
                _mensagemErro = "Preencha o endereço!";
              });

            }

          } else{
            setState(() {
              _mensagemErro = "Escolha um tipo sanguíneo!";
            });

          }


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

    }else{
      setState(() {
        _mensagemErro = "Preencha o Nome";
      });
    }

  }

  _cadastrarUsuario( Usuario usuario ){

    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      db.collection("usuarios")
          .document( firebaseUser.user.uid )
          .setData( usuario.toMap() );

      //redireciona para o painel, de acordo com o tipoUsuario

      switch( usuario.tipoUsuario ){

        case "doador" :
          Navigator.pushNamedAndRemoveUntil(
              context,
              "/painel-doador",
                  (_) => false
          );
          break;

        case "hemocentro" :
          Navigator.pushNamedAndRemoveUntil(
              context,
              "/painel-hemocentro",
                  (_) => false
          );
          break;

        case "null" :
          setState(() {
            _mensagemErro = "Escolha entre Doador ou Hemocentro! ";
          });
          break;
      }

    }).catchError((error){
      print("erro app: " + error.toString());
      _mensagemErro = "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
    });

  }



  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      // duration: Duration(milliseconds: 3000),
        duration: Duration(seconds: 3),
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
                  builder: (context, widget) {
                    return Container(

                      height: 350,
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
                          children: [
                            /* Center(
                            child: Positioned(
                              left: 10,
                              child: FadeTransition(
                                opacity: _animacaoFade,
                                child: Image.asset(
                                  "imagens/gotared.png",
                                  width: 180,
                                  height: 180,
                                ),

                              ),
                            ),

                          ),

*/
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
                              padding: EdgeInsets.all(8),
                              child: TextField(
                                controller: _controllerNome,
                                //autofocus: true,
                                keyboardType: TextInputType.name,
                                obscureText: false,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintText: "Nome completo",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 18

                                    )
                                ),
                              ),


                            ),

                            Container(
                              padding: EdgeInsets.all(8),
                              child: TextField(
                                controller: _controllerEmail,
                                //autofocus: true,
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.mail),
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
                              child: TextField(
                                controller: _controllerSenha,
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
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



                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Tipo sanguíneo",
                                       style: TextStyle(
                                        color: Colors.black, fontSize: 18,
                                        ),

                                    ),
                                  ),

                                ],

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
                      builder: (context, widget) {
                        return RaisedButton(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          onPressed: () {
                            _validarCampos();
                          },

                          child: Container(
                            width: _animacaoSize.value,
                            height: 50,
                            child: Center(
                              child: Text("Cadastrar", style: TextStyle(
                                  color: Colors.white, fontSize: 20,

                                  fontWeight: FontWeight.bold
                              ),),
                            ),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(186, 18, 18, 1),
                                    Color.fromRGBO(220, 30, 35, 1)
                                    // Color.fromRGBO(255, 30, 35, 1)
                                  ]
                              ),
                            ),
                          ),

                        );
                      },
                    ),

                    SizedBox(height: 8,),


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
