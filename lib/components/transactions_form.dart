import "package:flutter/material.dart";

class TransactionsForm extends StatelessWidget {
  //Vars
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function({required String title,required String value}) hanldeSubmit;

  TransactionsForm(this.hanldeSubmit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child:   Column(
        children:  [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
                labelText: "Title"
            ),
          ),
          TextField(
            controller: valueController,
            decoration: const InputDecoration(
              labelText: "Value (R\$)",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: ()=> hanldeSubmit(title: titleController.text,value:  valueController.text),
                  child: const Text(
                    "New transactions",
                    style: TextStyle(
                        color: Colors.purple
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
