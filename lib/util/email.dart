import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Email {
  sendEmail(String remetente, String para, String assunto, String mensagem,
      String emailAluno) async {
    String username = 'faleeasy@hotmail.com';
    String password = 'F@leEasy2021';

    final smtpServer = hotmail(username, password);
    //final smtpServer = gmail(username, password);

    final message = new Message()
      ..from = new Address(username, remetente)
      ..recipients.add(para)
      ..ccRecipients.addAll([emailAluno, 'pedagogico@faleeasy.com.br'])
      //..bccRecipients.add(new Address('bccAddress@example.com'))
      ..subject = assunto
      ..text = ''
      ..html = "<h3>Atenção</h3>\n<p>$mensagem</p>";
    await send(message, smtpServer, catchExceptions: false);
  }
}
