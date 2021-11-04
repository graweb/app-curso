import 'dart:convert';
import 'package:easyenglish/models/notificacoes_api_model.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificacoesApi {
  static Future notificacoesUsuario() async {
    var url = '${Constantes.urlApi}notificacoes/detalhe_notificacao_usuario/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    return await http.get(url + fkidusuario, headers: header);
  }

  static Future<NotificacoesApiModel> contarNotificacoesUsuario() async {
    var url = '${Constantes.urlApi}notificacoes/contar_notificacao_usuario/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    var response = await http.get(url + fkidusuario, headers: header);

    if (response.statusCode == 200) {
      return NotificacoesApiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('erro');
    }
  }

  static Future confirmarLida(String idnotificacao) async {
    var url = '${Constantes.urlApi}notificacoes/marcar_como_lida/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    int retornoCancelar;
    var response = await http.put(url + idnotificacao, headers: header);

    if (response.statusCode == 202) {
      retornoCancelar = 202;
    } else if (response.statusCode == 203) {
      retornoCancelar = 203;
    }

    return retornoCancelar;
  }
}
