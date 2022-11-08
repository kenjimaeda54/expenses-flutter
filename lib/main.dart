import 'package:flutter/material.dart';
import 'dart:math';
import "package:intl/intl.dart";
import "../models/transaction.dart";
import '../components/card_transactions.dart';
import '../components/transactions_form.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      //theme
      //https://stackoverflow.com/questions/69289005/accentcolor-is-deprecated-and-shouldnt-be-used
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
                  titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 19,
              )),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 19,
            fontWeight: FontWeight.bold,
          )),
          //estou criando um colorScheme a partir do from Swatch
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.amber,
          )),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _transactions = [
    Transaction(
        id: "t1",
        title: "New running shoes",
        value: 310.76,
        date: DateTime.now()),
    Transaction(
        id: "t2",
        title: "Electricity bill",
        value: 211.30,
        date: DateTime.now()),
  ];

  //setState() or markNeedsBuild called during build
  //se acontecer isso de uma olhada se o botao nao esta chamando uma funcao
  //com parametro sem ter uma funcao vazia
  //() => funcao()
  //se estiver assim pode dar erro
  //  funcao()
  void _handleAddTransactions({required String title, required String value}) {
    final valueFormated = double.tryParse(value) ?? 0;

    if (title.isEmpty || valueFormated <= 0) {
      return;
    }

    final newTransactions = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: valueFormated,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransactions);
    });

    Navigator.of(context).pop();
  }

  _handleOpenModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => TransactionsForm(_handleAddTransactions));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal expenses"),
        actions: [
          IconButton(
              onPressed: () => _handleOpenModal(context),
              icon: const Icon(
                Icons.add,
                size: 20,
              ))
        ],
      ),
      //este compoenente se estiver fora do Scaffold ira precisar de uma altera definada
      //se nao ira acusar overflow

      //agora minha screen tem capacidade de fazer um scrooll
      body: SingleChildScrollView(
        child: Column(
          //mesmo conceito do flex box
          //se estamos no eixo de column entao o cross eixo alinha horizontal
          //e o mainAxis alinha em coluna
          //os comportamentos sao identicos ao flex box, exemplo stretch vai espichar
          // ao maximo o filho
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              child: Card(
                elevation: 5,
                color: Colors.blue,
                child: Text("Graphic"),
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (ctx, index) {
                    final it = _transactions[index];
                    return CardTransactions(
                        value: it.value.toStringAsFixed(2),
                        title: it.title,
                        date: DateFormat("d MMM y").format(it.date));
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleOpenModal(context),
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
