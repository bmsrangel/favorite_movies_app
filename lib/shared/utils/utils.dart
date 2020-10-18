import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message,
      Function onPressed) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: "Gerenciar Favoritos",
        textColor: Colors.white,
        onPressed: () => onPressed(),
      ),
    ));
  }
}
