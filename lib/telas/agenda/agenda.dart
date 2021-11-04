import 'dart:convert';
import 'package:easyenglish/models/agenda_api_model.dart';
import 'package:easyenglish/servicos/agenda_api.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_slidable/flutter_slidable.dart';

class Agenda extends StatefulWidget {
  @override
  _Agenda createState() => _Agenda();
}

class _Agenda extends State<Agenda> {
  var agenda = [];

  @override
  void initState() {
    super.initState();
  }

  _getAgenda() async {
    AgendaApi.todasAgendasUsuario().then((response) {
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

  _cancelarAgenda(BuildContext context, String idagenda, String horainicio,
      String horafim, String emailprofessor) async {
    var cancelarAgenda = await AgendaApi.agendaCancelar(
        idagenda, horainicio, horafim, emailprofessor);

    if (cancelarAgenda == 202) {
      alerta(context, "Atenção", "Agenda cancelada com sucesso",
          'principal/agenda');
    } else if (cancelarAgenda == 203) {
      alerta(
          context,
          "Ooops...",
          "Você não pode cancelar uma agenda com os status\n- Concluído\n- Cancelado",
          null);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Atenção'),
          content: Text(
              'A aula só pode ser cancelada com 24 horas de antecedência.\n\nDeseja continuar mesmo assim?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              color: Colors.redAccent,
              child: Text('Não'),
            ),
            FlatButton(
              onPressed: () {
                _confirmaCancelar(
                    context, idagenda, horainicio, horafim, emailprofessor);
              },
              color: Colors.blueGrey,
              child: Text('Sim'),
            ),
          ],
        ),
      );
    }
  }

  _confirmaCancelar(BuildContext context, String idagenda, String horainicio,
      String horafim, String emailprofessor) async {
    var confirmaCancelar = await AgendaApi.confirmaCancelar(
        idagenda, horainicio, horafim, emailprofessor);

    if (confirmaCancelar == 202) {
      alerta(context, "Atenção", "Agenda cancelada com sucesso",
          'principal/agenda');
    } else {
      alerta(
          context,
          "Atenção",
          "Houve um erro ao cancelar a agenda, favor tentar novamente",
          'principal/agenda');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: _getAgenda(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          //String ano = agenda[index].dia.substring(0, 4);
                          //String mes = agenda[index].dia.substring(5, 7);
                          //String dia = agenda[index].dia.substring(8, 10);

                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: Container(
                              color: Colors.white,
                              child: Card(
                                elevation: 3.0,
                                margin: EdgeInsets.all(3.0),
                                child: InkWell(
                                  onTap: () {
                                    alerta(
                                        context,
                                        "Informações agenda",
                                        "Professor: " +
                                            agenda[index].professor +
                                            "\nDia: " +
                                            agenda[index].dia +
                                            "\nDe: " +
                                            agenda[index].horainicio +
                                            "hs\nAté " +
                                            agenda[index].horafim +
                                            "hs",
                                        null);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      agenda[index].dia,
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
                              ),
                            ),
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Cancelar',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  _cancelarAgenda(
                                      context,
                                      agenda[index].idagenda,
                                      agenda[index].horainicio,
                                      agenda[index].horafim,
                                      agenda[index].emailprofessor);
                                },
                              ),
                            ],
                          );
                        });
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
      bottomNavigationBar: Stack(
        children: <Widget>[
          Container(
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/agenda.png"), fit: BoxFit.cover),
            ),
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 18, top: 30),
              child: FloatingActionButton(
                  child: Icon(Icons.add, color: Constantes.azulApp),
                  backgroundColor: Constantes.verdeApp,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'agendamento');
                  }),
            ),
          ),
        ],
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
