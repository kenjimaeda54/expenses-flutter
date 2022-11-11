import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class CardTransactions extends StatelessWidget {
  final String value;
  final String title;
  final String date;

  const CardTransactions({
    super.key,
    required this.value,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          //quem vai determinar o tamnho do circulo e o radius
          radius: 40,
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: FittedBox(
              child: Text(
                "\$$value",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        title: Text(title),
        subtitle: Text(date),
      ),
    );
  }
}
