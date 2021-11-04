class UsuarioApiModel {
  String token;
  String idusuario;
  String nome;
  String email;
  String senha;

  UsuarioApiModel({this.idusuario, this.token, this.nome, this.email, this.senha});

  UsuarioApiModel.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        idusuario = json['idusuario'],
        nome = json['nome'],
        email = json['email'],
        senha = json['senha'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['token'] = this.token;
    data['idusuario'] = this.idusuario;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;

    return data;
  }
}