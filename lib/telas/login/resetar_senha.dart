import 'package:easyenglish/servicos/usuario_api.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:easyenglish/widgets/validar_email.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/carregador.dart';

class ResetarSenha extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  _recuperar(BuildContext context) async {
    var cadUser = await UsuarioApi.recuperarSenha(emailController.text.trim());

    if (cadUser != null) {
      alerta(context, "Senha recuperada ;)",
          "Favor, verifique seu e-mail com os dados de acesso", "login");
    } else {
      alerta(context, "Ooops...", "Usuário não existe", null);
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
                height: 60,
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
                        "Recuperar",
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
                        _recuperar(context);
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 20,
                child: FlatButton(
                  child: Text(
                    "Lembrei minha senha",
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
