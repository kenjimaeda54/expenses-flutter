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
        //com esse tamanho garonto que o texto havera uma alterara fixa e nao mais conforme
        //container
        SizedBox(
          height: 13,
          child: FittedBox(
            //para que o texto diinua para caber dentor do container
            child: Text(
              "\$$value",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        ),
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
                      color: Colors.grey, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage ?? 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
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
