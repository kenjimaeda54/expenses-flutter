import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String text;
  final Function() pressed;

  const AdaptativeButton(
      {super.key, required this.text, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: pressed,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            color: Theme.of(context).primaryColor,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ))
        : ElevatedButton(
            onPressed: pressed,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple)),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          );
  }
}
