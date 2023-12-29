import 'package:bmi_calculator/constantfile.dart'; // Update the path to match the correct location
import 'iconfile.dart'; // Update the path to match the correct location
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'containerfile.dart';
import 'resultfile.dart';
import 'calculatorFile.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectGender;
  int sliderHeight = 180;
  int sliderWeight = 60;
  int sliderAge = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: RepeatContainerCode(
                      colors:
                      selectGender == Gender.male ? activeColor : deActiveColor,
                      cardWidget: RepeatTextandICONeWidget(
                        icondata: Icons.male,
                        label: 'Male',
                      ),
                      onPressed: () {
                        setState(() {
                          selectGender = Gender.male;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RepeatContainerCode(
                      colors: selectGender == Gender.female
                          ? activeColor
                          : deActiveColor,
                      cardWidget: RepeatTextandICONeWidget(
                        icondata: Icons.female,
                        label: 'female',
                      ),
                      onPressed: () {
                        setState(() {
                          selectGender = Gender.female;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: RepeatContainerCode(
                    onPressed: () {},
                    colors: Color(0xFF1D1E33),
                    cardWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Height',
                          style: kLabelStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              sliderHeight.toString(),
                              style: kNumberStyle,
                            ),
                            Text(
                              'cm',
                              style: kLabelStyle,
                            )
                          ],
                        ),
                        Slider(
                            value: sliderHeight.toDouble(),
                            min: 120.0,
                            max: 220.0,
                            activeColor: Color(0XFFEB1555),
                            inactiveColor: Color(0xFF8D8E98),
                            onChanged: (double newValue) {
                              setState(() {
                                sliderHeight = newValue.round();
                              });
                            })
                      ],
                    ))),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: RepeatContainerCode(
                          onPressed: () {},
                          colors: Color(0xFF1D1E33),
                          cardWidget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Weight',
                                style: kLabelStyle,
                              ),
                              Text(
                                sliderWeight.toString(),
                                style: kNumberStyle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundIcon(
                                    iconData: FontAwesomeIcons.minus,
                                    onPress: () {
                                      setState(() {
                                        sliderWeight--;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  RoundIcon(
                                    iconData: FontAwesomeIcons.plus,
                                    onPress: () {
                                      setState(() {
                                        sliderWeight++;
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ))),
                  Expanded(
                    child: RepeatContainerCode(
                        onPressed: () {},
                        colors: Color(0xFF1D1E33),
                        cardWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Age',
                              style: kLabelStyle,
                            ),
                            Text(
                              sliderAge.toString(),
                              style: kNumberStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIcon(
                                  iconData: FontAwesomeIcons.minus,
                                  onPress: () {
                                    setState(() {
                                      sliderAge--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIcon(
                                  iconData: FontAwesomeIcons.plus,
                                  onPress: () {
                                    setState(() {
                                      sliderAge++;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                CaclulatorBrain calc = CaclulatorBrain(height: sliderHeight, weight: sliderWeight);

                Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(
                  bmiResult: calc.calculateBMI(),
                  resultText: calc.getResult(),
                  interpretation: calc.getInterpretation(),
                )));
              },
              child: Container(
                child: Center(
                  child:
                  Text('Calculate',style: kLargeButtonstyle,),

                ),
                color: Color(0xFFEB1555),
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: 80.0,
              ),
            )

          ]),
    );
  }
}

class RoundIcon extends StatelessWidget {
  RoundIcon({required this.iconData, this.onPress});
  final IconData? iconData;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(iconData),
      onPressed: onPress,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        height: 40.0,
        width:40.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0XFF4C4F5E),
    );
  }
}
