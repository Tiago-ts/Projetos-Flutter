import 'package:flutter/material.dart';
import 'package:olx/Widget/BotaoCustomizado.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:validadores/Validador.dart';
import 'dart:io';


class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {

  List<File> _listaImagens = List();

  List<DropdownMenuItem<String>> _listaItensDropEstados = List();
  List<DropdownMenuItem<String>> _listaItensDropCategorias = List();

  final _formKey = GlobalKey<FormState>();

  String _itemSelecionadoEstado;
  String _itemSelecionadoCategoria;


  _selecionarImagemGaleria() async {

    File imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);

    if( imagemSelecionada != null ){
      setState(() {
        _listaImagens.add( imagemSelecionada );
      });
    }

  }

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
  }

  _carregarItensDropdown(){

    //Categorias
    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Automóvel"), value: "auto",)
    );

    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Imóvel"), value: "imovel",)
    );

    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Eletrônicos"), value: "eletro",)
    );

    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Moda"), value: "moda",)
    );

    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Esportes"), value: "esportes",)
    );

    //Estados
    for( var estado in Estados.listaEstadosAbrv ){
      _listaItensDropEstados.add(
          DropdownMenuItem(child: Text(estado), value: estado,)
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo anúncio"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FormField<List>(
                  initialValue: _listaImagens,
                  validator: ( imagens ){
                    if( imagens.length == 0 ){
                      return "Necessário selecionar uma imagem!";
                    }
                    return null;
                  },
                  builder: (state){
                    return Column(children: <Widget>[
                      Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _listaImagens.length + 1, //3
                          itemBuilder: (context, indice){
                            if( indice == _listaImagens.length ){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                  onTap: (){
                                    _selecionarImagemGaleria();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[400],
                                    radius: 50,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 40,
                                          color: Colors.grey[100],
                                        ),
                                        Text(
                                          "Adicionar",
                                          style: TextStyle(
                                              color: Colors.grey[100]
                                          ),
                                        )
                                      ],),
                                  ),
                                ),
                              );
                            }

                            if( _listaImagens.length > 0 ){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.file( _listaImagens[indice] ),
                                              FlatButton(
                                                child: Text("Excluir"),
                                                textColor: Colors.red,
                                                onPressed: (){
                                                  setState(() {
                                                    _listaImagens.removeAt(indice);
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                              )
                                            ],),
                                        )
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage( _listaImagens[indice] ),
                                    child: Container(
                                      color: Color.fromRGBO(255, 255, 255, 0.4),
                                      alignment: Alignment.center,
                                      child: Icon(Icons.delete, color: Colors.red,),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();

                          }
                      ),
                    ),
                    if( state.hasError )
                    Container(
                    child: Text(
                    "[${state.errorText}]",
                    style: TextStyle(
                    color: Colors.red, fontSize: 14
                    ),
                    ),
                    )
                    ],);
                  },
                ),

                Row(children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                        value: _itemSelecionadoEstado,
                        hint: Text("Estados"),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                        items: _listaItensDropEstados,
                        validator: (valor){
                          return Validador()
                              .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                              .valido(valor);
                        },
                        onChanged: (valor){
                          setState(() {
                            _itemSelecionadoEstado = valor;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                        value: _itemSelecionadoCategoria,
                        hint: Text("Categorias"),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                        items: _listaItensDropCategorias,
                        validator: (valor){
                          return Validador()
                              .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                              .valido(valor);
                        },
                        onChanged: (valor){
                          setState(() {
                            _itemSelecionadoCategoria = valor;
                          });
                        },
                      ),
                    ),
                  ),
                ],),
                Text("Caixas de textos"),
                BotaoCustomizado(
                  texto: "Cadastrar anúncio",
                  onPressed: (){
                    if( _formKey.currentState.validate() ){

                    }
                  },
                ),
              ],),
          ),
        ),
      ),
    );
  }
}
