import 'dart:convert';
import 'package:easyenglish/models/pacote_api_model.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PacoteApi {
  static Future todosPacotesUsuario() async {
    var url = '${Constantes.urlApi}pacotes/todos_pacotes_usuario/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    return await http.get(url + fkidusuario, headers: header);
  }

  static Future detalhePacoteUsuario() async {
    var url = '${Constantes.urlApi}pacotes/detalhe_pacote_usuario/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    var user;
    var response = await http.get(url + fkidusuario, headers: header);

    if (response.statusCode == 200 || response.statusCode == 203) {
      Map mapResponse = json.decode(response.body);
      user = PacoteApiModel.fromJson(mapResponse);
    } else {
      user = null;
    }

    return user;
  }

  static Future<PacoteApiModel> criarPacote(int creditohoras) async {
    var url = '${Constantes.urlApi}pacotes/criar';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");
    String nomeusuario = (prefs.getString("nome") ?? "");
    String emailusuario = (prefs.getString("email") ?? "");

    Map params = {
      "fkidusuario": fkidusuario,
      "creditohoras": creditohoras.toString(),
      "horasconsumidas": "'0'".toString()
    };

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    var user;

    var response = await http.post(url, body: params, headers: header);

    if (response.statusCode == 201) {
      Map mapResponse = json.decode(response.body);
      user = PacoteApiModel.fromJson(mapResponse);

      Map<String, String> headerEmail = {"Accept": "application/json"};

      Map msgPacote = {
        "de": emailusuario,
        "nome": nomeusuario,
        "assunto": "Solicitação de horas pelo aluno " + nomeusuario,
        "mensagem": "O aluno " +
            nomeusuario +
            " solicitou um novo pacote com o total de " +
            creditohoras.toString() +
            "hs",
      };

      await http.post(Constantes.urlApi + "email/enviar_email",
          body: msgPacote, headers: headerEmail);
    } else {
      user = null;
    }

    return user;
  }
}
