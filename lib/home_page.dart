import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class BMI_calculator extends StatefulWidget {
  const BMI_calculator({Key? key}) : super(key: key);

  @override
  State<BMI_calculator> createState() => _BMI_calculatorState();
}

class _BMI_calculatorState extends State<BMI_calculator> with TickerProviderStateMixin {
  double cm = 0;
  int weight = 0;
  int age = 0;
  double BMI = 0;

  Color malecolor = deactivcolor;
  Color femalecolor = deactivcolor;

  Color maleicon = deactivcolor;
  Color femaleicon = deactivcolor;

  // double height = 180;
  // double width = 160;

  late AnimationController animationController;
  late Animation sizeanimation;
  late Animation coloranimation;
  late Animation iconanimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    sizeanimation = Tween<double>(begin: 200, end: 400).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );
    iconanimation = Tween(begin: 0, end: 120).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: AnimatedBuilder(
          animation: animationController,
          builder: (context, widget) {
            return TextLiquidFill(
              loadDuration: Duration(seconds: 1),
              text: 'BMI Calculator',
              textStyle: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              waveColor: Colors.black,
              boxHeight: 300,
              boxWidth: double.infinity,
              boxBackgroundColor: Colors.white,
              loadUntil: 1,
              waveDuration: Duration(seconds: 10),
            );
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex:2,
              child: Row(
                children: [
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      setState(() {
                        updatecolor(1);
                      });
                    },
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, widget) {
                        return Container(
                          alignment: Alignment.center,
                          height: 150,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Color(0xff1d1e33),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.female,
                                color: femaleicon,
                                size: 100,
                              ),
                              Text(
                                "Female",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: femaleicon,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        setState(() {
                          updatecolor(2);
                        });
                      },
                      child: AnimatedBuilder(
                        animation: animationController,
                        builder: (context, widget) {
                          return Container(
                            alignment: Alignment.center,
                            height: 150,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Color(0xff1d1e33),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.male,
                                  color: maleicon,
                                  size: 100,
                                ),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: maleicon,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xff1d1e33),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      height: 50,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Color(0xff3b3c4d),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "  ${get()} ",
                                style: TextStyle(
                                  color: Colors.green.shade800,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "  ${BMI.toInt()}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "  ${getTOW()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${cm.toInt()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(
                            text: " CM",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff626473),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: const SliderThemeData(
                        thumbColor: Colors.teal,
                        trackHeight: 2,
                      ),
                      child: Slider(
                        activeColor: Colors.teal,
                        inactiveColor: Colors.white,
                        min: 0,
                        max: 500,
                        value: cm,
                        onChanged: (val) {
                          setState(() {
                            cm = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    height: 150,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Color(0xff1d1e33),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "weight",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "$weight",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xff4c4f5c),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  size: 30,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            InkWell(
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xff6e6f7a),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.teal,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    height: 150,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Color(0xff1d1e33),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Age",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "$age",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xff4c4f5c),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  size: 30,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            InkWell(
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xff6e6f7a),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.teal,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        color:  Colors.teal,
                        borderRadius: BorderRadius.circular(30),),
                      child: const Text(
                        "Calculate",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        BMI = weight / pow(cm / 100, 2);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xff090e21),
    );
  }

  void updatecolor(int gender) {
    if (gender == 1) {
      femalecolor = activcolor;
      malecolor = deactivcolor;
      femaleicon = iconactivcolor;
      maleicon = icondeactivcolor;
    } else if (gender == 2) {
      femalecolor = deactivcolor;
      malecolor = activcolor;
      femaleicon = icondeactivcolor;
      maleicon = iconactivcolor;
    }
  }

  get() {
    if (BMI >= 25) {
      return "Overweight";
    } else if (BMI > 18) {
      return "Normal";
    } else {
      return "Underweight : ";
    }
  }

  getTOW() {
    if (BMI >= 25) {
      return "You have a higher than Normal body";
    } else if (BMI > 18) {
      return "Good job! You have Normal body";
    } else {
      return "You have a lower than Normal body";
    }
  }
}




Color activcolor = Color(0xff3b3c4d);
Color deactivcolor = Color(0xff1d1e33);

Color iconactivcolor = Colors.teal;
Color icondeactivcolor = Colors.white;