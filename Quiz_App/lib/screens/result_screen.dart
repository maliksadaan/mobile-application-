import 'package:flutter/material.dart';

import '/models/questions.dart';
import '/screens/quiz_screen.dart';
import '/widgets/next_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 800),
          const Text(
            'Your score: ',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: score / 9,
                  color: Colors.yellowAccent,
                  backgroundColor: Colors.greenAccent,
                ),
              ),
              Column(
                children: [
                  Text(
                    score.toString(),
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(score / questions.length * 100).round()}%',
                    style: const TextStyle(fontSize: 25),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
