class PacoteApiModel {
  String idalunopacote;
  String fkidusuario;
  String creditohoras;
  String horasconsumidas;
  String criadoem;
  String situacao;
  String validade;
  String message;

  PacoteApiModel({this.idalunopacote, this.fkidusuario, this.creditohoras, this.horasconsumidas, this.criadoem, this.situacao, this.validade, this.message});

  PacoteApiModel.fromJson(Map<String, dynamic> json)
      : idalunopacote = json['idalunopacote'],
        fkidusuario = json['fkidusuario'],
        creditohoras = json['creditohoras'],
        horasconsumidas = json['horasconsumidas'],
        criadoem = json['criado_em'],
        situacao = json['situacao'],
        validade = json['validade'],
        message = json['message'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['idalunopacote'] = this.idalunopacote;
    data['fkidusuario'] = this.fkidusuario;
    data['creditohoras'] = this.creditohoras;
    data['horasconsumidas'] = this.horasconsumidas;
    data['criadoem'] = this.criadoem;
    data['situacao'] = this.situacao;
    data['validade'] = this.validade;
    data['message'] = this.message;

    return data;
  }
}