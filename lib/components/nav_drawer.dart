
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer/timer_theme.dart';

import 'nav_drawer_painter.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

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

                Container(
                  margin: const EdgeInsets.only(right: 20),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(50.0))
                  ),
                  child: ListTile(
                    leading: Icon(Icons.home_outlined, color: TimerTheme.darkGreen,),
                    title: Text('Home', style: TextStyle(color: TimerTheme.darkGreen),),
                    onTap: () => {
                      Navigator.of(context).pop()
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: TimerTheme.lightGreen,
                      borderRadius: const BorderRadiusDirectional.horizontal(end: Radius.circular(50.0))
                  ),
                  child: ListTile(
                    leading: Icon(Icons.bar_chart, color: TimerTheme.darkGreen),
                    title: Text('Successes', style: TextStyle(color: TimerTheme.darkGreen)),
                    onTap: () => {
                      Navigator.of(context).pop()
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: TimerTheme.lightGreen,
                      borderRadius: const BorderRadiusDirectional.horizontal(end: Radius.circular(50.0))
                  ),
                  child: ListTile(
                    leading: Icon(Icons.flash_on, color: TimerTheme.darkGreen),
                    title: Text('Settings', style: TextStyle(color: TimerTheme.darkGreen)),
                    onTap: () => {
                      Navigator.of(context).pop()
                    },
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}