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
        SizedBox(
          height: 60,
          width: 10,
          //sobrepopr um elemento em cima do outro
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    color: const Color.fromRGBO(220, 220, 200, 1),
                    borderRadius: BorderRadius.circular(5)),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(label)
      ],
    );
  }
}
