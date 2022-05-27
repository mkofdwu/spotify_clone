import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/widgets/pressed_builder.dart';

class PlayShuffleButton extends StatelessWidget {
  const PlayShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PressedBuilder(
      onPressed: () {},
      builder: (pressed) => Stack(
        children: [
          AnimatedScale(
            scale: pressed ? 0.98 : 1,
            duration: const Duration(milliseconds: 100),
            child: AnimatedOpacity(
              opacity: pressed ? 0.6 : 1,
              duration: const Duration(milliseconds: 100),
              child: Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Palette.green,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Icon(Icons.play_arrow, color: Colors.black, size: 32),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: pressed ? Colors.black : Color(0xFF2a2a2a),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.shuffle,
                  color: Palette.green,
                  size: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
