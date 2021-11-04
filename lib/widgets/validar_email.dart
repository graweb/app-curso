import 'package:flutter/material.dart' hide Route;

bool validarEmail(BuildContext context, String email) {
  bool validarEmail = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return validarEmail;
}
