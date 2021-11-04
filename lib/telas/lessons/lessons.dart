import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/carregador.dart';
import 'package:flutter/material.dart' hide Route;

class Lessons extends StatefulWidget {
  @override
  _Lessons createState() => _Lessons();
}

class _Lessons extends State<Lessons> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      color: Constantes.lightBG,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Constantes.azulApp,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Student Book",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              onPressed: () async {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Constantes.azulApp,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "WorkBook",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              onPressed: () async {
                carregador(context).show();
                await Future.delayed(Duration(seconds: 2)).then((onValue) {
                  carregador(context).hide();
                  Navigator.pushReplacementNamed(
                      context, 'principal/exercicios');
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
