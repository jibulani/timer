
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/bloc/navigation/navigation_bloc.dart';
import 'package:timer/bloc/navigation/navigation_event.dart';
import 'package:timer/bloc/navigation/navigation_state.dart';
import 'package:timer/timer_theme.dart';

import 'nav_drawer_painter.dart';

class NavDrawer extends StatelessWidget {
  final NavigationBloc bloc;

  const NavDrawer(this.bloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: TimerTheme.lightGreen,
        child: Stack(
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: NavDrawerPainter(color: const Color.fromRGBO(255, 255, 255, 0.32)),
              isComplex: true,
            ),
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                      color: TimerTheme.lightGreen
                  ),
                  child: Center(
                    child: Text(
                        'INSTRUMENTS',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: TimerTheme.darkGreen, decoration: TextDecoration.underline)
                    ),
                  ),
                ),
                BlocBuilder(
                    bloc: bloc,
                    builder: (BuildContext context, NavigationState state) {
                      if (state is HomePageLoaded) {
                        return getMenuItems(0);
                      }
                      if (state is OtherPageLoaded) {
                        return getMenuItems(1);
                      }
                      return Container();
                    }
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }

  Widget getMenuItems(menuPositionSelected) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          decoration: menuPositionSelected == 0 ?
          const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(50.0))
          ) : BoxDecoration(
              color: TimerTheme.lightGreen,
              borderRadius: const BorderRadiusDirectional.horizontal(end: Radius.circular(50.0))
          ),
          child: ListTile(
            leading: Icon(Icons.home_outlined, color: TimerTheme.darkGreen,),
            title: Text('Home', style: TextStyle(color: TimerTheme.darkGreen),),
            onTap: () => {
              bloc.add(const PageTapped(0))
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 20),
          decoration: menuPositionSelected == 1 ?
          const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(50.0))
          ) : BoxDecoration(
              color: TimerTheme.lightGreen,
              borderRadius: const BorderRadiusDirectional.horizontal(end: Radius.circular(50.0))
          ),
          child: ListTile(
            leading: Icon(Icons.bar_chart, color: TimerTheme.darkGreen),
            title: Text('Successes', style: TextStyle(color: TimerTheme.darkGreen)),
            onTap: () => {
              bloc.add(const PageTapped(1))
            },
          ),
        )
      ],
    );
  }
}