import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

enum TransactionType {Return , Give }

class Transaction {
  String customerName;
  double amount;
  TransactionType type;
  DateTime dateTime;
  String phoneNumber;

  Transaction({
    required this.customerName,
    required this.amount,
    required this.type,
    required this.dateTime,
    required this.phoneNumber,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: Text('Khata App'),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> allTransactions = [
    // Transaction(customerName: 'John Doe', amount: 100.0, type: TransactionType.Income, dateTime: DateTime.now(), phoneNumber: '1234567890'),
    //Transaction(customerName: 'Jane Doe', amount: 50.0, type: TransactionType.Expense, dateTime: DateTime.now(), phoneNumber: '9876543210'),
    // Add more transactions as needed
  ];

  late List<Transaction> displayedTransactions;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedTransactions = List.from(allTransactions);
    searchController.addListener(() {
      filterSearchResults(searchController.text);
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      displayedTransactions = allTransactions
          .where((transaction) => transaction.customerName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addTransaction(String customerName, double amount, TransactionType type, DateTime dateTime, String phoneNumber) {
    setState(() {
      allTransactions.add(Transaction(
        customerName: customerName,
        amount: amount,
        type: type,
        dateTime: dateTime,
        phoneNumber: phoneNumber,
      ));
      filterSearchResults(searchController.text);
    });
  }

  void _updateTransaction(int index, String customerName, double amount, TransactionType type, DateTime dateTime, String phoneNumber) {
    setState(() {
      allTransactions[index] = Transaction(
        customerName: customerName,
        amount: amount,
        type: type,
        dateTime: dateTime,
        phoneNumber: phoneNumber,
      );
      filterSearchResults(searchController.text);
    });
  }

  void _deleteTransaction(int index) {
    setState(() {
      allTransactions.removeAt(index);
      filterSearchResults(searchController.text);
    });
  }

  double _calculateTotal(TransactionType type) {
    double total = 0.0;

    for (Transaction transaction in allTransactions) {
      if (transaction.type == type) {
        total += transaction.amount;
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Udhar_Book_App',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration:BoxDecoration(border: Border.all(color: Colors.red,width: 3),
                        borderRadius: BorderRadius.circular(20),),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\RS:${_calculateTotal(TransactionType.Return).toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                          SizedBox(height: 10),
                          Text(
                            'Return',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 25),
                    Container(
                      height: 100,
                      width: 150,
                      decoration:BoxDecoration(border: Border.all(color: Colors.blue,width: 3),
                        borderRadius: BorderRadius.circular(20),),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text('\RS:${_calculateTotal(TransactionType.Give).toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black) ),
                          SizedBox(height: 15),
                          Text(
                            'Give',
                            style: TextStyle(fontSize: 15 , color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),



              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // height: 100,
              //width: 150,
              //decoration:BoxDecoration(border: Border.all(color: Colors.green,width: 3),
              //borderRadius: BorderRadius.circular(40),),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40,),
                    borderSide: BorderSide(
                      color: Colors.blueGrey, // Border color
                      width: 3.0,          // Border width
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedTransactions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(displayedTransactions[index].customerName[0]),
                  ),
                  title: Text(displayedTransactions[index].customerName),
                  subtitle: Text(
                    '\RS:${displayedTransactions[index].amount.toStringAsFixed(2)} - ${displayedTransactions[index].dateTime}\n${displayedTransactions[index].customerName} - ${displayedTransactions[index].phoneNumber}',
                  ),
                  trailing: Icon(
                    displayedTransactions[index].type == TransactionType.Return
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: displayedTransactions[index].type == TransactionType.Return
                        ? Colors.black
                        : Colors.deepPurple,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateTransactionPage(
                          transaction: displayedTransactions[index],
                          onUpdate: (String customerName, double amount, TransactionType type, DateTime dateTime, String phoneNumber) {
                            int originalIndex = allTransactions.indexOf(displayedTransactions[index]);
                            _updateTransaction(originalIndex, customerName, amount, type, dateTime, phoneNumber);
                            Navigator.pop(context);
                          },
                          onDelete: () {
                            int originalIndex = allTransactions.indexOf(displayedTransactions[index]);
                            _deleteTransaction(originalIndex);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionPage(
                onAdd: (String customerName, double amount, TransactionType type, DateTime dateTime, String phoneNumber) {
                  _addTransaction(customerName, amount, type, dateTime, phoneNumber);
                  Navigator.pop(context);
                },
              ),
            ),);
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.deepPurpleAccent
          ),
          child: Center(child: Text('Add',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }
}

class AddTransactionPage extends StatefulWidget {
  final Function(String customerName, double amount, TransactionType type, DateTime dateTime, String phoneNumber) onAdd;

  AddTransactionPage({required this.onAdd});

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  String customerName = '';
  double amount = 0.0;
  TransactionType selectedType = TransactionType.Give;
  DateTime selectedDateTime = DateTime.now();
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                customerName = value;
              },
              decoration: InputDecoration(labelText: 'Customer_Name',border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40,),
                borderSide: BorderSide(
                  color: Colors.blueGrey, // Border color
                  width: 3.0,          // Border width
                ),
              ),),
            ),
            SizedBox(height: 10,),
            TextField(
              onChanged: (value) {
                amount = double.tryParse(value) ?? 0.0;
              },
              decoration: InputDecoration(labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40,),
                  borderSide: BorderSide(
                    color: Colors.blueGrey, // Border color
                    width: 3.0,          // Border width
                  ),
                ),),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10,),
            TextField(
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: InputDecoration(labelText: 'Phone_No',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40,),
                  borderSide: BorderSide(
                    color: Colors.blueGrey, // Border color
                    width: 3.0,          // Border width
                  ),
                ),),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Payment Type '),
                SizedBox(width: 40),
                DropdownButton<TransactionType>(
                  value: selectedType,
                  onChanged: (TransactionType? value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                  items: TransactionType.values
                      .map<DropdownMenuItem<TransactionType>>(
                        (TransactionType value) {
                      return DropdownMenuItem<TransactionType>(
                        value: value,
                        child: Text(value == TransactionType.Return ? 'Return' : 'Give'),
                      );
                    },
                  )
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('Date and Time:'),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDateTime = await showDatePicker(
                      context: context,
                      initialDate: selectedDateTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDateTime != null) {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        selectedDateTime = DateTime(
                          pickedDateTime.year,
                          pickedDateTime.month,
                          pickedDateTime.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      }
                    }
                  },
                  child: Text('Select Date and Time'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          widget.onAdd(customerName, amount, selectedType, selectedDateTime, phoneNumber);
        },
        child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                color: Colors.deepPurpleAccent),
            child: Center(child: Text('Add'))),
      ),
    );
  }
}

class UpdateTransactionPage extends StatefulWidget {
  final Transaction transaction;
  final Function(String customerName, double amount, TransactionType type, DateTime dateTime, String phoneNumber) onUpdate;
  final VoidCallback onDelete;

  UpdateTransactionPage({
    required this.transaction,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  _UpdateTransactionPageState createState() => _UpdateTransactionPageState();
}

class _UpdateTransactionPageState extends State<UpdateTransactionPage> {
  late String customerName;
  late double amount;
  late TransactionType selectedType;
  late DateTime selectedDateTime;
  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    customerName = widget.transaction.customerName;
    amount = widget.transaction.amount;
    selectedType = widget.transaction.type;
    selectedDateTime = widget.transaction.dateTime;
    phoneNumber = widget.transaction.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: customerName),
              onChanged: (value) {
                customerName = value;
              },
              decoration: InputDecoration(labelText: 'Customer Name',border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Colors.blueGrey, // Border color
                  width: 3.0,          // Border width
                ),
              ),),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: TextEditingController(text: amount.toString()),
              onChanged: (value) {
                amount = double.tryParse(value) ?? 0.0;
              },
              decoration: InputDecoration(labelText: 'Amount',border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Colors.blueGrey, // Border color
                  width: 3.0,          // Border width
                ),
              ),),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10,),
            TextField(
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: InputDecoration(labelText: 'Phone_No',border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Colors.blueGrey, // Border color
                  width: 3.0,          // Border width
                ),
              ),),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Transaction:'),
                SizedBox(width: 50),
                DropdownButton<TransactionType>(
                  value: selectedType,
                  onChanged: (TransactionType? value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                  items: TransactionType.values
                      .map<DropdownMenuItem<TransactionType>>(
                        (TransactionType value) {
                      return DropdownMenuItem<TransactionType>(
                        value: value,
                        child: Text(value == TransactionType.Return ? 'Return' : 'Give'),
                      );
                    },
                  )
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDateTime = await showDatePicker(
                      context: context,
                      initialDate: selectedDateTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDateTime != null) {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                      );

                      if (pickedTime != null) {
                        selectedDateTime = DateTime(
                          pickedDateTime.year,
                          pickedDateTime.month,
                          pickedDateTime.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      }
                    }
                  },
                  child: Text('Select Date and Time'),
                ),
              ],
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete Customer'),
                      content: Text(''),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.onDelete();
                            Navigator.pop(context);
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Delete Customer'),
            ),
            SizedBox(height: 30,),


          ],
        ),
      ),

      floatingActionButton:GestureDetector(
        onTap: () {
          widget.onUpdate(customerName, amount, selectedType, selectedDateTime, phoneNumber);
        },
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.deepPurpleAccent,
          ),

          child: Center(child: Text('update',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
        ),
      ),
      //FloatingActionButton(
      //   onPressed: () {
      //     widget.onUpdate(customerName, amount, selectedType, selectedDateTime, phoneNumber);
      //   },
      //   child: Icon(Icons.update),
      // ),
    );
  }
}