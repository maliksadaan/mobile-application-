import 'package:flutter/material.dart';
import 'screens/quiz_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.red,     // Change the primary color
          secondary: Colors.green, // Change the secondary color
        ),
        scaffoldBackgroundColor: Colors.grey, // Change the background color
        // Add more customizations as needed
      ),
      home: const QuizScreen(),
    );
  }
}
