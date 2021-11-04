import 'dart:convert';
import 'package:easyenglish/models/agenda_api_model.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/util/email.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AgendaApi {
  static Future todasAgendasUsuario() async {
    var url = '${Constantes.urlApi}agenda/todas_agendas_usuario/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    return await http.get(url + fkidusuario, headers: header);
  }

  static Future todasNotasUsuario() async {
    var url = '${Constantes.urlApi}agenda/todas_notas_usuario/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    return await http.get(url + fkidusuario, headers: header);
  }

  static Future detalheAgendaUsuario() async {
    var url = '${Constantes.urlApi}agenda/detalhe_agenda_usuario/';

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
      user = AgendaApiModel.fromJson(mapResponse);
    } else {
      user = null;
    }

    return user;
  }

  static Future detalheAgendaUltiAulaUsuario() async {
    var url = '${Constantes.urlApi}agenda/detalhe_agenda_ultima_aula_usuario/';

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
      user = AgendaApiModel.fromJson(mapResponse);
    } else {
      user = null;
    }

    return user;
  }

  static Future listarAgendaProfessor(
      String emailprofessor, String data) async {
    String url = '${Constantes.urlApi}agenda/listar_agenda_professor/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");

    String ano = data.substring(6, 10) ?? '';
    String mes = data.substring(3, 5) ?? '';
    String dia = data.substring(0, 2) ?? '';

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    return await http.get(
        url + "/" + emailprofessor + "/" + ano + "-" + mes + "-" + dia,
        headers: header);
  }

  static Future<AgendaApiModel> criarAgenda(
      String professor,
      String emailprofessor,
      String dia,
      String horainicio,
      String horafim) async {
    var url = '${Constantes.urlApi}agenda/criar';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");
    String nomeusuario = (prefs.getString("nome") ?? "");
    String emailusuario = (prefs.getString("email") ?? "");

    String ano = dia.substring(6, 10);
    String mes = dia.substring(3, 5);
    String day = dia.substring(0, 2);

    Map params = {
      "fkidusuario": fkidusuario,
      "professor": professor,
      "dia": ano + "-" + mes + "-" + day,
      "horainicio": horainicio,
      "horafim": horafim
    };

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    var user;

    var response = await http.post(url, body: params, headers: header);

    if (response.statusCode == 201) {
      Email().sendEmail(
          nomeusuario,
          emailprofessor,
          "Agendamento de aula",
          "O aluno " +
              nomeusuario +
              " solicitou o agendamento de uma aula para o dia " +
              day +
              "/" +
              mes +
              "/" +
              ano +
              " no horário de " +
              horainicio +
              "hs até " +
              horafim +
              "hs com o professor " +
              professor,
          emailusuario);
    } else {
      user = null;
    }

    return user;
  }

  static Future agendaCancelar(String idagenda, String horainicio,
      String horafim, String emailprofessor) async {
    var url = '${Constantes.urlApi}agenda/cancelar/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String nomeusuario = (prefs.getString("nome") ?? "");
    //String emailusuario = (prefs.getString("email") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    int retornoCancelar;
    var response = await http.put(url + idagenda, headers: header);

    if (response.statusCode == 202) {
      retornoCancelar = 202;

      Map<String, String> headerEmail = {"Accept": "application/json"};

      Map msgUsuario = {
        "de": "pedagogico@faleeasy.com.br",
        "para": emailprofessor,
        "nome": "Fale Easy - Inglês Fácil",
        "assunto": "Cancelamento de aula",
        "mensagem": "O aluno " +
            nomeusuario +
            " solicitou um cancelamento, favor revisar sua agenda."
      };

      await http.post(Constantes.urlApi + "email/enviar_email",
          body: msgUsuario, headers: headerEmail);
    } else if (response.statusCode == 203) {
      retornoCancelar = 203;
    } else {
      retornoCancelar = 205;
    }

    return retornoCancelar;
  }

  static Future confirmaCancelar(String idagenda, String horainicio,
      String horafim, String emailprofessor) async {
    var url = '${Constantes.urlApi}agenda/confirma_cancelar/';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");
    String fkidusuario = (prefs.getString("idusuario") ?? "");
    String nomeusuario = (prefs.getString("nome") ?? "");
    //String emailusuario = (prefs.getString("email") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    int retornoCancelar;
    var response = await http.put(
        url + idagenda + "/" + fkidusuario + "/" + horainicio + "/" + horafim,
        headers: header);

    if (response.statusCode == 202) {
      retornoCancelar = 202;

      Map<String, String> headerEmail = {"Accept": "application/json"};

      Map msgUsuario = {
        "de": "pedagogico@faleeasy.com.br",
        "para": emailprofessor,
        "nome": "Fale Easy - Inglês Fácil",
        "assunto": "Cancelamento de aula",
        "mensagem": "O aluno " +
            nomeusuario +
            " solicitou um cancelamento, favor revisar sua agenda."
      };

      await http.post(Constantes.urlApi + "email/enviar_email",
          body: msgUsuario, headers: headerEmail);
    } else if (response.statusCode == 203) {
      retornoCancelar = 203;
    } else {
      retornoCancelar = 205;
    }

    return retornoCancelar;
  }
}
