
import 'package:flutter/material.dart';

class NavDrawerButtonPainter extends CustomPainter {

  NavDrawerButtonPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds = Rect.fromLTWH(0, 0, size.width, size.height);
    final curvedShapeBounds = Rect.fromLTRB(
      shapeBounds.left,
      shapeBounds.top + shapeBounds.height * 0.5,
      shapeBounds.right,
      shapeBounds.bottom,
    );
    _drawCurvedShape(canvas, curvedShapeBounds);
  }

  @override
  bool shouldRepaint(NavDrawerButtonPainter oldDelegate) {
    return hashCode != oldDelegate.hashCode;
  }

  void _drawCurvedShape(Canvas canvas, Rect bounds) {

    final colors = [
      const Color.fromRGBO(255, 255, 255, 0.56),
      const Color.fromRGBO(255, 255, 255, 0.22)
    ];
    final gradient = LinearGradient(colors: colors, begin: Alignment.topCenter, end: Alignment.bottomCenter);
    final paint = Paint()..shader = gradient.createShader(bounds);

    final curvePath = Path()
      ..moveTo(bounds.topLeft.dx, bounds.topLeft.dy)
      ..cubicTo(bounds.center.dx * 0.05, bounds.center.dy*0.8, bounds.center.dx*1.9, bounds.center.dy * 0.75,
          bounds.centerRight.dx, bounds.centerRight.dy)
      ..cubicTo(bounds.center.dx*1.9, bounds.center.dy * 1.25, bounds.center.dx * 0.05, bounds.center.dy*1.2,
          bounds.bottomLeft.dx, bounds.bottomLeft.dy)
      ..lineTo(bounds.topLeft.dx, bounds.topLeft.dy)
      ..close();

    canvas.drawPath(curvePath, paint);
  }
}