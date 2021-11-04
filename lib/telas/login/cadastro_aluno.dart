import 'package:flutter/material.dart' hide Route;
import 'package:easyenglish/servicos/usuario_api.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:easyenglish/widgets/carregador.dart';
import 'package:easyenglish/widgets/validar_email.dart';
import 'package:easyenglish/util/constantes.dart';

class CadastroAluno extends StatefulWidget {
  @override
  _CadastroAluno createState() => _CadastroAluno();
}

class _CadastroAluno extends State<CadastroAluno> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();

  _cadastrar(BuildContext context) async {
    var cadUser = await UsuarioApi.criar(
        nomeController.text.trim(), emailController.text.trim());

    if (cadUser != null) {
      alerta(context, "Obrigado ;)",
          "Favor, verifique seu e-mail com os dados de acesso", "login");
    } else {
      alerta(
          context, "Ooops...", "Já existe um usuário com esses dados.", null);
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
                width: 128,
                height: 128,
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
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == "") {
                      return 'Favor, informe seu nome completo';
                    }
                    return null;
                  },
                  controller: nomeController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration.collapsed(
                    hintText: "Nome Completo",
                  ),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
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
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 40,
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
                        "Cadastrar",
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
                        _cadastrar(context);
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
                    "Já tenho acesso",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Constantes.brancoApp),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
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
