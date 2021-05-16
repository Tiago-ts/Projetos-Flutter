import 'package:flutter/material.dart';

class TelaDoar extends StatefulWidget {
  @override
  _TelaDoarState createState() => _TelaDoarState();
}

class _TelaDoarState extends State<TelaDoar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        // centerTitle: true,
        title: Text("Quem pode doar?"),
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
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                    "O que é a doação de sangue?",
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

                  "A doação de sangue é um gesto solidário de doar uma pequena quantidade do próprio sangue para salvar a vida de pessoas que se submetem a tratamentos e intervenções médicas de grande porte e complexidade, como transfusões, transplantes, procedimentos oncológicos e cirurgias.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,



                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "Quais são os requisitos para doação de sangue?",
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
                  "Podem doar sangue pessoas entre 16 e 69 anos"
                      " e que estejam pesando mais de 50kg. Além disso,"
                      " é preciso apresentar documento oficial com foto "
                      "e menores de 18 anos só podem doar com consentimento "
                      "formal dos responsáveis. Pessoas com febre, gripe ou resfriado,"
                      " diarreia recente, grávidas e mulheres no pós-parto não podem doar"
                      " temporariamente. O procedimento para doação de sangue é simples, "
                      "rápido e totalmente seguro. Não há riscos para o doador,"
                      " porque nenhum material usado na coleta do sangue é reutilizado,"
                      " o que elimina qualquer possibilidade de contaminação.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,



                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "Os requisitos para doar sangue é estar com bom estado"
                      " de saúde e seguir os seguintes passos:",
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
                  "* Estar alimentado. Evite alimentos gordurosos nas 3 horas que antecedem a doação de sangue.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Caso seja após o almoço, aguardar 2 horas.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Ter dormido pelo menos 6 horas nas últimas 24 horas.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Pessoas com idade entre 60 e 69 anos só poderão doar"
                      " sangue se já o tiverem feito antes dos 60 anos.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),

                child:  Text(

                  "* A frequência máxima é de quatro doações de sangue anuais para o homem e de três doações"
                      " de sangue anuais para as mulher.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* O intervalo mínimo entre uma doação de sangue e outra é de dois meses para os homens e de três meses para as mulheres.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "Quais são os impedimentos temporários para doar sangue?",
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
                  "* Gripe, resfriado e febre: aguardar 7 dias após o desaparecimento dos sintomas",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),


              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                  child:  Text(
                    "* Período gestacional",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),

              ),


              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                   "* Período pós-gravidez: 90 dias para parto normal e 180 dias para cesariana " ,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                  child:  Text(
                    "* Amamentação: até 12 meses após o parto",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Ingestão de bebida alcoólica nas 12 horas que antecedem a doação",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Tatuagem e/ou piercing nos últimos 12 meses (piercing em cavidade oral ou região genital impedem a doação)",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),

                child: Container(
                  alignment: Alignment.centerLeft,
                  child:  Text(
                    "* Extração dentária: 72 horas",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Apendicite, hérnia, amigdalectomia, varizes: 3 meses",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Colecistectomia, histerectomia, nefrectomia, redução de fraturas, politraumatismos sem seqüelas graves, tireoidectomia, colectomia: 6 meses",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Vacinação: o tempo de impedimento varia de acordo com o tipo de vacina",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Exames/procedimentos com utilização de endoscópio nos últimos 6 meses",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Ter sido exposto a situações de risco acrescido para infecções sexualmente transmissíveis (aguardar 12 meses após a exposição)",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "Quais são os impedimentos definitivos para doar sangue?",
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
                  "* Ter passado por um quadro de hepatite após os 11 anos de idade",

                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                child:  Text(
                  "* Evidência clínica ou laboratorial das seguintes doenças transmissíveis pelo sangue:  Hepatites B e C, AIDS (vírus HIV), doenças associadas aos vírus HTLV I e II e Doença de Chagas",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                  child:  Text(
                    "* Uso de drogas ilícitas injetáveis",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                  child:  Text(
                    "* Malária",
                    style: TextStyle(
                      fontSize: 17,
                    ),
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