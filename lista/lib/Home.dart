import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _itens = [];

  void _carregarItens(){

    _itens = [];

    for(int i=0; i<10; i++){

      Map<String, dynamic> item = Map();

      item["titulo"] = "Titulo ${i} Programar não é vida";
      item["Descrição"] = "Descrição ${i} pode acreditar";

      _itens.add(item);

    }

  }


  @override
  Widget build(BuildContext context) {
    //chamando método
    _carregarItens();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Lista"),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _itens.length,
            itemBuilder: (context, indice){

           // Map<String, dynamic> item = _itens[indice];
           // print("item ${ item["titulo"]}");

            //print("item ${_itens[indice].toString()}");
            
            return ListTile(
              //click
              onTap: (){
               // print("click ${indice}")
                showDialog(
                    context: context,
                  builder: (context){
                      return AlertDialog(
                        title: Text("Título ${indice}"),
                        content: Text("conteúdo ${indice}"),
                      );
                  }
                  
                );
              },
              
              
              //pressionando
              onLongPress: (){
               // print("pressionando ${indice}")
                
              },
              
              title: Text(
                _itens[indice]["titulo"],
                style: TextStyle(
                  fontSize: 17,
                ),
              ),


              subtitle: Text(
                  _itens[indice]["Descrição"],
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              trailing: Text(
                  "terceiro titulo",
                style: TextStyle(
                  color: Colors.red
                ),
              ),

            );

            }
        ),
      ),

    );
  }
}
