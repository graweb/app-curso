import 'package:easyenglish/servicos/pacotes_api.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:easyenglish/widgets/carregador.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:url_launcher/url_launcher.dart';

class SolicitarPacote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SolicitarPacoteState();
}

class _SolicitarPacoteState extends State<SolicitarPacote> {
  final _formKey = GlobalKey<FormState>();

  List<String> _pacotes = [
    '4 horas - Individual 1x',
    '8 horas - Individual 1x',
    '4 horas - Individual 1x - Recorrente',
    '8 horas - Individual 1x - Recorrente'
  ];

  String _professor;
  String _textoPacote = '';
  String _textoValor = '';
  int _tipoPlano;
  int _horasPacote;

  _criar(BuildContext context) async {
    var cadPacote = await PacoteApi.criarPacote(_horasPacote);

    if (cadPacote != null) {
      alerta(
          context,
          "Atenção",
          "Por segurança, utilizamos o meio de pagamento PagSeguro. O sistema vai abrir os dados do pacote no seu navegador.",
          'principal/pacotes');

      if (_tipoPlano == 1) {
        const urlPacote = "https://pag.ae/7VNQNzGKv";

        if (await canLaunch(urlPacote)) {
          await launch(urlPacote);
        } else {
          alerta(
              context,
              "Atenção",
              "Detectamos um erro de conexão, favor tente novamente",
              'principal/pacotes');
        }
      } else if (_tipoPlano == 2) {
        const urlPacote = "https://pag.ae/7WSkNwnNG";

        if (await canLaunch(urlPacote)) {
          await launch(urlPacote);
        } else {
          alerta(
              context,
              "Atenção",
              "Detectamos um erro de conexão, favor tente novamente",
              'principal/pacotes');
        }
      } else if (_tipoPlano == 3) {
        const urlPacote = "http://pag.ae/7Uv2o7juv";

        if (await canLaunch(urlPacote)) {
          await launch(urlPacote);
        } else {
          alerta(
              context,
              "Atenção",
              "Detectamos um erro de conexão, favor tente novamente",
              'principal/pacotes');
        }
      } else if (_tipoPlano == 4) {
        const urlPacote = "http://pag.ae/7WSkSiWYG";

        if (await canLaunch(urlPacote)) {
          await launch(urlPacote);
        } else {
          alerta(
              context,
              "Atenção",
              "Detectamos um erro de conexão, favor tente novamente",
              'principal/pacotes');
        }
      } else {
        Navigator.pushReplacementNamed(context, 'principal/pacotes');
      }
    } else {
      alerta(
          context,
          "Ooops...",
          "Suas horas ainda não foram liberadas, favor verificar com a administração.",
          'principal');
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
                        'Escolha o pacote',
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
                      onChanged: (newValue) {
                        setState(() {
                          _professor = newValue;

                          if (newValue == '4 horas - Individual 1x') {
                            _textoPacote =
                                'Aula individual 1x por semana (1hr) - 4 horas totais';
                            _textoValor = 'Total: 344,77';
                            _tipoPlano = 1;
                            _horasPacote = 4;
                          } else if (newValue == '8 horas - Individual 1x') {
                            _textoPacote =
                                'Aula individual 1x por semana (2hs) - 8 horas totais';
                            _textoValor = 'Total: 582,77';
                            _tipoPlano = 2;
                            _horasPacote = 8;
                          } else if (newValue ==
                              '4 horas - Individual 1x - Recorrente') {
                            _textoPacote =
                                'Aula individual 1x por semana (1hr) - 4 horas totais';
                            _textoValor = 'Total: 344,77';
                            _tipoPlano = 1;
                            _horasPacote = 4;
                          } else if (newValue ==
                              '8 horas - Individual 1x - Recorrente') {
                            _textoPacote =
                                'Aula individual 1x por semana (2hs) - 8 horas totais';
                            _textoValor = 'Total: 582,77';
                            _tipoPlano = 2;
                            _horasPacote = 8;
                          }
                        });
                      },
                      items: _pacotes.map((location) {
                        return DropdownMenuItem(
                          child: Text(
                            location,
                            style: TextStyle(color: Constantes.brancoApp),
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _textoPacote,
                    style: TextStyle(color: Constantes.brancoApp),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _textoValor,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constantes.verdeApp,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Valores válidos para pagamento até o dia 10 de cada mês.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constantes.begeApp,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
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
                            "Solicitar",
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
                          await Future.delayed(Duration(seconds: 5))
                              .then((onValue) {
                            _criar(context);
                            carregador(context).hide();
                          });
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
                            context, 'principal/pacotes');
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
            content: Text('Deseja voltar para a tela de pacotes?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                color: Colors.redAccent,
                child: Text('Não'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'principal/pacotes');
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
