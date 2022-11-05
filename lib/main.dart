import 'package:flutter/material.dart';
import './components/transaction_user.dart';

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
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children:   const [
          SizedBox(
             child:   Card(
               elevation: 5,
               color: Colors.blue,
               child: Text("Graphic"),
             ),
           ),
           TransactionUser(),
         ],
        
      ),
    );
  }
}
