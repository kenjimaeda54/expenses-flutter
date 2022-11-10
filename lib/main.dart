import 'package:expenses/components/card-graphic.dart';
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
  final List<Transaction> _transactions = [
    Transaction(
        id: "3",
        title: "agaua",
        value: 3203,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: "2",
        title: "feijao",
        value: 323,
        date: DateTime.now().subtract(Duration(days: 13))),
    Transaction(
        id: "3",
        title: "carne",
        value: 13,
        date: DateTime.now().subtract(Duration(days: 1))),
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
    //criando modal
    showModalBottomSheet(
        context: context,
        builder: (_) => TransactionsForm(_handleAddTransactions));
  }

  //criando um getter para pegar as trnasicoes recentes
  List<Transaction> get _recentTransactions {
    return _transactions
        .where((it) =>
            //ele vai retornar true se esta dentro dos sete dias
            //ou seja maior que 7  ira dar false
            //precisamos fazer isso para comparar datas
            it.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
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
            SizedBox(
              width: double.infinity,
              child: CardGraphic(_recentTransactions),
            ),
            SizedBox(
              height: 300,
              //repara que o ternario fica apos o child pois ele espera um filho
              //nao dentro do list view,pois list view ira usar o transactions
              child: _transactions.isEmpty
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Nenhuma transação até o momento",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 220,
                          child: //o contain precisa saber o tamanho do container
                              //se a imagem for maior que o container pai ir gerar overlow
                              Image.asset(
                            "assets/images/waiting.png",
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                    )
                  : ListView.builder(
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
