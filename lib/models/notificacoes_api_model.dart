class NotificacoesApiModel {
  String idnotificacao;
  String fkidusuario;
  String assunto;
  String mensagem;
  String situacao;
  String total;

  NotificacoesApiModel({this.idnotificacao, this.fkidusuario, this.assunto, this.mensagem, this.situacao, this.total});

  NotificacoesApiModel.fromJson(Map<String, dynamic> json)
      : idnotificacao = json['idnotificacao'],
        fkidusuario = json['fkidusuario'],
        assunto = json['assunto'],
        mensagem = json['mensagem'],
        situacao = json['situacao'],
        total = json['total'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['idnotificacao'] = this.idnotificacao;
    data['fkidusuario'] = this.fkidusuario;
    data['assunto'] = this.assunto;
    data['mensagem'] = this.mensagem;
    data['situacao'] = this.situacao;
    data['total'] = this.total;

    return data;
  }
}