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
    return LayoutBuilder(
      //constraint e o espaco interno que preciso
      builder: (context, constraint) {
        return Column(
          children: [
            //com esse tamanho garonto que o texto havera uma alterara fixa e nao mais conforme
            //container
            SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                //para que o texto diinua para caber dentor do container
                child: Text(
                  "\$$value",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            SizedBox(
              height: constraint.maxHeight * 0.6,
              width: constraint.maxWidth * 0.2,
              //sobrepopr um elemento em cima do outro
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid),
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
            SizedBox(height: constraint.maxHeight * 0.05),
            Text(label)
          ],
        );
      },
    );
  }
}
