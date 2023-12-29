import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final List<String> mcqs;

  QuizPage({required this.mcqs});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<String> userAnswers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Page', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MCQs:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            for (int i = 0; i < widget.mcqs.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${i + 1}: ${widget.mcqs[i]}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        userAnswers.add(value);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Your Answer',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white), // Set text color to white
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                showResult();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
              child: Text('Show Result', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void showResult() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result', style: TextStyle(color: Colors.black)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Answers:', style: TextStyle(color: Colors.black)),
              for (int i = 0; i < userAnswers.length; i++)
                Text('Question ${i + 1}: ${userAnswers[i]}', style: TextStyle(color: Colors.black)),
            ],
          ),
        );
      },
    );
  }
}
