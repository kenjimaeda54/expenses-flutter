import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _transactions =[
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: const  Text("Personal expenses"),
       ),
      body:  Column(
         //mesmo conceito do flex box
        //se estamos no eixo de column entao o cross eixo alinha horizontal
        //e o mainAxis alinha em coluna
        //os comportamentos sao identicos ao flex box, exemplo stretch vai espichar
        // ao maximo o filho
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children:   [
          const SizedBox(
             child:   Card(
               elevation: 5,
               color: Colors.blue,
               child: Text("Graphic"),
             ),
           ),
           Column(
             children: _transactions.map((it) => Card(
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
                               it.value.toString(),
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
                                  it.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                              ),
                              Text(
                                  it.date.toString(),
                                  style: const TextStyle(
                                    color: Colors.grey
                                  )
                              )
                           ],
                         )
                     ],
                  ),
             )).toList(),
           )
         ],
      ),
    );
  }
}
