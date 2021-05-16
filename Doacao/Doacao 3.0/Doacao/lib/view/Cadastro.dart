import 'package:Doacao/modal/Usuario.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';



class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  //TextEditingController _controllerNome = TextEditingController(text:"teste");
  //TextEditingController _controllerEmail = TextEditingController(text:"teste@gmail.");
  //TextEditingController _controllerSenha = TextEditingController(text:"1234567");
  //TextEditingController _controllerDataNascimento = TextEditingController();
  //TextEditingController _controllerTipoSangue = TextEditingController();


  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  //TextEditingController _controllerEndereco = TextEditingController();
  TextEditingController _controllerRua = TextEditingController();
  TextEditingController _controllerNumero = TextEditingController();
  TextEditingController _controllerBairro = TextEditingController();
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerEstado = TextEditingController();

  bool _tipoUsuario = true;
  String _tipoUsuarioSangue = null;
  String _mensagemErro = "";

  //String _tipoUsuario = "null";

  _validarCampos() async {

    //Recuperar dados dos campos

    String nome = _controllerNome.text;
    String email = _controllerEmail.text.trim();
    String senha = _controllerSenha.text.trim();
    String tipoSangue = _tipoUsuarioSangue;
    //String endereco = _controllerEndereco.text;


    String rua = _controllerRua.text;
    String numero = _controllerNumero.text.trim();
    String bairro = _controllerBairro.text;
    String cidade = _controllerCidade.text;
    String estado = _controllerEstado.text.trim();

    String endereco = rua + " "+ bairro + " " + cidade +" "+ estado;

    TextEditingController _controllerHemocentro = TextEditingController
      (text: endereco);

    String enderecoHemocentro = _controllerHemocentro.text;

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
            usuario.rua = rua;
            usuario.numero = numero;
            usuario.bairro = bairro;
            usuario.cidade = cidade;
            usuario.estado = estado;
            usuario.tipoSangue = tipoSangue;
            usuario.tipoUsuario = usuario.verificaTipoUsuario(_tipoUsuario);

          _cadastrarUsuario( usuario );

        }else if(_tipoUsuario == false){

            if(endereco.isNotEmpty && cidade.isNotEmpty){




              List<Placemark> listaEnderecos =
                  await Geolocator().placemarkFromAddress(enderecoHemocentro);

              Placemark enderecoLista = listaEnderecos[0];

              print("lista");

              print(enderecoLista);

              //cadastro hemocentro

              Usuario usuario = Usuario();

              usuario.nome = nome;
              usuario.email = email;
              usuario.senha = senha;
              usuario.endereco = endereco;
              usuario.rua = rua;
              usuario.numero = numero;
              usuario.bairro = bairro;
              usuario.cidade = cidade;
              usuario.estado = estado;

              usuario.latitude = enderecoLista.position.latitude;
              usuario.longitude = enderecoLista.position.longitude;

              usuario.tipoSangue = null;
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
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Container(
        decoration: BoxDecoration(
            /*image: DecorationImage(
                image: AssetImage("imagens/fundo2.jpg"),
                fit: BoxFit.cover
            )*/
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                
             /*   Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.place,
                    size: 120,
                    //color: Colors.red,
                    color: Color(0xffBA1212),
                  ),
                ),
*/
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Image.asset(
                    "imagens/gotared.png",
                    width: 180,
                    height: 180,
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

                Padding(
                  padding: EdgeInsets.only(bottom: 2),

                ),

     /*           TextField(
                  controller: _controllerDataNascimento,
                  // autofocus: true,
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Data de nascimento",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),
*/

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

                Padding(
                  padding: EdgeInsets.only(bottom: 2),

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
                  padding: EdgeInsets.only(bottom: 20),

                ),


                TextField(
                  controller: _controllerRua,
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Rua",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20),

                ),


                TextField(
                  controller: _controllerNumero,
                  // autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "numero",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20),

                ),


                TextField(
                  controller: _controllerBairro,
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Bairro",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20),

                ),


                TextField(
                  controller: _controllerCidade,
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Cidade",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20),

                ),


                TextField(
                  controller: _controllerEstado,
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Estado",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),

                Container(
                  child: Row(
                    children: [

                      Radio(
                          value: true,
                          groupValue: _tipoUsuario,
                          onChanged: (bool escolha){
                            setState((){
                              _mensagemErro = "";
                              _tipoUsuario = escolha;
                              print("resultado false doador "  );

                            });
                          }
                      ),

                      Text("Doador",
                        style: TextStyle(color: Colors.black, fontSize: 17, ),
                      ),


                      Radio(
                          value: false,
                          groupValue: _tipoUsuario,
                          onChanged: (bool escolha){
                            setState((){
                              _mensagemErro = "";
                              _tipoUsuario = escolha;
                              print("resultado true hemocentro " );


                            });
                          }
                      ),
                      Text("Hemocentro",
                        style: TextStyle(color: Colors.black, fontSize: 17, ),
                      ),

                    ],
                  ),
                ),

                _tipoUsuario ? Container(
                  child: Column(
                    children: [

                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                      ),


                      Text(
                        "Tipo sanguíneo",
                          style: TextStyle(color: Colors.black, fontSize: 18, ) ,

                      ),


                      RadioListTile(
                          title: Text("AB+",
                            style: TextStyle(color: Colors.black, fontSize: 16),),
                          value: "AB+",
                          groupValue: _tipoUsuarioSangue,
                          onChanged: (String valor){
                            setState((){
                              _tipoUsuarioSangue = valor;
                              print("resultado " + valor  );

                            });
                          }
                      ),

                      RadioListTile(
                          title: Text("AB-",
                            style: TextStyle(color: Colors.black, fontSize: 16),),
                          value: "AB-",
                          groupValue: _tipoUsuarioSangue,
                          onChanged: (String valor){
                            setState((){
                              _tipoUsuarioSangue = valor;
                              print("resultado " + valor  );

                            });
                          }
                      ),

                      RadioListTile(
                          title: Text("A+",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          value: "A+",
                          groupValue: _tipoUsuarioSangue ,
                          onChanged: (String valor){
                            setState((){
                              _tipoUsuarioSangue = valor;
                              print("resultado  " + valor );

                            });
                          }
                      ),

                      RadioListTile(
                          title: Text("A-",
                            style: TextStyle(color: Colors.black, fontSize: 16),),
                          value: "A-",
                          groupValue: _tipoUsuarioSangue,
                          onChanged: (String valor){
                            setState((){
                              _tipoUsuarioSangue = valor;
                              print("resultado "  + valor );

                            });
                          }
                      ),

                      RadioListTile(
                          title: Text("B+",
                            style: TextStyle(color: Colors.black, fontSize: 16),),
                          value: "B+",
                          groupValue: _tipoUsuarioSangue,
                          onChanged: (String valor){
                            setState((){
                              _tipoUsuarioSangue = valor;
                              print("resultado  " + valor  );

                            });
                          }
                      ),

                      RadioListTile(
                          title: Text("B-",
                            style: TextStyle(color: Colors.black, fontSize: 16),),
                          value: "B-",
                          groupValue: _tipoUsuarioSangue,
                          onChanged: (String valor){
                            setState((){
                              _tipoUsuarioSangue = valor;
                              print("resultado  " + valor  );

                            });
                          }
                      ),


                      RadioListTile(
                          title: Text("O+",
                            style: TextStyle(color: Colors.black, fontSize: 16),),
                          value: "O+",
                          groupValue: _tipoUsuarioSangue,
                          onChanged: (String valor){
                            setState((){
                              _tipoUsuarioSangue = valor;
                              print("resultado " + valor  );

                            });
                          }
                      ),

                      RadioListTile(
                          title: Text("O-",
                            style: TextStyle(color: Colors.black, fontSize: 16),),
                          value: "O-",
                          groupValue: _tipoUsuarioSangue,
                          onChanged: (String valor){
                            setState((){
                              _tipoUsuarioSangue = valor;
                              print("resultado "  + valor );

                            });
                          }
                      ),
                    ],

                ),

                )
                              : Container(
                  child: Column(
                      children: [
/*
                        TextField(
                          controller: _controllerEndereco,
                          // autofocus: true,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                              hintText: "Endereço, Ex.: Rua.., 220",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)
                              )
                          ),
                        ),
*/


                      ],
                  ),

                ),


                /*      Padding(
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
           */

                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),

                  child: RaisedButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                      style: TextStyle(color: Color(0xffBA1212), fontSize: 17),
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
