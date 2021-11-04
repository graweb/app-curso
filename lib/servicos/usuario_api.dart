import 'dart:convert';
import 'package:easyenglish/models/usuario_api_model.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UsuarioApi {
  static Future<UsuarioApiModel> tokenApi(String email, String senha) async {
    var url = '${Constantes.urlApi}token/login';

    Map params = {"email": email, "senha": senha};

    Map<String, String> header = {"Accept": "application/json"};

    var user;
    var prefs = await SharedPreferences.getInstance();
    var response = await http.post(url, body: params, headers: header);

    if (response.statusCode == 200) {
      Map mapResponse = json.decode(response.body);
      user = UsuarioApiModel.fromJson(mapResponse);

      prefs.setString("token", mapResponse["token"]);
      prefs.setString("idusuario", mapResponse["idusuario"]);
      prefs.setString("nome", mapResponse["nome"]);
      prefs.setString("email", mapResponse["email"]);
      prefs.setString("mudar_senha", mapResponse["mudar_senha"]);
    } else {
      user = null;
    }

    return user;
  }

  static Future<UsuarioApiModel> verificarToken() async {
    var url = '${Constantes.urlApi}token/verificar_token';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    var user;
    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      Map mapResponse = json.decode(response.body);
      user = UsuarioApiModel.fromJson(mapResponse);
      prefs.setString("idusuario", mapResponse["idusuario"]);
      prefs.setString("nome", mapResponse["nome"]);
      prefs.setString("email", mapResponse["email"]);
    } else {
      user = null;
    }

    return user;
  }

  static Future<UsuarioApiModel> criar(String nome, String email) async {
    var url = '${Constantes.urlApi}usuarios/criar';

    String senha = randomNumeric(4);

    Map params = {"nome": nome, "email": email, "senha": senha};

    Map<String, String> header = {"Accept": "application/json"};

    var user;
    var response = await http.post(url, body: params, headers: header);

    if (response.statusCode == 201) {
      Map mapResponse = json.decode(response.body);
      user = UsuarioApiModel.fromJson(mapResponse);

      Map<String, String> headerEmail = {"Accept": "application/json"};

      Map msgUsuario = {
        "de": "pedagogico@faleeasy.com.br",
        "para": email,
        "nome": "Fale Easy - Inglês Fácil",
        "assunto": "Informações de acesso Fale Easy",
        "mensagem":
            "Obrigado por se cadastrar em nosso aplicativo, seus dados de acesso são: \nLogin: " +
                email +
                "\nSenha: " +
                senha
      };

      await http.post(Constantes.urlApi + "email/enviar_email",
          body: msgUsuario, headers: headerEmail);
    } else {
      user = null;
    }

    return user;
  }

  static Future<UsuarioApiModel> recuperarSenha(String email) async {
    var url = '${Constantes.urlApi}usuarios/recuperar_senha';

    String senha = randomNumeric(4);

    Map params = {"email": email, "senha": senha};

    Map<String, String> header = {"Accept": "application/json"};

    var user;
    var response = await http.post(url, body: params, headers: header);

    if (response.statusCode == 202) {
      Map mapResponse = json.decode(response.body);
      user = UsuarioApiModel.fromJson(mapResponse);

      Map msgUsuario = {
        "de": "pedagogico@faleeasy.com.br",
        "para": email,
        "nome": "Fale Easy - Inglês Fácil",
        "assunto": "Informações de acesso Fale Easy",
        "mensagem":
            "Senha alterada com sucesso. Seus dados de acesso são: \nLogin: " +
                email +
                "\nSenha: " +
                senha
      };

      await http.post(Constantes.urlApi + "email/enviar_email",
          body: msgUsuario, headers: header);
    } else {
      user = null;
    }

    return user;
  }

  static Future<UsuarioApiModel> mudarSenha(String senha) async {
    var url = '${Constantes.urlApi}usuarios/mudar_senha/';

    var prefs = await SharedPreferences.getInstance();
    String fkidusuario = (prefs.getString("idusuario") ?? "");
    String emailusuario = (prefs.getString("email") ?? "");

    Map params = {"senha": senha};

    Map<String, String> header = {"Accept": "application/json"};

    var user;
    var response =
        await http.post(url + fkidusuario, body: params, headers: header);

    if (response.statusCode == 202) {
      Map mapResponse = json.decode(response.body);
      user = UsuarioApiModel.fromJson(mapResponse);

      Map msgUsuario = {
        "de": "pedagogico@faleeasy.com.br",
        "para": emailusuario,
        "nome": "Fale Easy - Inglês Fácil",
        "assunto": "Informações de acesso Fale Easy",
        "mensagem":
            "Senha alterada com sucesso. Seus dados de acesso são: \nLogin: " +
                emailusuario +
                "\nSenha: " +
                senha
      };

      await http.post(Constantes.urlApi + "email/enviar_email",
          body: msgUsuario, headers: header);
    } else {
      user = null;
    }

    print(url + fkidusuario);

    return user;
  }

  static Future<UsuarioApiModel> logout() async {
    var url = '${Constantes.urlApi}token/logout';

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("token") ?? "");

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": token
    };

    var user;
    var response = await http.post(url, headers: header);

    if (response.statusCode == 200) {
      Map mapResponse = json.decode(response.body);
      user = UsuarioApiModel.fromJson(mapResponse);
    } else {
      user = null;
    }

    return user;
  }
}
