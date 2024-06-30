import 'package:flutter/material.dart';
import 'dart:math';

class CircularAnimationPainter extends CustomPainter {
  final List<Offset> positions;
  final List<bool> isMovingDown;
  final double radius;
  final double animationValue;
  final Random random = Random();

  CircularAnimationPainter({
    required this.positions,
    required this.isMovingDown,
    required this.radius,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (var i = 0; i < positions.length; i++) {
      double dx = positions[i].dx;
      double dy = positions[i].dy;

      if (isMovingDown[i]) {
        dy += 1.0; // Move down
        if (dy > size.height) {
          // Reset to top
          dx = random.nextDouble() * size.width;
          dy = 0.0;
        }
      } else {
        dy -= 1.0; // Move up
        if (dy < 0) {
          // Reset to bottom
          dx = random.nextDouble() * size.width;
          dy = size.height;
        }
      }

      positions[i] = Offset(dx, dy);
      canvas.drawCircle(positions[i], 5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
