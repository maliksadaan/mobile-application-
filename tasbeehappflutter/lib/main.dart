import 'package:flutter/material.dart';

void main() {
  runApp(TasbeehApp());
}

class TasbeehApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FrontPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/Image.jpg', // Change this to your new background image asset
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TasbeehScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size(200, 60),
                  ),
                  child: Text(
                    ' Tasbeeh Counter',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TasbeehScreen extends StatefulWidget {
  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  final List<Tasbeeh> tasbeehList = [
    Tasbeeh(name: 'la haola wala quwwata illah Billah'),
    Tasbeeh(name: 'La ilaha illallah'),
    Tasbeeh(name: 'Allahu Akbar'),
    Tasbeeh(name: 'Alhamdulillah'),
    Tasbeeh(name: 'Allahuma Salli Ala Muhammad'),
    Tasbeeh(name: 'Bismillah'),
    Tasbeeh(name: 'Ash-hadu an la ilaha illallah wahdahu la sharika lahu'),
    Tasbeeh(name: 'Astagfar-Allah'),

  ];

  TextEditingController newTasbeehNameController = TextEditingController();

  void addNewTasbeeh(String name) {
    if (name.isNotEmpty) {
      setState(() {
        tasbeehList.add(Tasbeeh(name: name));
        newTasbeehNameController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Tasbeeh '),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/Image1.jpg', // Change this to your desired background image asset
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          ListView.builder(
            itemCount: tasbeehList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white, // Change the color to green
                  ),
                  child: ListTile(
                    title: Text(
                      tasbeehList[index].name,
                      style: TextStyle(color: Colors.black, fontSize: 20), // Change text color to black
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TasbeehCounterScreen(
                            tasbeeh: tasbeehList[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Enter New Tasbeeh Name'),
                      content: TextFormField(
                        controller: newTasbeehNameController,
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            addNewTasbeeh(newTasbeehNameController.text);
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: Colors.black,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class Tasbeeh {
  final String name;
  int count = 0;

  Tasbeeh({required this.name});
}

class TasbeehCounterScreen extends StatefulWidget {
  final Tasbeeh tasbeeh;

  TasbeehCounterScreen({required this.tasbeeh});

  @override
  _TasbeehCounterScreenState createState() => _TasbeehCounterScreenState();
}

class _TasbeehCounterScreenState extends State<TasbeehCounterScreen> {
  int count = 0;

  void incrementCount() {
    setState(() {
      count++;
    });
  }

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tasbeeh.name),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/Image1.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${widget.tasbeeh.name} Count: $count',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: incrementCount,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: Size(100, 40),
                    ),
                    child: Text(
                      'Count',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: resetCount,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                      minimumSize: Size(100, 40),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
