import 'package:flutter/material.dart' hide Route;

alerta(BuildContext context, String titulo, String msg, String link) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              color: Colors.blueGrey,
              onPressed: () {
                if (link == null) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(context, link);
                }
              },
            ),
          ],
        );
      });
}
