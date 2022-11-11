import 'package:expenses/components/card-graphic-bar.dart';
import 'package:intl/intl.dart';
import "../models/transaction.dart";
import 'package:flutter/material.dart';

class CardGraphic extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const CardGraphic(this.recentTransactions, {super.key});

  //lembrando que getter e como se fosse uma funcao precisa ser acionado o groupTransacitons para retornar os valores
  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      var sumValueTransactions = 0.0;
      //vamos subtrari conforme o index que esta sendo gerado pela lista
      //e identico pegar o dia de hoje substrair -1 , -2
      final weekDays = DateTime.now().subtract(Duration(days: index));

      for (final it in recentTransactions) {
        //se o dia de hoje bater com o dia da lista posso somar
        final day = weekDays.day == it.date.day;
        final month = weekDays.month == it.date.month;
        final year = weekDays.year == it.date.year;

        if (day && month && year) {
          sumValueTransactions += it.value;
        }
      }

      return {
        //pegando a primeira letra do dia da semana
        //formato local
        //https://api.flutter.dev/flutter/intl/DateFormat/DateFormat.E.html
        //formatado pelo local no caso Brasil
        "day": DateFormat.E().format(weekDays)[0],
        "value": sumValueTransactions
      };
    }).reversed.toList();
  }

  double get _wekTotalValue {
    //fold e identico ao reduce
    return groupTransactions.fold(
        0.0, (previousValue, it) => previousValue + (it["value"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: groupTransactions.map((it) {
          //se for usar flexibele o pai e o proprio flex
          //https://www.fluttercampus.com/guide/229/incorrect-use-of-parentdatawidget-error/

          //no andorid tem a opcao swap parent
          return Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: CardGraphicBar(
                  percentage: it["value"] as double > 0.0
                      ? (it["value"] as double) / _wekTotalValue
                      : 0,
                  value: (it["value"] as double).toStringAsFixed(2),
                  label: it["day"] as String),
            ),
          );
        }).toList(),
      ),
    );
  }
}
