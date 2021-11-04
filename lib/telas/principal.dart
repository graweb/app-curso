import 'package:easyenglish/models/notificacoes_api_model.dart';
import 'package:easyenglish/servicos/notificacoes_api.dart';
import 'package:easyenglish/servicos/usuario_api.dart';
import 'package:easyenglish/telas/agenda/agenda.dart';
import 'package:easyenglish/telas/inicio/inicio.dart';
import 'package:easyenglish/telas/notas/notas.dart';
import 'package:easyenglish/telas/pacotes/pacotes.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:easyenglish/widgets/carregador.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Principal extends StatefulWidget {
  final String itemmenu;

  Principal({@required this.itemmenu});

  @override
  _Principal createState() => _Principal();
}

class _Principal extends State<Principal> {
  int _currentIndex = 0;

  String usuarioLogado;

  Future<NotificacoesApiModel> contaNotificacoes;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var iniciarNotificacaoAndroid;
  var iniciarNotificacaoIos;
  var iniciarNotificacao;

  @override
  void initState() {
    super.initState();
    pegarUsuLogado();
    contaNotificacoes = NotificacoesApi.contarNotificacoesUsuario();

    switch (widget.itemmenu) {
      case 'inicio':
        _currentIndex = 0;
        break;
      case 'pacotes':
        _currentIndex = 1;
        break;
      case 'agenda':
        _currentIndex = 2;
        break;
      case 'notas':
        _currentIndex = 3;
        break;
      case 'lessons':
        _currentIndex = 4;
        break;
      default:
        _currentIndex = 0;
        break;
    }

    iniciarNotificacaoAndroid = new AndroidInitializationSettings('app_icon');
    iniciarNotificacaoIos = new IOSInitializationSettings();
    iniciarNotificacao = new InitializationSettings(
        android: iniciarNotificacaoAndroid, iOS: iniciarNotificacaoIos);
    flutterLocalNotificationsPlugin.initialize(iniciarNotificacao);
  }

  Future _exibirNotificacao(String mensagem) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, "Atenção", "Você tem mensagens não lidas", platformChannelSpecifics);
  }

  pegarUsuLogado() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      usuarioLogado = (prefs.getString("nome") ?? "");
    });
  }

  final List<Widget> _children = [
    Inicio(),
    Pacotes(),
    Agenda(),
    Notas(),
    //Lessons()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  _logout(BuildContext context) async {
    var tokenApi = await UsuarioApi.logout();

    if (tokenApi == null) {
      alerta(context, "Ooops...", "Desculpe.\nFavor, tente novamente", null);
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  calcularTotalNotificacoes() {
    return FutureBuilder<NotificacoesApiModel>(
        future: contaNotificacoes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.total.toString() != "0") {
              _exibirNotificacao(snapshot.data.mensagem);
            }
            return Text(
              snapshot.data.total,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Constantes.white),
            );
          }
          return CircularProgressIndicator(
            backgroundColor: Colors.white,
          );
        });
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
            Padding(
                padding: EdgeInsets.only(top: 16),
                child: calcularTotalNotificacoes()),
            IconButton(
              icon: Icon(
                Icons.message,
                size: 25,
              ),
              color: Constantes.brancoApp,
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'notificacoes');
              },
            ),
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 25,
              ),
              color: Constantes.white,
              onPressed: () {
                _alertaVoltar();
              },
            ),
          ],
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).primaryColor,
            primaryColor: Constantes.azulApp,
            textTheme: Theme.of(context).textTheme.copyWith(
                  caption: TextStyle(color: Colors.grey[600]),
                ),
          ),
          child: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.monetization_on), label: "Pacotes"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: "Agenda"),
              BottomNavigationBarItem(icon: Icon(Icons.school), label: "Notas"),
              //BottomNavigationBarItem(icon: Icon(Icons.book), label: "Lessons"),
            ],
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
            content: Text('Deseja sair do sistema?'),
            actions: <Widget>[
              FlatButton(
                color: Colors.redAccent,
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Não'),
              ),
              FlatButton(
                color: Colors.blueGrey,
                onPressed: () async {
                  carregador(context).show();
                  await Future.delayed(Duration(seconds: 2)).then((onValue) {
                    carregador(context).hide();
                    _logout(context);
                  });
                },
                child: Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
