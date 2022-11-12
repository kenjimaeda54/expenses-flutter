import "package:flutter/material.dart";
import 'package:intl/intl.dart';

//quadno o text field nao conseguir persistir o formulario quando inserido o valor
//e porque precisa ser um tipo statefull
class TransactionsForm extends StatefulWidget {
  const TransactionsForm(this.handleSubmit, {super.key});

  final void Function(
      {required String title,
      required String value,
      DateTime? dateTime}) handleSubmit;

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

//quando e um compoennte do tipo de StatefulWidget
//recebo os parametros aqui no state por heranca no widget
class _TransactionsFormState extends State<TransactionsForm> {
  //Vars
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime? dateSelected = DateTime.now();

  _showDatePicker() {
    //dentro de state recebo o contexto por herenaca
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((datePicker) {
      if (datePicker != null) {
        setState(() {
          dateSelected = datePicker;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextField(
            controller: titleController,
            //o widget tera acesso a todos parametros recebidos nessa classe
            onSubmitted: (_) => widget.handleSubmit(
                title: titleController.text,
                value: valueController.text,
                dateTime: dateSelected),
            decoration: const InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => widget.handleSubmit(
                title: titleController.text,
                value: valueController.text,
                dateTime: dateSelected),
            decoration: const InputDecoration(
              labelText: "Value (R\$)",
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
            child: Row(
              children: [
                //com expanded empurro ate o final o choose date
                Expanded(
                  child: Text(dateSelected == null
                      ? "Not date selected"
                      : "Date: ${DateFormat("dd/MM/yy").format(dateSelected!)}"),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: const Text("Choose Date",
                      style: TextStyle(color: Colors.purple, fontSize: 17)),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.purple)),
                  onPressed: () => widget.handleSubmit(
                      title: titleController.text,
                      value: valueController.text,
                      dateTime: dateSelected),
                  child: const Text(
                    "New transactions",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
