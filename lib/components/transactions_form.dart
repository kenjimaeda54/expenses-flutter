import "package:flutter/material.dart";

//quadno o text field nao conseguir persistir o formulario quando inserido o valor
//e porque precisa ser um tipo statefull
class TransactionsForm extends StatefulWidget {
  const TransactionsForm(this.handleSubmit, {super.key});
  final void Function({required String title,required String value}) handleSubmit;

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

//quando e um compoennte do tipo de StatefulWidget
//recebo os parametros aqui no state por heranca no widget
class _TransactionsFormState extends State<TransactionsForm> {
  //Vars
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child:   Column(
        children:  [
          TextField(
            controller: titleController,
            //o widget tera acesso a todos parametros recebidos nessa classe
            onSubmitted: (_)=> widget.handleSubmit(title: titleController.text,value: valueController.text),
            decoration: const InputDecoration(
                labelText: "Title"
            ),
          ),
          TextField(
            controller: valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_)=> widget.handleSubmit(title: titleController.text,value: valueController.text),
            decoration: const InputDecoration(
              labelText: "Value (R\$)",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: ()=> widget.handleSubmit(title: titleController.text,value:  valueController.text),
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
