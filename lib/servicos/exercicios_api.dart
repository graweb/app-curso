import 'dart:convert';
import 'package:easyenglish/models/livros.dart';
import 'package:easyenglish/models/exercicios.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Exercicios>> getQuestions(
    Livros category, int total, String difficulty) async {
  var url = '${Constantes.urlApi}exercicios';

  var prefs = await SharedPreferences.getInstance();
  String token = (prefs.getString("token") ?? "");

  Map<String, String> header = {
    "Accept": "application/json",
    "Authorization": token
  };

  http.Response res = await http.get(url, headers: header);
  List<Map<String, dynamic>> questions =
      List<Map<String, dynamic>>.from(json.decode(res.body)["results"]);
  return Exercicios.fromData(questions);
}
