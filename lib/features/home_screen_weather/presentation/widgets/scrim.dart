import 'package:flutter/material.dart';

class Scrim extends StatelessWidget {
  final bool applied;
  final Widget child;
  final double opacity;
  final Duration speed;
  final Color color;

  const Scrim({
    Key? key,
    required this.applied,
    required this.child,
    this.opacity = 0.75,
    this.color = Colors.white,
    this.speed = const Duration(milliseconds: 150),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: speed,
      curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      foregroundDecoration: BoxDecoration(
        color: color.withOpacity(applied ? opacity : 0.0),
      ),
      child: child,
    );
  }
}
