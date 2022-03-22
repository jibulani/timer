
import 'package:flutter/material.dart';

class NavDrawerPainter extends CustomPainter {

  NavDrawerPainter({required this.color});

  final Color color;

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
  bool shouldRepaint(NavDrawerPainter oldDelegate) {
    return color != oldDelegate.color;
  }

  void _drawCurvedShape(Canvas canvas, Rect bounds) {
    final paint = Paint()..color = color;

    final curvePath = Path()
      ..moveTo(bounds.bottomLeft.dx, bounds.bottomLeft.dy)
      ..lineTo(bounds.centerLeft.dx, bounds.topLeft.dy * 1.7)
      ..cubicTo(bounds.center.dx * 0.95, bounds.center.dy * 0.9, bounds.center.dx * 1.5, bounds.center.dy * 0.7,
          bounds.centerRight.dx, bounds.centerRight.dy * 0.9)
      ..lineTo(bounds.bottomRight.dx, bounds.bottomRight.dy)
      ..lineTo(bounds.bottomLeft.dx, bounds.bottomLeft.dy)
      ..close();

    canvas.drawPath(curvePath, paint);

    final curvePath1 = Path()
      ..moveTo(bounds.bottomLeft.dx, bounds.bottomLeft.dy)
      ..lineTo(bounds.centerLeft.dx, bounds.topLeft.dy)
      ..quadraticBezierTo(bounds.center.dx * 0.3, bounds.center.dy * 0.6,
          bounds.centerRight.dx, bounds.centerRight.dy * 1.2)
      ..lineTo(bounds.bottomRight.dx, bounds.bottomRight.dy)
      ..lineTo(bounds.bottomLeft.dx, bounds.bottomLeft.dy)
      ..close();

    canvas.drawPath(curvePath1, paint);
  }
}