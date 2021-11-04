import 'dart:convert';
import 'package:easyenglish/models/aluno_api_model.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AlunoApi {
  static Future detalheAluno() async {
    var url = '${Constantes.urlApi}alunos/detalhe/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    return await http.get(url + fkidusuario, headers: header);
  }

  static Future<AlunoApiModel> atualizarAluno(
      String cpf,
      String celular,
      String datanascimento,
      String cep,
      String uf,
      String cidade,
      String bairro,
      String tipologradouro,
      String logradouro,
      String numero) async {
    var url = '${Constantes.urlApi}alunos/atualizar/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");

    String ano = datanascimento.substring(6, 10);
    String mes = datanascimento.substring(3, 5);
    String day = datanascimento.substring(0, 2);

    Map params = {
      "cpf": "$cpf",
      "celular": "$celular",
      "datanascimento": "$ano - $mes - $day",
      "cep": "$cep",
      "uf": "$uf",
      "cidade": "$cidade",
      "bairro": "$bairro",
      "tipologradouro": "$tipologradouro",
      "logradouro": "$logradouro",
      "numero": "$numero"
    };

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    var user;

    var response =
        await http.post(url + fkidusuario, body: params, headers: header);

    if (response.statusCode == 202) {
      Map mapResponse = json.decode(response.body);
      user = AlunoApiModel.fromJson(mapResponse);
    } else {
      user = null;
    }

    return user;
  }
}
