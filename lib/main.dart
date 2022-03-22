import 'package:flutter/material.dart';
import 'package:timer/screens/home.dart';

import 'components/nav_drawer.dart';
import 'components/nav_drawer_button_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var navDrawerButtonHeight = MediaQuery.of(context).size.height / 5;
    var navDrawerButtonWidth = navDrawerButtonHeight / 4;
    var bottomPosition = MediaQuery.of(context).size.height * 0.04;

    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      body: Stack(
        children: [
          Home(),
          Positioned(
            bottom: bottomPosition,
            child: SizedBox(
              width: navDrawerButtonWidth,
              height: navDrawerButtonHeight,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: NavDrawerButtonPainter(),
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          bottom: bottomPosition * 1.6,
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white,),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        )

        // add BlocBuilder
        ]
      ),
    );
  }
}