import 'dart:io';
import 'package:easyenglish/models/livros.dart';
import 'package:easyenglish/models/exercicios.dart';
import 'package:easyenglish/servicos/exercicios_api.dart';
import 'package:easyenglish/telas/exercicios/erro.dart';
import 'package:easyenglish/telas/exercicios/quiz.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:flutter/material.dart';

class QuizOpcoesDialog extends StatefulWidget {
  final Livros category;

  const QuizOpcoesDialog({Key key, this.category}) : super(key: key);

  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<QuizOpcoesDialog> {
  int _noOfQuestions;
  String _difficulty;
  bool processing;

  @override
  void initState() {
    super.initState();
    _noOfQuestions = 10;
    _difficulty = "facil";
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade200,
            child: Text(
              widget.category.name,
              style: Theme.of(context).textTheme.subtitle2.copyWith(),
            ),
          ),
          SizedBox(height: 10.0),
          Text("Selecione a quantidade de questões"),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 16.0,
              spacing: 16.0,
              children: <Widget>[
                SizedBox(width: 0.0),
                ActionChip(
                  label: Text("10"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _noOfQuestions == 10
                      ? Constantes.azulApp
                      : Colors.grey.shade600,
                  onPressed: () => _selectNumberOfQuestions(10),
                ),
                ActionChip(
                  label: Text("20"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _noOfQuestions == 20
                      ? Constantes.azulApp
                      : Colors.grey.shade600,
                  onPressed: () => _selectNumberOfQuestions(20),
                ),
                ActionChip(
                  label: Text("30"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _noOfQuestions == 30
                      ? Constantes.azulApp
                      : Colors.grey.shade600,
                  onPressed: () => _selectNumberOfQuestions(30),
                ),
                ActionChip(
                  label: Text("40"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _noOfQuestions == 40
                      ? Constantes.azulApp
                      : Colors.grey.shade600,
                  onPressed: () => _selectNumberOfQuestions(40),
                ),
                ActionChip(
                  label: Text("50"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _noOfQuestions == 50
                      ? Constantes.azulApp
                      : Colors.grey.shade600,
                  onPressed: () => _selectNumberOfQuestions(50),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Text("Selecione a dificuldade"),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 16.0,
              spacing: 16.0,
              children: <Widget>[
                SizedBox(width: 0.0),
                ActionChip(
                  label: Text("Todos"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _difficulty == null
                      ? Constantes.azulApp
                      : Colors.grey.shade600,
                  onPressed: () => _selectDifficulty(null),
                ),
                ActionChip(
                  label: Text("Fácil"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _difficulty == "facil"
                      ? Constantes.azulApp
                      : Colors.grey.shade600,
                  onPressed: () => _selectDifficulty("facil"),
                ),
                ActionChip(
                  label: Text("Médio"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _difficulty == "meio"
                      ? Constantes.azulApp
                      : Colors.grey.shade600,
                  onPressed: () => _selectDifficulty("meio"),
                ),
                ActionChip(
                  label: Text("Difícil"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _difficulty == "dificil"
                      ? Constantes.azulApp
                      : Colors.grey.shade600,
                  onPressed: () => _selectDifficulty("dificil"),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          processing
              ? CircularProgressIndicator()
              : RaisedButton(
                  child: Text("Começar"),
                  textColor: Constantes.white,
                  onPressed: _startQuiz,
                  color: Constantes.azulApp,
                ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  _selectNumberOfQuestions(int i) {
    setState(() {
      _noOfQuestions = i;
    });
  }

  _selectDifficulty(String s) {
    setState(() {
      _difficulty = s;
    });
  }

  void _startQuiz() async {
    setState(() {
      processing = true;
    });
    try {
      List<Exercicios> questions =
          await getQuestions(widget.category, _noOfQuestions, _difficulty);
      Navigator.pop(context);
      if (questions.length < 1) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => Erro(
                  message:
                      "Não existem questões registradas, favor entre em contato com a administração",
                )));
        return;
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Quiz(
                    questions: questions,
                    category: widget.category,
                  )));
    } on SocketException catch (_) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => Erro(
                    message:
                        "Ooops houve um erro, \n Favor, verifique sua internet.",
                  )));
    } catch (e) {
      print(e.message);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => Erro(
                    //message: "Desculpe, houve um erro interno na API",
                    message: "Desculpe, estamos desenvolvendo essa área",
                  )));
    }
    setState(() {
      processing = false;
    });
  }
}
