import 'package:easyenglish/telas/login/login.dart';
import 'package:easyenglish/telas/principal.dart';
import 'package:easyenglish/util/rotas.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:easyenglish/servicos/usuario_api.dart';
import 'package:easyenglish/util/constantes.dart';

void main() {
  Rotas.iniciarRotas();
  runApp(EasyEnglish());
}

class EasyEnglish extends StatefulWidget {
  @override
  _EasyEnglish createState() => _EasyEnglish();
}

class _EasyEnglish extends State<EasyEnglish> {
  bool temToken = false;

  existeToken() async {
    var tokenApi = await UsuarioApi.verificarToken();
    setState(() {
      temToken = tokenApi != null;
    });
  }

  @override
  void initState() {
    super.initState();
    existeToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constantes.appName,
      theme: Constantes.lightTheme,
      darkTheme: Constantes.darkTheme,
      home: temToken ? Principal(itemmenu: 'inicio') : Login(),
      onGenerateRoute: Rotas.rota.generator,
    );
  }
}
