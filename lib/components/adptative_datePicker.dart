import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final Function(DateTime) onChangeDate;
  final DateTime dateSelected;

  const AdaptativeDatePicker(
      {super.key, required this.dateSelected, required this.onChangeDate});

  handleDatePicker(BuildContext context) {
    //dentro de state recebo o contexto por herenaca
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((datePicker) {
      if (datePicker != null) {
        onChangeDate(datePicker);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        //cupertino precisa de uma altura fixa
        ? SizedBox(
            height: 150,
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minimumDate: DateTime(2020),
                maximumDate: DateTime.now(),
                initialDateTime:
                    DateTime.now().subtract(const Duration(days: 6)),
                onDateTimeChanged: onChangeDate),
          )
        : Container(
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
                  onPressed: () => handleDatePicker(context),
                  child: const Text("Choose Date",
                      style: TextStyle(color: Colors.purple, fontSize: 17)),
                )
              ],
            ),
          );
  }
}
