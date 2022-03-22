import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:timer/timer_theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double _currentSliderValue = 1;
  bool _isStopped = true;
  int _time = 30;
  Timer? _timer = null;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        decoration: createGradientDecoration(),
        child: Stack(
          children: [
            const Center(child: Image(
              image: AssetImage('graphics/Illustration 1.png'),
            )),
            createTimeSlider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    createCompletedTextContainer(),
                    const SizedBox(height: 10,),
                    createCompletedProgressBar(),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height/3,
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buildTimeRounds(_currentSliderValue.round())
                ),

                Text(
                  "$_time:00",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                ),

                createFocusStopButton()
              ],
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration createGradientDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              TimerTheme.lightGreen,
              TimerTheme.green
            ],
            end: Alignment.bottomRight,
            stops: [
              0.4,
              0.9
            ]
        )
    );
  }

  Widget createTimeSlider() {
    return Positioned(
        bottom: MediaQuery.of(context).size.height / 2.5,
        right: 10,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: RotatedBox(
            quarterTurns: 3,
            child: Slider(
              activeColor: TimerTheme.yellow,
              inactiveColor: const Color.fromRGBO(255, 255, 255, 0.44),
              value: _currentSliderValue,
              min: 1,
              max: 6,
              divisions: 5,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                  _time = value.round() * 30;
                });
              },
            ),
          ),
        )
    );
  }

  Widget createCompletedTextContainer() {
    return Container(
      child: Text(
        "Completed ${calculateCompletedPercent()}%",
        textAlign: TextAlign.center,
        style: Theme.of(context)
          .textTheme
          .headline5!
          .copyWith(color: Colors.white),),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/5),
    );
  }

  Widget createCompletedProgressBar() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 96,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20)
        ),
        child: LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 100,
          // animation: true,
          lineHeight: 20.0,
          // animationDuration: 2500,
          percent: calculateCompletedPercent()/100,
          linearStrokeCap: LinearStrokeCap.roundAll,
          // progressColor: Colors.green,
          linearGradient: const LinearGradient(
              colors: [
                Color.fromRGBO(0, 175, 100, 1),
                Color.fromRGBO(255, 255, 255, 0.3)
              ]
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget createFocusStopButton() {
    var bottomPosition = MediaQuery.of(context).size.height * 0.04;
    return Container(
      margin: EdgeInsets.only(bottom: bottomPosition * 1.6),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 50,
        child: OutlinedButton(
            onPressed: () {
              if (_isStopped) {
                startTimer();
              } else {
                _timer?.cancel();
              }
              setState(() {
                _isStopped = !_isStopped;
              });
            },
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                backgroundColor: TimerTheme.yellow),
            child: Text(
              _isStopped ? "FOCUS" : "STOP",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: TimerTheme.darkGreen),
            )),
      ),
    );
  }
  
  List<Widget> buildTimeRounds(int roundsAmount) {
    List<Widget> widgets = [];
    for (int i = 0; i < roundsAmount; i++) {
      widgets.add(createTimeRound());
      if (i != (roundsAmount - 1)) {
        widgets.add(createTimeRoundSeparator());
      }
    }
    return widgets;
  }
  
  Widget createTimeRound() {
    final kInnerDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            TimerTheme.lightGreen,
            TimerTheme.green
          ],
          end: Alignment.bottomRight,
          stops: const [
            0.4,
            0.9
          ]
      ),
      border: Border.all(color: TimerTheme.lightGreen,),
      borderRadius: BorderRadius.circular(20),
    );

    // border for all 3 colors
    final kGradientBoxDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.yellow.shade600, Colors.orange, Colors.red]
      ),
      borderRadius: BorderRadius.circular(20),
    );
    
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            child: Container(
              width: 40.0,
              height: 40.0,
              child: const Center(
                child: Text(
                  "30",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              decoration: kInnerDecoration,
            ),
          ),
        ),
        decoration: kGradientBoxDecoration,
      ),
    );
  }
  
  Widget createTimeRoundSeparator() {
    return SizedBox(
      width: 20,
      height: 1,
      child: Container(
        color: Colors.white,
      ),
    );
  }

  int calculateCompletedPercent() {
    return (
        (
            (_currentSliderValue * 30 - _time) / (_currentSliderValue * 30)
        ) * 100
    ).round();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_time == 0) {
          setState(() {
            timer.cancel();
            _isStopped = true;
          });
        } else {
          setState(() {
            _time--;
          });
        }
      },
    );
  }
}
