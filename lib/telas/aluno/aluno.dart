import 'dart:convert';
import 'package:easyenglish/models/aluno_api_model.dart';
import 'package:easyenglish/servicos/aluno_api.dart';
import 'package:easyenglish/util/constantes.dart';
import 'package:easyenglish/widgets/alerta.dart';
import 'package:easyenglish/widgets/carregador.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Aluno extends StatefulWidget {
  @override
  _Aluno createState() => _Aluno();
}

class _Aluno extends State<Aluno> {
  final _formKey = GlobalKey<FormState>();

  final cpfController = MaskedTextController(mask: '000.000.000-00');
  final celularController = MaskedTextController(mask: '(00) 00000-0000');
  final nivelController = TextEditingController();
  final dataNascimentoController = MaskedTextController(mask: '00/00/0000');
  final cepController = MaskedTextController(mask: '00000-000');
  final ufController = TextEditingController();
  final cidadeController = TextEditingController();
  final bairroController = TextEditingController();
  final tipoLogradouroController = TextEditingController();
  final logradouroController = TextEditingController();
  final numeroController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAluno();
  }

  var infoAluno = new List<AlunoApiModel>();

  _getAluno() async {
    AlunoApi.detalheAluno().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        infoAluno = list.map((model) => AlunoApiModel.fromJson(model)).toList();
      });
    });
  }

  _atualizar(BuildContext context) async {
    var cadUser = await AlunoApi.atualizarAluno(
        cpfController.text,
        celularController.text,
        dataNascimentoController.text,
        cepController.text,
        ufController.text,
        cidadeController.text,
        bairroController.text,
        tipoLogradouroController.text,
        logradouroController.text,
        numeroController.text);

    if (cadUser != null) {
      alerta(context, "Atenção", "Atualizado com sucesso", null);
    } else {
      alerta(context, "Ooops...", "Favor tentar novamente", null);
    }
  }

  Widget _imagemFundo() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/fundo_aluno.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: 130.0,
          height: 130.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/usuario.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(
              color: Colors.grey,
              width: 8.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: infoAluno.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                _imagemFundo(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: cpfController,
                    decoration: InputDecoration.collapsed(
                      hintText: infoAluno[index].cpf.isEmpty
                          ? "CPF"
                          : infoAluno[index].cpf,
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: celularController,
                    decoration: InputDecoration.collapsed(
                      hintText: infoAluno[index].celular.isEmpty
                          ? "Celular"
                          : infoAluno[index].celular,
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: dataNascimentoController,
                    decoration: InputDecoration.collapsed(
                      hintText: infoAluno[index].datanascimento.isEmpty
                          ? "Data Nascimento"
                          : infoAluno[index].datanascimento,
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: cepController,
                    decoration: InputDecoration.collapsed(
                      hintText: infoAluno[index].cep.isEmpty
                          ? "CEP"
                          : infoAluno[index].cep,
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: ufController,
                    decoration: InputDecoration.collapsed(
                      hintText: infoAluno[index].uf.isEmpty
                          ? "UF"
                          : infoAluno[index].uf,
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: cidadeController,
                    decoration: InputDecoration.collapsed(
                      hintText: infoAluno[index].cidade.isEmpty
                          ? "Cidade"
                          : infoAluno[index].cidade,
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: bairroController,
                    decoration: InputDecoration.collapsed(
                      hintText: infoAluno[index].bairro.isEmpty
                          ? "Bairro"
                          : infoAluno[index].bairro,
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: tipoLogradouroController,
                    decoration: InputDecoration.collapsed(
                      hintText: infoAluno[index].tipologradouro.isEmpty
                          ? "Rua, Avenida, Travessa..."
                          : infoAluno[index].tipologradouro,
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: logradouroController,
                    decoration: InputDecoration.collapsed(
                      hintText: infoAluno[index].logradouro.isEmpty
                          ? "Logradouro"
                          : infoAluno[index].logradouro,
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Constantes.brancoApp,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: numeroController,
                    decoration: InputDecoration.collapsed(
                      hintText: infoAluno[index].numero.isEmpty
                          ? "Número"
                          : infoAluno[index].numero,
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, 'principal/inicio'),
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Constantes.brancoApp),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "VOLTAR",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                carregador(context).show();
                                await Future.delayed(Duration(seconds: 2))
                                    .then((onValue) {
                                  carregador(context).hide();
                                  _atualizar(context);
                                });
                              }
                            },
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: Constantes.azulApp,
                              ),
                              child: Center(
                                child: Text(
                                  "SALVAR",
                                  style: TextStyle(
                                    color: Constantes.brancoApp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
