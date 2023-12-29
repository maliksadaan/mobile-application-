import 'constantfile.dart';
import 'input_page.dart';
import 'package:flutter/material.dart';
import 'Containerfile.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({required this.interpretation,required this.bmiResult,required this.resultText});

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI Result'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                child: Center(
                    child: Text(
                      'Your Result',
                      style: kTittleStyle2,
                    )
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: RepeatContainerCode(
                colors: activeColor,
                cardWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        resultText.toUpperCase(),
                        style: TextStyle(color: Colors.green,fontSize: 14,fontWeight: FontWeight.w300),
                      ),
                      Text(
                        bmiResult,
                        style: TextStyle(fontSize: 50,fontWeight: FontWeight.w800),
                      ),
                      Text(
                        interpretation,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      )

                    ]),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InputPage()));
                },
                child: Container(
                  child: Center(
                    child:
                    Text('Re-Calculate',style: kLargeButtonstyle,),

                  ),
                  color: Color(0xFFEB1555),
                  margin: EdgeInsets.only(top: 10.0),
                  width: double.infinity,
                  height: 80.0,
                ),
              )
              ,
            ),
          ],
        )
    );
  }
}