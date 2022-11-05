import 'dart:math';

import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "../models/transaction.dart";
import 'card_transactions.dart';
import 'package:expenses/components/transactions_form.dart';


class TransactionUser extends StatefulWidget {
  const TransactionUser({Key? key}) : super(key: key);

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
        id: "t1",
        title: "New running shoes",
        value: 310.76,
        date: DateTime.now()
    ),
    Transaction(
        id: "t2",
        title: "Electricity bill",
        value: 211.30,
        date: DateTime.now()
    ),
  ];

  void _handleAddTransactions({required String  title,required String value}) {
     final valueFormated = double.tryParse(value) ?? 0;

     final newTransactions = Transaction(
         id: Random().nextDouble().toString(),
         title: title,
         value: valueFormated,
         date: DateTime.now()
     );

     setState(() {
       _transactions.add(newTransactions);
     });
     
  }


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [..._transactions.map((it) => CardTransactions(
         value: it.value.toStringAsFixed(2),
          title: it.title,
          date: DateFormat("d MMM y").format(it.date)
      )).toList(),
      TransactionsForm(_handleAddTransactions),
    ],
    );
  }
}
