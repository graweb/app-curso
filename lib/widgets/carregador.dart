import 'package:flutter/material.dart' hide Route;
import 'package:progress_dialog/progress_dialog.dart';

carregador(BuildContext context) {
  ProgressDialog progressBar;
  progressBar = new ProgressDialog(context, type: ProgressDialogType.Normal);

  progressBar.style(
      message: 'Aguarde...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

  return progressBar;
}
