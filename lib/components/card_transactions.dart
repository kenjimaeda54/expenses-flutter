import "package:flutter/material.dart";

class CardTransactions extends StatelessWidget {

  final  String value;
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
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.purple,
                    width: 2
                )
            ),
            child: Text(
              "R\$ $value",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                  date,
                  style: const TextStyle(
                      color: Colors.grey
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
