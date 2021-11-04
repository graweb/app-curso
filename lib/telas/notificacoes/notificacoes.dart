import 'dart:convert';
import 'package:easyenglish/models/notificacoes_api_model.dart';
import 'package:easyenglish/servicos/notificacoes_api.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:shared_preferences/shared_preferences.dart';

class Notificacoes extends StatefulWidget {
  @override
  _Notificacoes createState() => _Notificacoes();
}

class _Notificacoes extends State<Notificacoes> {
  var not = new List<NotificacoesApiModel>();

  String usuarioLogado;

  @override
  void initState() {
    super.initState();
    _getNotificacoes();
    pegarUsuLogado();
  }

  _getNotificacoes() async {
    NotificacoesApi.notificacoesUsuario().then((response) {
      if (this.mounted) {
        setState(() {
          Iterable lista = json.decode(response.body);
          not = lista
              .map((model) => NotificacoesApiModel.fromJson(model))
              .toList();
        });
      } else {
        Iterable lista = json.decode(response.body);
        not =
            lista.map((model) => NotificacoesApiModel.fromJson(model)).toList();
      }
    });

    return not;
  }

  pegarUsuLogado() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      usuarioLogado = (prefs.getString("nome") ?? "");
    });
  }

  _confirmarLida(BuildContext context, String idagenda) async {
    await NotificacoesApi.confirmarLida(idagenda);
    Navigator.pushReplacementNamed(context, 'notificacoes');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _alertaVoltar,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("$usuarioLogado",
              style: TextStyle(fontSize: 18, color: Constantes.white)),
          backgroundColor: Constantes.azulApp,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Constantes.white,
              onPressed: () {
                return Navigator.pushReplacementNamed(
                    context, 'principal/inicio');
              },
            ),

            /*IconButton(
              icon: Icon(Icons.person),
              color: Constantes.white,
              onPressed: () {
              },
            ),*/
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: _getNotificacoes(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 3.0,
                            margin: new EdgeInsets.all(3.0),
                            child: new InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Informações"),
                                        content: Text("Assunto: " +
                                            not[index].assunto +
                                            "\nMensagem: " +
                                            not[index].mensagem),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Ok"),
                                            color: Colors.blueGrey,
                                            onPressed: () {
                                              _confirmarLida(context,
                                                  not[index].idnotificacao);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: ListTile(
                                title: Text(not[index].assunto,
                                    style: TextStyle(fontSize: 20)),
                                subtitle: Text(not[index].mensagem),
                                trailing: verificarSituacao(context, index),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  listarNotas() {
    return ListView.builder(
      itemCount: not.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3.0,
          margin: new EdgeInsets.all(3.0),
          child: new InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Informações"),
                      content: Text("Assunto: " +
                          not[index].assunto +
                          "\nMensagem: " +
                          not[index].mensagem),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Ok"),
                          color: Colors.blueGrey,
                          onPressed: () {
                            _confirmarLida(context, not[index].idnotificacao);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            child: ListTile(
              title: Text(not[index].assunto, style: TextStyle(fontSize: 20)),
              subtitle: Text(not[index].mensagem),
              trailing: verificarSituacao(context, index),
            ),
          ),
        );
      },
    );
  }

  verificarSituacao(BuildContext context, index) {
    switch (not[index].situacao) {
      case '0':
        return Icon(Icons.event, color: Colors.orange);
        break;
      case '1':
        return Icon(Icons.check_box, color: Colors.green);
        break;
      case '2':
        return Icon(Icons.block, color: Colors.red);
        break;
      default:
        return Icon(Icons.event, color: Colors.orange);
        break;
    }
  }

  Future<bool> _alertaVoltar() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Atenção'),
            content: Text('Deseja voltar para o início?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                color: Colors.redAccent,
                child: Text('Não'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'principal/inicio');
                },
                color: Colors.blueGrey,
                child: Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
