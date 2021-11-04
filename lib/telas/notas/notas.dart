import 'dart:convert';
import 'package:easyenglish/models/agenda_api_model.dart';
import 'package:easyenglish/servicos/agenda_api.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Route;

class Notas extends StatefulWidget {
  @override
  _Notas createState() => _Notas();
}

class _Notas extends State<Notas> {
  var agenda = new List<AgendaApiModel>();

  _Notas() {
    _getNotas();
  }

  _getNotas() async {
    AgendaApi.todasNotasUsuario().then((response) {
      if (this.mounted) {
        setState(() {
          Iterable lista = json.decode(response.body);
          agenda =
              lista.map((model) => AgendaApiModel.fromJson(model)).toList();
        });
      } else {
        Iterable lista = json.decode(response.body);
        agenda = lista.map((model) => AgendaApiModel.fromJson(model)).toList();
      }
    });

    return agenda;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: _getNotas(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: agenda.length,
                      itemBuilder: (context, index) {
                        String ano = agenda[index].dia.substring(0, 4);
                        String mes = agenda[index].dia.substring(5, 7);
                        String dia = agenda[index].dia.substring(8, 10);

                        return Card(
                          elevation: 3.0,
                          margin: new EdgeInsets.all(3.0),
                          child: new InkWell(
                            onTap: () {
                              alerta(
                                  context,
                                  "Informações da aula",
                                  "Aplicada em: " +
                                      dia +
                                      "/" +
                                      mes +
                                      "/" +
                                      ano +
                                      "\nProfessor: " +
                                      agenda[index].professor +
                                      "\nFala: " +
                                      agenda[index].fala +
                                      "\nAudição: " +
                                      agenda[index].audicao +
                                      "\nLeitura: " +
                                      agenda[index].leitura +
                                      "\nEscrita: " +
                                      agenda[index].escrita,
                                  null);
                            },
                            child: ListTile(
                              title: Text(
                                dia + "/" + mes + "/" + ano,
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(agenda[index].professor +
                                  " - " +
                                  agenda[index].horainicio +
                                  "hs até " +
                                  agenda[index].horafim +
                                  "hs"),
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
    );
  }

  verificarSituacao(BuildContext context, index) {
    switch (agenda[index].situacao) {
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
