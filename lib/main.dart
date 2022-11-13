import 'dart:math';
import 'dart:io';
import 'package:expenses/components/card-graphic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    //serve tanto no cupertino quanto material dart
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
                ),
              ),
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
  final List<Transaction> _transactions = [];
  bool showGraphic = false;

  //setState() or markNeedsBuild called during build
  //se acontecer isso de uma olhada se o botao nao esta chamando uma funcao
  //com parametro sem ter uma funcao vazia
  //() => funcao()
  //se estiver assim pode dar erro
  //  funcao()
  void _handleAddTransactions(
      {required String title, required String value, DateTime? dateTime}) {
    final valueFormated = double.tryParse(value) ?? 0;

    if (title.isEmpty || valueFormated <= 0 || dateTime == null) {
      return;
    }

    final newTransactions = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: valueFormated,
        date: dateTime);

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

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((it) => it.id == id);
    });
  }

  _renderGraphicOrList(bool value) {
    setState(() {
      showGraphic = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget getIconButton(IconData icon, void Function() press) {
      return Platform.isIOS
          ? Row(children: [
              Text(showGraphic ? "List" : "Graphic"),
              //swtich.adpative vai mudar conforme a plataforma
              Switch.adaptive(
                activeColor: Theme.of(context).colorScheme.secondary,
                value: showGraphic,
                onChanged: _renderGraphicOrList,
              ),
              GestureDetector(
                onTap: press,
                child: Icon(icon, size: 20),
              ),
            ])
          : Row(children: [
              Text(showGraphic ? "List" : "Graphic"),
              //swtich.adpative vai mudar conforme a plataforma
              Switch.adaptive(
                activeColor: Theme.of(context).colorScheme.secondary,
                value: showGraphic,
                onChanged: _renderGraphicOrList,
              ),
              IconButton(onPressed: press, icon: Icon(icon, size: 20)),
            ]);
    }

    //app bar

    //altura disponivel total  - padding acima que o status bar - tamanho do app bar
    final avaibleHeigth =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    //COMPONENTE  principal abaixo do app bar
    final contentMain = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        //mesmo conceito do flex box
        //se estamos no eixo de column entao o cross eixo alinha horizontal
        //e o mainAxis alinha em coluna
        //os comportamentos sao identicos ao flex box, exemplo stretch vai espichar
        // ao maximo o filho
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          showGraphic
              ? SizedBox(
                  width: double.infinity,
                  child: SizedBox(
                      height: avaibleHeigth * 0.25,
                      child: CardGraphic(_recentTransactions)),
                )
              : SizedBox(
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
                              height: 200,
                              child: //o contain precisa saber o tamanho do container
                                  //se a imagem for maior que o container pai ir gerar overlow
                                  Image.asset(
                                "assets/images/waiting.png",
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        )
                      : SizedBox(
                          height: avaibleHeigth * 0.75,
                          child: ListView.builder(
                              itemCount: _transactions.length,
                              itemBuilder: (ctx, index) {
                                final it = _transactions[index];
                                return CardTransactions(
                                    value: it.value.toStringAsFixed(2),
                                    title: it.title,
                                    removeTransaction: () =>
                                        _removeTransaction(it.id),
                                    date:
                                        DateFormat("d MMM y").format(it.date));
                              }),
                        ),
                ),
        ],
      ),
    ));

    //arvore principal
    return Platform.isIOS
        //scaffold para cupertino
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 13),
                child: const Text(
                  "Personal expenses",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                getIconButton(Icons.add, () => _handleOpenModal(context))
              ]),
            ),
            child: contentMain,
          )
        //scaffold para material dart
        : Scaffold(
            appBar: AppBar(
              title: const Text("Personal expenses"),
              actions: [
                getIconButton(Icons.add, () => _handleOpenModal(context))
              ],
            ),
            body: contentMain,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _handleOpenModal(context),
              child: const Icon(
                Icons.add,
                size: 35,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
