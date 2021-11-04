import 'dart:convert';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easyenglish/telas/agenda/horarios.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:easyenglish/widgets/carregador.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Agendamento extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AgendamentoState();
}

class _AgendamentoState extends State<Agendamento> {
  final _formKey = GlobalKey<FormState>();

  final _diacontroller = MaskedTextController(mask: '00/00/0000');
  final _formataData = DateFormat("dd/MM/yyyy");

  List _professores = List();
  String _professor;

  @override
  void initState() {
    super.initState();
    this._getProfessores();
  }

  Future<String> _getProfessores() async {
    final String url = '${Constantes.urlApi}usuarios/professores';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    var res = await http.get(url, headers: header);
    var resBody = json.decode(res.body);

    setState(() {
      _professores = resBody;
    });

    return _professores.toString();
  }

  _avancar(BuildContext context) {
    if (_professor == null || _professor == "") {
      alerta(context, "Ooops", "Selecione um professor", null);
    } else if (_diacontroller.text == null || _diacontroller.text == "") {
      alerta(context, "Ooops", "Selecione um dia", null);
    } else {
      List<String> _prof = _professor.split('-');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Horarios(
              profselecionado: _prof[0],
              emailprofselecionado: _prof[1],
              diaselecionado: _diacontroller.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _alertaVoltar,
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.all(30),
              color: Constantes.azulApp,
              child: ListView(
                children: <Widget>[
                  Container(
                    child: DropdownButton(
                      hint: Text(
                        'Escolha o professor',
                        style: TextStyle(color: Constantes.brancoApp),
                      ),
                      value: _professor,
                      dropdownColor: Constantes.azulApp,
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Constantes.brancoApp,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Constantes.brancoApp,
                      ),
                      items: _professores.map((item) {
                        return DropdownMenuItem(
                          child: new Text(
                            item['nome'],
                            style: TextStyle(color: Constantes.brancoApp),
                          ),
                          value: item['nome'] + "-" + item['email'],
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          if (newValue != null) {
                            _professor = newValue;
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Selecione o Dia',
                    style: TextStyle(color: Constantes.brancoApp),
                  ),
                  DateTimeField(
                    format: _formataData,
                    controller: _diacontroller,
                    style: TextStyle(color: Constantes.brancoApp),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        return date;
                      } else {
                        return currentValue;
                      }
                    },
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
                            "Avançar",
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
                          //if(_diacontroller.text.substring(0,2) == DateTime.now().day.toString()) {
                          //  alerta(context, "Atenção", "Não existem horários disponíveis para essa data", null);
                          //}
                          //else
                          //{
                          carregador(context).show();
                          Future.delayed(Duration(seconds: 2)).then((onValue) {
                            carregador(context).hide();
                            _avancar(context);
                          });
                          //}
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
                        "Cancelar",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Constantes.brancoApp),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, 'principal/agenda');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
