import 'package:spotify_clone/widgets/pressed_builder.dart';
import 'package:flutter/material.dart';

class ShrinkFeedback extends StatelessWidget {
  final Widget child;
  final Function() onPressed;

  const ShrinkFeedback({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PressedBuilder(
      onPressed: onPressed,
      builder: (pressed) => AnimatedScale(
        scale: pressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 100),
        child: child,
      ),
    );
  }
}
