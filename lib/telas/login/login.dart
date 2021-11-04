import 'package:easyenglish/util/constantes.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:easyenglish/servicos/usuario_api.dart';
import 'dart:async';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:easyenglish/widgets/carregador.dart';
import 'package:easyenglish/widgets/validar_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _logar(BuildContext context) async {
    var tokenApi = await UsuarioApi.tokenApi(
        emailController.text.trim(), senhaController.text.trim());

    if (tokenApi == null) {
      alerta(
          context,
          "Ooops...",
          "Ocorreu um erro. Possíveis causas:\n- Usuário não existe\n- Usuário inativo",
          null);
    } else {
      var prefs = await SharedPreferences.getInstance();
      String mudarSenha = (prefs.getString("mudar_senha") ?? "");

      if (mudarSenha == "1") {
        Navigator.pushReplacementNamed(context, 'mudarsenha');
      } else {
        Navigator.pushReplacementNamed(context, 'principal/inicio');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 80, left: 40, right: 40),
          color: Constantes.azulApp,
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 160,
                height: 160,
                child: Image.asset("images/logo_branco.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                height: 60.0,
                decoration: BoxDecoration(
                    color: Constantes.brancoApp,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (!validarEmail(context, value)) {
                      return 'Favor, informe seu e-mail';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration.collapsed(
                    hintText: "E-mail",
                  ),
                  style: TextStyle(fontSize: 20, color: Constantes.darkBG),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                height: 60.0,
                decoration: BoxDecoration(
                    color: Constantes.brancoApp,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Favor, informe sua senha';
                    }
                    return null;
                  },
                  controller: senhaController,
                  decoration: InputDecoration.collapsed(
                    hintText: "Senha",
                  ),
                  style: TextStyle(fontSize: 20, color: Constantes.darkBG),
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text(
                    "Recuperar Senha",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Constantes.brancoApp),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'resetarsenha');
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Constantes.verdeApp,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Acessar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      carregador(context).show();
                      await Future.delayed(Duration(seconds: 2))
                          .then((onValue) {
                        carregador(context).hide();
                        _logar(context);
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                child: FlatButton(
                  child: Text(
                    "Cadastre-se",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Constantes.brancoApp),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'termo');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
