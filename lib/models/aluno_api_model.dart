class AlunoApiModel {
  String idaluno;
  String fkidusuario;
  String cpf;
  String celular;
  String nivel;
  String datanascimento;
  String cep;
  String uf;
  String cidade;
  String bairro;
  String tipologradouro;
  String logradouro;
  String numero;

  AlunoApiModel({this.idaluno, this.fkidusuario, this.cpf, this.celular, this.nivel, this.datanascimento, this.cep, this.uf, this.cidade, this.bairro, 
  this.tipologradouro, this.logradouro, this.numero});

  AlunoApiModel.fromJson(Map<String, dynamic> json)
      : idaluno = json['idaluno'],
        fkidusuario = json['fkidusuario'],
        cpf = json['cpf'],
        celular = json['celular'],
        nivel = json['nivel'],
        datanascimento = json['datanascimento'],
        cep = json['cep'],
        uf = json['uf'],
        cidade = json['cidade'],
        bairro = json['bairro'],
        tipologradouro = json['tipologradouro'],
        logradouro = json['logradouro'],
        numero = json['numero'];
}