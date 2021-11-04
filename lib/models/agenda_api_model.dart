class AgendaApiModel {
  String idagenda;
  String fkidusuario;
  String professor;
  String dia;
  String horainicio;
  String horafim;
  String materia;
  String fala;
  String audicao;
  String leitura;
  String escrita;
  String situacao;
  String message;
  String emailprofessor;

  AgendaApiModel(
      {this.idagenda,
      this.fkidusuario,
      this.professor,
      this.dia,
      this.horainicio,
      this.horafim,
      this.materia,
      this.fala,
      this.audicao,
      this.leitura,
      this.escrita,
      this.situacao,
      this.message,
      this.emailprofessor});

  AgendaApiModel.fromJson(Map<String, dynamic> json)
      : idagenda = json['idagenda'],
        fkidusuario = json['fkidusuario'],
        professor = json['professor'],
        dia = json['dia'],
        horainicio = json['horainicio'],
        horafim = json['horafim'],
        materia = json['materia'],
        fala = json['fala'],
        audicao = json['audicao'],
        leitura = json['leitura'],
        escrita = json['escrita'],
        situacao = json['situacao'],
        message = json['message'],
        emailprofessor = json['emailprofessor'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['idagenda'] = this.idagenda;
    data['fkidusuario'] = this.fkidusuario;
    data['professor'] = this.professor;
    data['dia'] = this.dia;
    data['horainicio'] = this.horainicio;
    data['horafim'] = this.horafim;
    data['materia'] = this.materia;
    data['fala'] = this.fala;
    data['audicao'] = this.audicao;
    data['leitura'] = this.leitura;
    data['escrita'] = this.escrita;
    data['situacao'] = this.situacao;
    data['message'] = this.message;
    data['emailprofessor'] = this.emailprofessor;

    return data;
  }
}
