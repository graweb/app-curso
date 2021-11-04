import 'package:easyenglish/servicos/agenda_api.dart';
import 'package:easyenglish/servicos/pacotes_api.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter/rendering.dart';

class Inicio extends StatefulWidget {
  @override
  _Inicio createState() => _Inicio();
}

class _Inicio extends State<Inicio> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
  }

  detalhePacoteUsuario() async {
    await Future.delayed(Duration(seconds: 2));
    return PacoteApi.detalhePacoteUsuario();
  }

  detalheAgendaUsuario() async {
    await Future.delayed(Duration(seconds: 2));
    return AgendaApi.detalheAgendaUsuario();
  }

  detalheAgendaUltiAulaUsuario() async {
    await Future.delayed(Duration(seconds: 2));
    return AgendaApi.detalheAgendaUltiAulaUsuario();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: height * 0.215,
                  color: Constantes.lightPrimary,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: height * 0.125,
                    decoration: BoxDecoration(
                      color: Constantes.azulApp,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: width * 0.07,
                  right: width * 0.07,
                  child: Container(
                    height: height * 0.16,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 5,
                            offset: Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                            top: width * 0.04,
                            bottom: width * 0.02,
                          ),
                          child: Text(
                            "Saldo",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: width * 0.05),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.05),
                              child: Container(
                                width: width * 0.6,
                                child: FutureBuilder(
                                  future: detalhePacoteUsuario(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.message ==
                                          'Registro não existe') {
                                        return Text(
                                          "0 horas",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.lightGreen[700],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35,
                                          ),
                                        );
                                      } else {
                                        if (snapshot.data.creditohoras
                                                .toString()
                                                .length ==
                                            1) {
                                          return Text(
                                            "0" +
                                                snapshot.data.creditohoras +
                                                " horas",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.lightGreen[700],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35,
                                            ),
                                          );
                                        } else {
                                          return Text(
                                            snapshot.data.creditohoras +
                                                " horas",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.lightGreen[700],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35,
                                            ),
                                          );
                                        }
                                      }
                                    } else {
                                      return Center(
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.04),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, 'principal/inicio');
                                },
                                child: Container(
                                  width: width * 0.12,
                                  height: width * 0.12,
                                  decoration: BoxDecoration(
                                    color: Constantes.azulApp,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 7,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.refresh,
                                    size: width * 0.07,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.008,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10, left: width * 0.09, right: width * 0.09),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Próxima aula",
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: width * 0.04),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10, left: width * 0.07, right: width * 0.07),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder(
                              future: detalheAgendaUsuario(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.message == null) {
                                    String anoAg =
                                        snapshot.data.dia.substring(0, 4);
                                    String mesAg =
                                        snapshot.data.dia.substring(5, 7);
                                    String diaAg =
                                        snapshot.data.dia.substring(8, 10);

                                    return Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.schedule,
                                              size: 40,
                                            ),
                                            title: Text(
                                              diaAg + "/" + mesAg + "/" + anoAg,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            subtitle: Text(
                                              snapshot.data.professor +
                                                  " de " +
                                                  snapshot.data.horainicio +
                                                  "hs até " +
                                                  snapshot.data.horafim +
                                                  "hs",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  /*FlatButton(
                                                child: Text("Cancelar", style: TextStyle(color: Constantes.white)),
                                                color: Colors.redAccent,
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text("Atenção"),
                                                        content: Text("Deseja cancelar essa aula?"),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text("Não"),
                                                            color: Colors.redAccent,
                                                            onPressed: () {
                                                              Navigator.pop(context, false);
                                                            },
                                                          ),
                                                          FlatButton(
                                                            child: Text("Sim"),
                                                            color: Colors.blueGrey,
                                                            onPressed: () {
                                                              Principal();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                  );
                                                }
                                              ),*/

                                                  SizedBox(width: 10),
                                                  FlatButton(
                                                    child: Text("Ver",
                                                        style: TextStyle(
                                                            color: Constantes
                                                                .white)),
                                                    color: Colors.blueGrey,
                                                    onPressed: () {
                                                      alerta(
                                                          context,
                                                          "Informações aula",
                                                          "Professor: " +
                                                              snapshot.data
                                                                  .professor +
                                                              "\nDia: " +
                                                              diaAg +
                                                              "/" +
                                                              mesAg +
                                                              "/" +
                                                              anoAg +
                                                              "\nDe: " +
                                                              snapshot.data
                                                                  .horainicio +
                                                              "hs\nAté: " +
                                                              snapshot.data
                                                                  .horafim +
                                                              "hs",
                                                          null);
                                                    },
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return ListTile(
                                      leading: Icon(
                                        Icons.schedule,
                                        size: 40,
                                      ),
                                      title: Text(
                                        "Atenção",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Você não tem aula confirmada",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10, left: width * 0.09, right: width * 0.09),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Informações última aula",
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: width * 0.04),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10, left: width * 0.07, right: width * 0.07),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder(
                            future: detalheAgendaUltiAulaUsuario(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.message == null) {
                                  String anoAg =
                                      snapshot.data.dia.substring(0, 4);
                                  String mesAg =
                                      snapshot.data.dia.substring(5, 7);
                                  String diaAg =
                                      snapshot.data.dia.substring(8, 10);

                                  return Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.bookmark_border,
                                              size: 40,
                                            ),
                                            title: Text(
                                              diaAg + "/" + mesAg + "/" + anoAg,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            subtitle: Text(
                                              snapshot.data.professor +
                                                  " de " +
                                                  snapshot.data.horainicio +
                                                  "hs até " +
                                                  snapshot.data.horafim +
                                                  "hs",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  FlatButton(
                                                    child: Text("Ver",
                                                        style: TextStyle(
                                                            color: Constantes
                                                                .white)),
                                                    color: Colors.blueGrey,
                                                    onPressed: () {
                                                      alerta(
                                                          context,
                                                          "Informações aula",
                                                          "Professor: " +
                                                              snapshot.data
                                                                  .professor +
                                                              "\nDia: " +
                                                              diaAg +
                                                              "/" +
                                                              mesAg +
                                                              "/" +
                                                              anoAg +
                                                              "\nDe: " +
                                                              snapshot.data
                                                                  .horainicio +
                                                              "hs\nAté: " +
                                                              snapshot.data
                                                                  .horafim +
                                                              "hs",
                                                          null);
                                                    },
                                                  ),
                                                ]),
                                          ),
                                        ]),
                                  );
                                } else {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.schedule,
                                      size: 40,
                                    ),
                                    title: Text(
                                      "Atenção",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Você não teve aula concluída",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
