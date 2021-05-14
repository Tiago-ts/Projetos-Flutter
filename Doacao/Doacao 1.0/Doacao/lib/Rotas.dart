import 'package:Doacao/view/Cadastro.dart';
import 'package:Doacao/view/CadastroMain.dart';
import 'package:Doacao/view/Doacao.dart';
import 'package:Doacao/view/Home.dart';
import 'package:Doacao/view/Campanhas.dart';
import 'package:Doacao/view/Hemocentro.dart';
import 'package:Doacao/view/Doador.dart';
import 'package:Doacao/view/Login.dart';
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

      case "/campanhas":
        return MaterialPageRoute(builder: (_) => Campanhas());

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
