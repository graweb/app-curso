import 'dart:convert';
import 'package:easyenglish/models/pacote_api_model.dart';
import 'package:easyenglish/servicos/pacotes_api.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:flutter/material.dart' hide Route;

class Pacotes extends StatefulWidget {
  @override
  _Pacotes createState() => _Pacotes();
}

class _Pacotes extends State<Pacotes> {
  var alunosControle = new List<PacoteApiModel>();

  @override
  void initState() {
    super.initState();
  }

  _getPacotesAluno() async {
    PacoteApi.todosPacotesUsuario().then((response) {
      if (this.mounted) {
        setState(() {
          Iterable lista = json.decode(response.body);
          alunosControle =
              lista.map((model) => PacoteApiModel.fromJson(model)).toList();
        });
      } else {
        Iterable lista = json.decode(response.body);
        alunosControle =
            lista.map((model) => PacoteApiModel.fromJson(model)).toList();
      }
    });

    return alunosControle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                  future: _getPacotesAluno(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: alunosControle.length,
                        itemBuilder: (context, index) {
                          String ano =
                              alunosControle[index].criadoem.substring(0, 4);
                          String mes =
                              alunosControle[index].criadoem.substring(5, 7);
                          String dia =
                              alunosControle[index].criadoem.substring(8, 10);

                          String anoVal =
                              alunosControle[index].validade.substring(0, 4);
                          String mesVal =
                              alunosControle[index].validade.substring(5, 7);
                          String diaVal =
                              alunosControle[index].validade.substring(8, 10);

                          return Card(
                            elevation: 3.0,
                            margin: new EdgeInsets.all(4.0),
                            child: new InkWell(
                              onTap: () {
                                alerta(
                                    context,
                                    "Informações pacote",
                                    "Solicitado em: " +
                                        dia +
                                        "/" +
                                        mes +
                                        "/" +
                                        ano +
                                        "\nSaldo: " +
                                        alunosControle[index]
                                            .creditohoras
                                            .toString() +
                                        "hs \nHoras consumidas: " +
                                        alunosControle[index]
                                            .horasconsumidas
                                            .toString() +
                                        "hs \nValidade: " +
                                        diaVal +
                                        "/" +
                                        mesVal +
                                        "/" +
                                        anoVal,
                                    null);
                              },
                              child: ListTile(
                                title: Text(
                                    "Solicitado em: " +
                                        dia +
                                        "/" +
                                        mes +
                                        "/" +
                                        ano,
                                    style: TextStyle(fontSize: 17)),
                                subtitle: Text("Saldo: " +
                                    alunosControle[index]
                                        .creditohoras
                                        .toString() +
                                    " - Horas consumidas: " +
                                    alunosControle[index]
                                        .horasconsumidas
                                        .toString()),
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
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        children: <Widget>[
          Container(
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/pacotes.png"), fit: BoxFit.cover),
            ),
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 18, top: 30),
              child: FloatingActionButton(
                  child: Icon(Icons.add, color: Constantes.azulApp),
                  backgroundColor: Constantes.verdeApp,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'solicitarpacote');
                  }),
            ),
          ),
        ],
      ),
    );
  }

  verificarSituacao(BuildContext context, index) {
    switch (alunosControle[index].situacao) {
      case '1':
        return Icon(Icons.check, color: Colors.blue[700]);
        break;
      case '2':
        return Icon(Icons.check_box, color: Colors.green);
        break;
      case '3':
        return Icon(Icons.block, color: Colors.red);
        break;
      default:
        return Icon(Icons.event, color: Colors.orange);
        break;
    }
  }
}
