import 'dart:convert';
import 'package:easyenglish/models/agenda_api_model.dart';
import 'package:easyenglish/servicos/agenda_api.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:easyenglish/widgets/carregador.dart';
import 'package:flutter/material.dart' hide Route;

class Horarios extends StatefulWidget {
  final String profselecionado;
  final String emailprofselecionado;
  final String diaselecionado;

  Horarios(
      {@required this.profselecionado,
      @required this.emailprofselecionado,
      @required this.diaselecionado});

  @override
  _HorariosState createState() => _HorariosState();
}

class _HorariosState extends State<Horarios> {
  var agenda = new List<AgendaApiModel>();

  @override
  void initState() {
    super.initState();
    _agendaProf();
  }

  _agendaProf() async {
    AgendaApi.listarAgendaProfessor(
            widget.profselecionado, widget.diaselecionado)
        .then((response) {
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
    return WillPopScope(
      onWillPop: _alertaVoltar,
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: _agendaProf(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if (agenda[index].horainicio == '0' &&
                              agenda[index].horafim == '0') {
                            return Card(
                              elevation: 3.0,
                              margin: new EdgeInsets.all(3.0),
                              child: new InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, 'principal/agenda');
                                },
                                child: ListTile(
                                  leading: Icon(
                                    Icons.info,
                                    size: 50,
                                    color: Colors.orange,
                                  ),
                                  title: Text(
                                    "\nO professor " +
                                        widget.profselecionado +
                                        " não possui horário disponível no dia " +
                                        widget.diaselecionado,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                      "\n\nClique aqui para tentar novamente.",
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ),
                            );
                          } else {
                            return Card(
                              elevation: 3.0,
                              margin: new EdgeInsets.all(3.0),
                              child: new InkWell(
                                onTap: () {
                                  _alertaFinalizar(
                                      context,
                                      agenda[index].horainicio,
                                      agenda[index].horafim);
                                },
                                child: ListTile(
                                  title: Text(
                                    widget.diaselecionado,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(widget.profselecionado +
                                      " - " +
                                      agenda[index].horainicio +
                                      "hs até " +
                                      agenda[index].horafim +
                                      "hs"),
                                ),
                              ),
                            );
                          }
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

  Future<bool> _alertaFinalizar(
      BuildContext context, String horinicio, String horfim) {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirmar agendamento?'),
            content: Text(
              "Professor: " +
                  widget.profselecionado +
                  "\n" +
                  "Dia: " +
                  widget.diaselecionado +
                  "\n" +
                  "Início: " +
                  horinicio +
                  "hs\n" +
                  "Fim: " +
                  horfim +
                  "hs\n\n",
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Não", style: TextStyle(color: Constantes.white)),
                color: Colors.redAccent,
              ),
              FlatButton(
                child: Text("Sim", style: TextStyle(color: Constantes.white)),
                color: Colors.blueGrey,
                onPressed: () async {
                  carregador(context).show();
                  await Future.delayed(Duration(seconds: 2)).then((onValue) {
                    carregador(context).hide();
                    var cadUser = AgendaApi.criarAgenda(
                        widget.profselecionado,
                        widget.emailprofselecionado,
                        widget.diaselecionado,
                        horinicio,
                        horfim);
                    if (cadUser != null) {
                      Navigator.pushReplacementNamed(
                          context, 'principal/agenda');
                    } else {
                      alerta(
                          context, "Ooops...", "Favor tentar novamente", null);
                    }
                  });
                },
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> _alertaVoltar() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Atenção'),
            content: Text('Deseja cancelar o agendamento?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                color: Colors.redAccent,
                child: Text('Não'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'principal/agenda');
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
