import 'package:flutter/material.dart';
import 'quiz_page.dart';

class TableQuiz extends StatefulWidget {
  @override
  _TableQuizState createState() => _TableQuizState();
}

class _TableQuizState extends State<TableQuiz> {
  int inputNumber = 0;
  int numberOfQuestions = 0;
  List<String> mcqs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  inputNumber = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter a number',
                labelStyle: TextStyle(color: Colors.white), // Change label text color to white
              ),
              style: TextStyle(color: Colors.white), // Change input text color to white
            ),
            SizedBox(height: 10.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  numberOfQuestions = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Number of MCQs',
                labelStyle: TextStyle(color: Colors.white), // Change label text color to white
              ),
              style: TextStyle(color: Colors.white), // Change input text color to white
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                generateQuiz();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(mcqs: mcqs),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
              child: Text('Generate Quiz', style: TextStyle(color: Colors.white)), // Change button text color to white
            ),
          ],
        ),
      ),
    );
  }

  void generateQuiz() {
    setState(() {
      mcqs.clear();
      for (int i = 1; i <= numberOfQuestions; i++) {
        mcqs.add('What is $inputNumber * $i?');
      }
    });
  }
}
