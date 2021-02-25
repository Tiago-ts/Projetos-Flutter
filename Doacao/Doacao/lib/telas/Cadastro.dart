import 'package:Doacao/modal/Usuario.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  //TextEditingController _controllerNome = TextEditingController(text:"teste");
  //TextEditingController _controllerEmail = TextEditingController(text:"teste@gmail.");
  //TextEditingController _controllerSenha = TextEditingController(text:"1234567");
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  bool _tipoUsuario = false;
  String _mensagemErro = "";

  _validarCampos(){

    //Recuperar dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    //validar campos
    if( nome.isNotEmpty ){

      if( email.isNotEmpty && email.contains("@") ){

        if( senha.isNotEmpty && senha.length > 6 ){

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          usuario.tipoUsuario = usuario.verificaTipoUsuario(_tipoUsuario);

          _cadastrarUsuario( usuario );

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
      }

    }).catchError((error){
      print("erro app: " + error.toString());
      _mensagemErro = "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("imagens/fundo2.jpg"),
                fit: BoxFit.cover
            )
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                
                Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.place,
                    size: 120,
                    //color: Colors.red,
                    color: Color(0xffBA1212),
                  ),
                ),


                Align(
                  child: Text(
                    "Blood Bank",
                    style: TextStyle(
                        fontSize: 40,
                        //color:  Colors.red,
                        color:  Color(0xffBA1212),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),


                TextField(
                  controller: _controllerNome,
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome completo",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),
                TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "e-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),
                TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[

                      Text("Hemocentro",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Switch(
                          value: _tipoUsuario,
                          onChanged: (bool valor){
                            setState(() {
                              _tipoUsuario = valor;
                            });
                          }
                      ),

                      Text("Doador",
                        style: TextStyle(color: Colors.white, fontSize: 17, ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      //color: Colors.red,
                      color: Color(0xffBA1212),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      onPressed: (){
                        _validarCampos();
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)
                      )
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Color(0xffBA1212), fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
