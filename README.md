# Despesas
Aplicativo gerenciamento despesas


# Motivação
Aprender a usar  os Widget mais comuns e responsividade


## Feature
- Para realizar responsividade trabalhos muito com conceito do ternário, por exemplo, na Home  usou os dois principais componentes de conteúdo do Flutter
- CupertinoPageScaffold para IOS e Scaffold para Android
- MaterialApp serve para ambos e nele que registro minha tela principal
- CupertinoPageScaffold tem suas particularidades então começa entrar os if para atender elas 
- Para  IOS usamos gestureDetector como botoes  e o Switch existe  exite um construtor nomeado chamado adaptive 

```dart

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
		
		
		//arvore princiapl 
		
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
		
  


```

##
- Para lidar com datas o Flutter disponibiliza alguns recursos, porem outros precisei usar [intl](https://pub.dev/packages/intl) em alguns momentos
- Para instalar o pacote preciso apenas colocar no puspec.yaml e o restante e automático pela ide
- Subtrair data  usamos o substract  recurso proprio Flutter
- Formatar usou o intl 
- Para os data picker utilizei tanto material do IOS  quanto do Android
- Datapicker do android e o método  showDatePicker
- IOS usamos CupertinoDatePicker nele preciso mencionar uma altura fixa
- Para comparar data no próprio Flutter disponibiliza o isAfter, caso a data esteja no período mencionado ele retornara true

```dart
 
 //logica para comparar data
List<Transaction> get _recentTransactions {
    return _transactions
        .where((it) =>
            //ele vai retornar true se esta dentro dos sete dias
            //ou seja maior que 7  ira dar false
            //precisamos fazer isso para comparar datas
            it.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }



//para mostrar o data picker do android
 handleDatePicker(BuildContext context) {
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


//logica para ios
Widget build(BuildContext context) {
    return Platform.isIOS
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


```

##
- No momento desenvolvimento deparei com um bug por descuido 
- Funções com parâmetros e argumentos precisam de uma função anonima anterior a sua chamada () => argumento(ere)
- Se ocorrer o erro **setState() or markNeedsBuild called during build**  pode ser isso
- Trabalhei com conceito de temas, abaixo um exemplo como criar e compartilhar


```dart
 return MaterialApp(
      home: const HomeScreen(),
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
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.amber,
          )),
    );
  }

//usando tema
    Text(
           "Nenhuma transação até o momento",
            style: Theme.of(context).textTheme.titleMedium,
        ),

   FractionallySizedBox(
                    heightFactor: percentage ?? 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).primaryColor,
                      ),
                   ),


```

##
- Flutter usa muito do conceito de Widget para construir suas interfaces
- Para determinar um componente vai espichar até o seu limite existe o Expanded, Flexible
- Para componentes fracionários exite o FractionallySizedBox 
- Colocar um elemento acima do outro como fazemos com position absolute quando ha necessidade de pintar um barra ou posicionar um ícone, usamos Stack
- E para pegar o tamanho disponível internamente usamo o LayoutBuilder, com ele o meu componente saberá o máximo de espaço que ele possui
- LayoutBuilder ira retornar no segundo argumento uma propriedade que fornece a distância disponível



```dart
Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  "\$$value",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            SizedBox(
              height: constraint.maxHeight * 0.6,
              width: constraint.maxWidth * 0.2,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage ?? 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            Text(label)
          ],
        );
      },
    );
  }

```

##
- Por fim vou deixar uma reflexão sobre parâmetros opcionais, você tem a opção de usar o Late, porem ele obrigado que seja inicializado dentro  construtor
- Ideia do late e dizer que algo ira iniciar depois, mas precisa ser iniciado
- Se de fato precisa de algo opcional pode usar DateTime? 
- E para controlar os inputs usamos o conceito de controller

```dart
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



```



