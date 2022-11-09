import 'dart:ffi';

import "package:flutter/material.dart";

class CardGraphicBar extends StatelessWidget {
  final double percentage;
  final String value;
  final String label;

  const CardGraphicBar({
    super.key,
    required this.percentage,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("R\$$value"),
        const SizedBox(height: 5),
        Container(
          height: 60,
          width: 5,
          child: null,
        ),
        const SizedBox(height: 5),
        Text(label)
      ],
    );
  }
}
