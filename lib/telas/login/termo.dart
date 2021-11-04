import 'package:flutter/material.dart' hide Route;
import 'package:easyenglish/widgets/alerta.dart';
import 'package:easyenglish/util/constantes.dart';

class Termo extends StatefulWidget {
  @override
  _Termo createState() => _Termo();
}

class _Termo extends State<Termo> {
  @override
  initState() {
    super.initState();
  }

  bool _termo = false;

  void _termoMarcado(bool value) => setState(() => _termo = value);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SafeArea(
        top: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Align(
                        alignment: Alignment(0.7, -0.5),
                        child: Text(
                          "\n\nOlá. Bem-vindo aos termos e condições de uso do Easy App e dos Termos de Contrato "
                          "para os serviços do Easy – Inglês Fácil. Os Termos abaixo dispostos são importantes pois "
                          "eles: \n\n"
                          "● Indicam seus direitos legais com o Easy – Inglês Fácil \n"
                          "● Explicam os direitos que você nos concede ao usar o Easy App \n"
                          "● Descrevem as regras que todos precisam seguir ao usar o Easy App \n\n"
                          "Por favor leia estes Termos, nossa Política de Privacidade e quaisquer outros termos "
                          "mencionados neste documento com cuidado. \n\n"
                          "IDENTIFICAÇÃO DAS PARTES CONTRATANTES \n\n"
                          "Você está contratando um dos pacotes de aulas do Curso Easy – Inglês Fácil, e afirma "
                          "que os dados inseridos nesse aplicativo são verdadeiros e serão utilizados para garantir "
                          "o acordo entre as partes. \n\n"
                          "Nós, o Easy – Inglês Fácil, somos um curso com sede na cidade do Rio de Janeiro, na Rua "
                          "Tasso Blaso 930, Bl 02 apt. 304, bairro Santa Cruz, Cep 23520286, no Estado Rio de "
                          "Janeiro, inscrita no CNPJ sob o n° 12.481.598/0001-67, neste ato representado pelo seu "
                          "proprietário Isaque Gomes Lima, Brasileiro, Solteiro, Empresário, Carteira de Identidade "
                          "nº 012887538-2, CPF n° 096.351.917-40, residente e domiciliado na cidade do Rio de "
                          "Janeiro, na Rua Tasso Blaso 930, Bl 02 apt. 304, bairro Santa Cruz, Cep 23520286. \n\n"
                          "As partes acima identificadas têm, entre si, justo e acertado o presente Contrato de "
                          "Prestação de Serviços, que se regerá pelas cláusulas seguintes e pelas condições de "
                          "preço, forma e termo de pagamento descritas no presente. \n\n"
                          "OBJETO DO CONTRATO \n\n"
                          "Cláusula 1ª. \n"
                          "É objeto do presente contrato a prestação do serviço de Ensino do Idioma Inglês, na "
                          "categoria Individual online, estando cientes o CONTRATADO e a CONTRATANTE da "
                          "descrição do serviço contratado, na modalidade selecionado pelo CONTRATANTE, bem "
                          "como seu número de horas/aula, valor referente ao pagamento dessas aulas, validade "
                          "do pacote de aulas e forma de ministração das aulas, que podem ser: A) Online \n\n"
                          "OBRIGAÇÕES DO CONTRATANTE \n\n"
                          "Cláusula 2ª. \n"
                          "O CONTRATANTE deverá fornecer ao CONTRATADO todas as informações necessárias "
                          "à realização do serviço, devendo especificar os detalhes necessários à perfeita "
                          "consecução do mesmo, e a forma de como ele deve ser entregue / executado, não "
                          "transpondo o projeto pedagógico educacional da linha de trabalho da empresa. \n\n"
                          "Cláusula 3ª. \n"
                          "O CONTRATANTE deverá efetuar o pagamento na forma e condições estabelecidas na \n"
                          "Cláusula 7ª. \n\n"
                          "OBRIGAÇÕES DO CONTRATADO \n\n"
                          "Cláusula 4ª. \n"
                          "É dever do CONTRATADO oferecer ao contratante a cópia do presente instrumento, "
                          "contendo todas as especificidades da prestação de serviço contratada. \n\n"
                          "Cláusula 5ª. \n"
                          "O CONTRATADO não está obrigado a fornecer Nota Fiscal de Serviços, referente "
                          "ao(s)pagamento(s) efetuado(s) pelo CONTRATANTE. \n\n"
                          "Cláusula 6ª. \n"
                          "É responsabilidade do CONTRATADO os atos e/ou omissões praticados por seus "
                          "empregados/prepostos e outros prestadores de serviços, bem como pelos danos de "
                          "qualquer natureza que os mesmos venham a sofrer ou causar para o contratante, em "
                          "decorrência da prestação de serviço prestada neste contrato. \n\n"
                          "DO PREÇO E DAS CONDIÇÕES DE PAGAMENTO \n\n"
                          "Cláusula 7ª. \n"
                          "O presente serviço será remunerado pela quantia informada no campo de compra de "
                          "pacotes de aulas e será respeitado o valor descrito no ato da compra, referente aos "
                          "serviços efetivamente prestados, já devidamente subtraído possíveis descontos ou "
                          "abatimentos, devendo ser pago em parcela única, com a prévia concordância de ambas "
                          "as partes, em uma das seguintes formas: Boleto Bancário, Transferência Bancária "
                          "(Favorecido: Isaque Gomes Lima - Banco Itaú. Agência 8207 – Conta Corrente 29509-1), "
                          "ou Cartão de crédito via link do pagseguro pelo aplicativo.\n\n"
                          "As aulas serão iniciadas após a confirmação de pagamento integral do pacote "
                          "contratado, nas especificações acima. \n\n"
                          "DA RESCISÃO IMOTIVADA \n\n"
                          "Cláusula 8ª. \n"
                          "Poderá o presente instrumento ser rescindido pela CONTRATANTE, em qualquer "
                          "momento, desde que comunicada por escrito através do endereço de correio eletrônico "
                          "contato@faleeasy.com.br com 24 horas de antecedência. \n\n"
                          "DO PRAZO \n\n"
                          "Cláusula 9ª. \n"
                          "Os pacotes de aulas possuem prazos de validade específicos e é de responsabilidade da "
                          "CONTRATANTE estar ciente desses prazos, de modo a concluir o total de horas até a "
                          "data de término, atentando o mesmo para o limite de 3 horas/aula por dia. Segue as "
                          "validades: A) Pacote de 4 hora: 30 dias de validade. B) Pacote de 8 horas: 30 dias de "
                          "validade. C) Pacote de 12 horas: 30 dias de validade. \n\n"
                          "DAS CONDIÇÕES GERAIS \n\n"
                          "Cláusula 10ª. \n"
                          "Se a CONTRATANTE quiser adquirir um novo pacote, estando o atual ainda em vigência, "
                          "a validade dos pacotes será somada, sendo válido os termos do novo contrato. \n\n"
                          "Cláusula 11ª. \n"
                          "As faltas, cancelamentos ou reagendamentos das aulas previamente marcadas, deverá "
                          "ser feitas pelo CONTRATANTE a CONTRADA através do aplicativo ou pelo e-mail "
                          "contato@faleeasy.com.br com antecedência mínima de 24 horas, que será confirmado "
                          "o recebimento pela CONTRATANTE. A efetivação da solicitação do CONTRATANTE está "
                          "sujeita a disponibilidade de agenda dos professores e de confirmação de remarcação "
                          "por aplicativo ou por mensagem via e-mail da CONTRATADA. \n\n"
                          "Cláusula 12ª. \n"
                          "Caso a CONTRATANTE não possa assistir à aula e não solicitar a alteração com a "
                          "antecedência citado na cláusula 13ª, automaticamente a aula será computada como "
                          "realizada. \n\n"
                          "Cláusula 13ª. \n"
                          "O novo período será considerado a partir da efetiva realização da aula reagendada entre "
                          "as partes. \n\n"
                          "Cláusula 14ª. \n"
                          "Na aula individual, haverá tolerância de 15 (quinze) minutos para o início da aula caso a "
                          "CONTRATANTE ainda não tenha chegado e será contabilizado como falta não justificada "
                          "o respectivo atraso. A aula será contabilizada como realizada, caso seja confirmada a "
                          "ausência sem justificativa prévia. \n\n"
                          "Cláusula 15ª. \n"
                          "Atrasos gerados pela CONTRATADA superior a 30 minutos adiciona 1 (uma) hora de aula "
                          "ao banco de horas da CONTRATANTE. Na aula individual Online, se porventura o "
                          "professor chegar após o horário de início estipulado com a CONTRATANTE, aquele "
                          "compensará os minutos de atraso de modo a completar o tempo de aula combinado "
                          "entre as partes. Se uma das partes não tiver disponibilidade e não puder exceder o "
                          "horário de término, a aula será finalizada no horário previamente combinado e os "
                          "minutos faltantes serão adicionados ao banco de horas do CONTRATANTE, formando "
                          "um crédito a ser utilizado posteriormente, dentro do prazo de validade do contrato. \n\n"
                          "Cláusula 16ª. \n"
                          "É dever da CONTRATANTE a realização de exercícios de casa e das atividades "
                          "extraclasse. \n\n"
                          "Cláusula 17ª. \n"
                          "A omissão na realização dos exercícios influenciará negativamente no rendimento da "
                          "CONTRATANTE, consequentemente compromete a emissão do respectivo certificado "
                          "de conclusão do curso. \n\n"
                          "Cláusula 18ª. \n"
                          "A CONTRATANTE tem o direito de desistência a ser exercido no prazo de 7 (sete) dias "
                          "corridos a partir da assinatura do presente contrato sem ônus algum. Em caso de "
                          "pagamento já realizado, o valor será devolvido integralmente. \n\n"
                          "Cláusula 19ª. \n"
                          "A CONTRATANTE autoriza o recebimento de informações financeiras, pedagógicas e "
                          "comerciais por e-mails, mensagens via aplicativo, mensagens instantâneas, redes "
                          "sociais, pelo Easy App ou quaisquer outros meios de comunicação, desde que respeitado "
                          "o sigilo e privacidade deste. \n\n"
                          "Cláusula 20ª. \n"
                          "A CONTRATANTE está ciente dos termos deste contrato é que esta, consoante as "
                          "normas estabelecidas pelo Código de Defesa do Consumidor, elegem o fórum da Cidade "
                          "do Rio de Janeiro para dirimir qualquer questão que venha a surgir decorrente deste "
                          "contrato. \n\n"
                          "Cláusula 21ª. \n"
                          "Por estarem assim justos e contratados, confirmo que li e aceito os termos desse "
                          "contrato. \n\n"
                          "Obrigado por ler nossos Termos. Esperamos que você aproveite o Easy App!",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    value: _termo,
                    onChanged: _termoMarcado,
                    title: Text('Aceitar termo'),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Constantes.azulApp,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Constantes.verdeApp,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Continuar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        if (_termo == false) {
                          alerta(
                              context,
                              "Ooops...",
                              "Você precisa aceitar o termo para continuar",
                              null);
                        } else {
                          Navigator.pushReplacementNamed(
                              context, 'cadastroaluno');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
