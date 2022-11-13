import "dart:io";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdpatativeTextField extends StatelessWidget {
  final TextEditingController controllerType;
  final Function(String) submiTed;
  final String textPlaceHolder;
  final TextInputType? inputType;

  AdpatativeTextField(
      {super.key,
      required this.textPlaceHolder,
      required this.controllerType,
      required this.submiTed,
      this.inputType});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controllerType,
            onSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            keyboardType: inputType,
            placeholder: textPlaceHolder,
          )
        : TextField(
            controller: controllerType,
            //o widget tera acesso a todos parametros recebidos nessa classe
            onSubmitted: submiTed,
            keyboardType: inputType,
            decoration: InputDecoration(labelText: textPlaceHolder),
          );
  }
}
