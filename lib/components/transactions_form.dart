import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_textField.dart';
import 'package:expenses/components/adptative_datePicker.dart';
import "package:flutter/material.dart";

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

  handleDatePicker(DateTime date) {
    setState(() {
      dateSelected = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          AdpatativeTextField(
            controllerType: titleController,
            textPlaceHolder: "Title",
            submiTed: (_) => widget.handleSubmit(
                title: titleController.text,
                value: valueController.text,
                dateTime: dateSelected),
          ),
          const SizedBox(
            height: 10,
          ),
          AdpatativeTextField(
            textPlaceHolder: "Value (R\$)",
            controllerType: valueController,
            submiTed: (_) => widget.handleSubmit(
                title: titleController.text,
                value: valueController.text,
                dateTime: dateSelected),
          ),
          AdaptativeDatePicker(
              dateSelected: dateSelected!,
              onChangeDate: (date) => handleDatePicker(date)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AdaptativeButton(
                text: "New transctions",
                pressed: () => widget.handleSubmit(
                    title: titleController.text,
                    value: valueController.text,
                    dateTime: dateSelected),
              )
            ],
          )
        ],
      ),
    );
  }
}
