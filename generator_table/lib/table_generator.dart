import 'package:flutter/material.dart';

class TableGenerator extends StatefulWidget {
  @override
  _TableGeneratorState createState() => _TableGeneratorState();
}

class _TableGeneratorState extends State<TableGenerator> {
  TextEditingController tableNumberController = TextEditingController(text: '1');
  TextEditingController timesController = TextEditingController(text: '10');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Generator'),
        backgroundColor: Colors.deepPurple, // Change app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0), // Increase padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: tableNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Table Number',
                filled: true,
                fillColor: Colors.grey[200], // Change text field color
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: timesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Multiply Times',
                filled: true,
                fillColor: Colors.grey[200], // Change text field color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showTable(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, // Change button color
              ),
              child: Text(
                'Generate Table',
                style: TextStyle(color: Colors.white), // Change button text color
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTable(BuildContext context) {
    int tableNumber = int.tryParse(tableNumberController.text) ?? 1;
    int times = int.tryParse(timesController.text) ?? 10;

    // Logic to generate and display the table based on user input
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Generated Table'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: times,
              itemBuilder: (BuildContext context, int index) {
                int currentNumber = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$tableNumber',
                        style: TextStyle(color: Colors.deepPurple), // Change text color
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        '×',
                        style: TextStyle(color: Colors.deepPurple), // Change text color
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        '$currentNumber',
                        style: TextStyle(color: Colors.deepPurple), // Change text color
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        '=',
                        style: TextStyle(color: Colors.deepPurple), // Change text color
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        (tableNumber * currentNumber).toString(),
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ), // Change text color and font weight
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TableGenerator(),
  ));
}
