import 'package:easyenglish/telas/agenda/agenda.dart';
import 'package:easyenglish/telas/agenda/agendamento.dart';
import 'package:easyenglish/telas/aluno/aluno.dart';
import 'package:easyenglish/telas/exercicios/exercicios.dart';
import 'package:easyenglish/telas/inicio/inicio.dart';
import 'package:easyenglish/telas/lessons/lessons.dart';
import 'package:easyenglish/telas/login/cadastro_aluno.dart';
import 'package:easyenglish/telas/login/login.dart';
import 'package:easyenglish/telas/login/mudar_senha.dart';
import 'package:easyenglish/telas/login/resetar_senha.dart';
import 'package:easyenglish/telas/login/termo.dart';
import 'package:easyenglish/telas/notificacoes/notificacoes.dart';
import 'package:easyenglish/telas/pacotes/pacotes.dart';
import 'package:easyenglish/telas/pacotes/solicitar_pacote.dart';
import 'package:fluro/fluro.dart' as Fluro;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:easyenglish/telas/principal.dart';

class Rotas {
  static Fluro.Router rota = Fluro.Router();
  static Fluro.Handler _login = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Login());
  static Fluro.Handler _inicio = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Inicio());
  static Fluro.Handler _resetarsenha = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          ResetarSenha());
  static Fluro.Handler _cadastroaluno = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          CadastroAluno());
  static Fluro.Handler _mudarsenha = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          MudarSenha());
  static Fluro.Handler _termo = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Termo());
  static Fluro.Handler _pacotes = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Pacotes());
  static Fluro.Handler _solicitarpacote = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SolicitarPacote());
  static Fluro.Handler _agenda = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Agenda());
  static Fluro.Handler _agendamento = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Agendamento());

  static Fluro.Handler _principal = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return Principal(itemmenu: params["itemmenu"][0]);
  });

  static Fluro.Handler _notificacoes = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Notificacoes());
  static Fluro.Handler _aluno = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Aluno());
  static Fluro.Handler _lessons = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Lessons());
  static Fluro.Handler _exercicios = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Exercicios());

  static void iniciarRotas() {
    rota.define('login',
        transitionType: Fluro.TransitionType.fadeIn, handler: _login);
    rota.define('principal/:itemmenu',
        transitionType: Fluro.TransitionType.fadeIn, handler: _principal);
    rota.define('inicio',
        transitionType: Fluro.TransitionType.fadeIn, handler: _inicio);
    rota.define('resetarsenha',
        transitionType: Fluro.TransitionType.fadeIn, handler: _resetarsenha);
    rota.define('cadastroaluno',
        transitionType: Fluro.TransitionType.fadeIn, handler: _cadastroaluno);
    rota.define('mudarsenha',
        transitionType: Fluro.TransitionType.fadeIn, handler: _mudarsenha);
    rota.define('termo',
        transitionType: Fluro.TransitionType.fadeIn, handler: _termo);
    rota.define('pacotes',
        transitionType: Fluro.TransitionType.fadeIn, handler: _pacotes);
    rota.define('solicitarpacote',
        transitionType: Fluro.TransitionType.fadeIn, handler: _solicitarpacote);
    rota.define('agenda',
        transitionType: Fluro.TransitionType.fadeIn, handler: _agenda);
    rota.define('agendamento',
        transitionType: Fluro.TransitionType.fadeIn, handler: _agendamento);
    rota.define('notificacoes',
        transitionType: Fluro.TransitionType.fadeIn, handler: _notificacoes);
    rota.define('aluno',
        transitionType: Fluro.TransitionType.fadeIn, handler: _aluno);
    rota.define('lessons',
        transitionType: Fluro.TransitionType.fadeIn, handler: _lessons);
    rota.define('exercicios',
        transitionType: Fluro.TransitionType.fadeIn, handler: _exercicios);
  }
}
