import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double height = 160.0;
  double weight = 60.0;
  double bmi = 0.0;

  bool bmiCalculated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Height: ${height.toStringAsFixed(1)} cm',
            style: TextStyle(color: Colors.white), // Change text color to white
          ),
          Slider(
            value: height,
            min: 100.0,
            max: 220.0,
            onChanged: (value) {
              setState(() {
                height = value;
                _calculateBMI();
              });
            },
          ),
          Text(
            'Weight: ${weight.toStringAsFixed(1)} kg',
            style: TextStyle(color: Colors.white), // Change text color to white
          ),
          Slider(
            value: weight,
            min: 30.0,
            max: 150.0,
            onChanged: (value) {
              setState(() {
                weight = value;
                _calculateBMI();
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableGeneratorScreen(height: height, weight: weight, bmi: bmi),
                ),
              );

              if (result != null && result is double) {
                setState(() {
                  bmi = result;
                  bmiCalculated = true;
                });
              }
            },
            child: Text('Generate'),
          ),
          if (bmiCalculated)
            Column(
              children: [
                SizedBox(height: 20.0),
                Text(
                  'BMI: ${bmi.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white), // Change text color to white
                ),
                Text(
                  'Result: ${_interpretBMI(bmi)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white), // Change text color to white
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _calculateBMI() {
    setState(() {
      bmi = weight / ((height / 100) * (height / 100));
      bmiCalculated = false; // Reset the flag when sliders are moved
    });
  }

  String _interpretBMI(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi <= 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}

class TableGeneratorScreen extends StatelessWidget {
  final double height;
  final double weight;
  final double bmi;

  TableGeneratorScreen({required this.height, required this.weight, required this.bmi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\nHeight: $height cm\nWeight: $weight kg',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white), // Change text color to white
            ),
            SizedBox(height: 20.0),
            Text(
              'BMI: ${bmi.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white), // Change text color to white
            ),
            ElevatedButton(
              onPressed: () {
                // Return the BMI value to the previous screen
                Navigator.pop(context, bmi);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
