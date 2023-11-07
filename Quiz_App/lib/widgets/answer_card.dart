import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    Key? key,
    required this.question,
    required this.isSelected,
    required this.currentIndex,
    required this.correctAnswerIndex,
    required this.selectedAnswerIndex,
  }) : super(key: key);

  final String question;
  final bool isSelected;
  final int? correctAnswerIndex;
  final int? selectedAnswerIndex;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    bool isCorrectAnswer = currentIndex == correctAnswerIndex;
    bool isWrongAnswer = !isCorrectAnswer && isSelected;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: selectedAnswerIndex != null
          ? Container(
        height: 70,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isCorrectAnswer
                ? Colors.green
                : isWrongAnswer
                ? Colors.redAccent
                : Colors.white24,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                question,
                style: TextStyle(
                  fontSize: 16,
                  color: isCorrectAnswer ? Colors.green : isWrongAnswer ? Colors.red : Colors.white, // Text color based on correctness
                ),
              ),
            ),
            const SizedBox(height: 10),
            isCorrectAnswer
                ? buildCorrectIcon()
                : isWrongAnswer
                ? buildWrongIcon()
                : const SizedBox.shrink(),
          ],
        ),
      )
          : Container(
        height: 70,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white24,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCorrectIcon() => const CircleAvatar(
  radius: 15,
  backgroundColor: Colors.yellow,
  child: Icon(
    Icons.check,
    color: Colors.black,
  ),
);

Widget buildWrongIcon() => const CircleAvatar(
  radius: 15,
  backgroundColor: Colors.redAccent,
  child: Icon(
    Icons.close,
    color: Colors.black,
  ),
);
