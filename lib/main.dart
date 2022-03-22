import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/screens/home.dart';

import 'bloc/navigation/navigation_bloc.dart';
import 'bloc/navigation/navigation_event.dart';
import 'bloc/navigation/navigation_state.dart';
import 'components/nav_drawer.dart';
import 'components/nav_drawer_button_painter.dart';
import 'screens/other.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(),
    ),
  ], child: const TimerApp()));
}

class TimerApp extends StatelessWidget {
  const TimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BasePage(),
    );
  }
}

class BasePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<NavigationBloc>(context);
    bloc.add(const PageTapped(0));

    var navDrawerButtonHeight = MediaQuery.of(context).size.height / 5;
    var navDrawerButtonWidth = navDrawerButtonHeight / 4;
    var bottomPosition = MediaQuery.of(context).size.height * 0.04;

    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(bloc),
      body: Stack(children: [
        BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, NavigationState state) {
            if (state is PageLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomePageLoaded) {
              return const Home();
            }
            if (state is OtherPageLoaded) {
              return const Other();
            }
            return Container();
          },
        ),
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
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        )
      ]),
    );
  }
}
