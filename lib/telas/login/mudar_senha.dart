import 'package:easyenglish/servicos/usuario_api.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/carregador.dart';

class MudarSenha extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final senhaController = TextEditingController();

  _mudarSenha(BuildContext context) async {
    var cadUser = await UsuarioApi.mudarSenha(senhaController.text.trim());

    if (cadUser != null) {
      alerta(context, "Senha alterada com sucesso ;)",
          "Enviamos um e-mail com a nova senha", "principal/inicio");
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
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: senhaController,
                  decoration: InputDecoration.collapsed(
                    hintText: "Senha",
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
                        "Mudar Senha",
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
                        _mudarSenha(context);
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              /*Container(
                height: 20,
                child: FlatButton(
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Constantes.brancoApp),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
