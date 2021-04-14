import 'package:Doacao/telas/Cadastro.dart';
import 'package:Doacao/telas/CadastroMain.dart';
import 'package:Doacao/telas/Doacao.dart';
import 'package:Doacao/telas/Home.dart';
import 'package:Doacao/telas/Hemocentro.dart';
import 'package:Doacao/telas/Doador.dart';
import 'package:Doacao/widget/Login.dart';
import 'package:flutter/material.dart';

class Rotas {
  static Route<dynamic> gerarRotas(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Home());

      case "/cadastro":
        return MaterialPageRoute(builder: (_) => Cadastro());

      case "/cadastroMain":
        return MaterialPageRoute(builder: (_) => CadastroMain());

      case "/painel-hemocentro":
        return MaterialPageRoute(builder: (_) => Hemocentro());

      case "/painel-doador":
        return MaterialPageRoute(builder: (_) => Doador());

      case "/corrida":
        return MaterialPageRoute(builder: (_) => Doacao(args));
		
		
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());

      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada!"),
        ),
        body: Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }
}
