import 'package:flutter/material.dart';

class Etapas extends StatefulWidget {
  @override
  _EtapasState createState() => _EtapasState();
}

class _EtapasState extends State<Etapas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        // centerTitle: true,
        title: Text("Etapas da doação"),
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "Recepção",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red

                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(

                  "Para realizar seu cadastro leve consigo documento oficial de identidade com foto (RG, carteira de motorista, carteira de trabalho ou passaporte). Para a faixa etária entre 16 e 18 anos incompletos é necessário acompanhante maior de idade com documento.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,



                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "Triagem clínica",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red

                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "Após o cadastro ocorre a triagem clínica, que nada mais é que uma entrevista feita por profissional de saúde que irá avaliar as condições de saúde da pessoa que vai doar para não colocar em risco a pessoa que vai receber.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,



                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "Coleta",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red

                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "A coleta do sangue dura em torno de 15 a 20 minutos. Ela é feita com material esterilizado, descartável e não apresenta nenhum risco para a pessoa que está doando.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,


                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "Depois de doar sangue",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red

                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "Faça um pequeno lanche e hidrate-se. Evite esforços físicos exagerados por pelo menos 12 horas, não fumar por cerca de 2 horas, evitar bebidas alcóolicas por 12 horas e não dirigir veículos de grande porte. Exercícios e práticas esportivas também devem ser evitadas logo após a doação.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,


                  ),
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }
}