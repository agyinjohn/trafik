import 'package:flutter/material.dart';
import 'dart:math';

import 'package:traffic/widgets/circular_animated_painter.dart';

class CircularAnimationBackground extends StatefulWidget {
  const CircularAnimationBackground({super.key});

  @override
  CircularAnimationBackgroundState createState() =>
      CircularAnimationBackgroundState();
}

class CircularAnimationBackgroundState
    extends State<CircularAnimationBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> _positions;
  late List<bool> _isMovingDown;
  final double _radius = 50.0;
  final int _numberOfObjects = 100; // Increase the number of objects

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _positions = [];
    _isMovingDown = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize positions after context is available
    final random = Random();
    _positions = List.generate(_numberOfObjects, (index) {
      final dx = random.nextDouble() * MediaQuery.of(context).size.width;
      final dy = random.nextDouble() * MediaQuery.of(context).size.height;
      return Offset(dx, dy);
    });
    _isMovingDown =
        List.generate(_numberOfObjects, (index) => random.nextBool());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: CircularAnimationPainter(
            positions: _positions,
            isMovingDown: _isMovingDown,
            radius: _radius,
            animationValue: _controller.value,
          ),
          child: Container(),
        );
      },
    );
  }
}
