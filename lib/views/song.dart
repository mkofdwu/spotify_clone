import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/controllers/song_controller.dart';
import 'package:spotify_clone/widgets/opacity_feedback.dart';

class SongView extends StatelessWidget {
  const SongView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<SongController>(builder: (controller) {
      final song = controller.currentSong;
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF775c5c),
                Color(0xFF121212),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildTop(),
                SizedBox(height: 70),
                Image.asset(
                  song!.coverImage,
                  width: width - 48,
                  height: width - 48,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      _buildSongDetails(song),
                      SizedBox(height: 28),
                      _buildPositionIndicator(controller),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDuration(controller.position),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          Text(
                            formatDuration(controller.totalDuration),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      _buildActions(controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTop() => Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Row(
          children: [
            OpacityFeedback(
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: Colors.white,
              ),
              onPressed: Get.back,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'PLAYING FROM YOUR LIBRARY',
                    style: TextStyle(fontSize: 10, letterSpacing: 1),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Liked Songs',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Icon(Icons.more_vert, color: Colors.white),
          ],
        ),
      );

  Widget _buildSongDetails(Song song) => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  song.artistName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Icon(
            song.liked ? Icons.favorite : Icons.favorite_border,
            color: song.liked ? Palette.green : Colors.white,
            size: 24,
          ),
        ],
      );

  Widget _buildPositionIndicator(SongController controller) =>
      FractionallySizedBox(
        widthFactor: 1.04,
        child: SliderTheme(
          data: SliderThemeData(
            overlayShape: SliderComponentShape.noOverlay,
            trackShape: CustomTrackShape(),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
            trackHeight: 4,
          ),
          child: Slider(
            min: 0,
            max: controller.totalDuration.toDouble(),
            value: controller.position.toDouble(),
            onChanged: (value) {
              controller.seek(value.toInt());
            },
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.1),
          ),
        ),
      );

  Widget _buildActions(SongController controller) => Row(
        children: [
          Icon(Icons.shuffle, size: 24, color: Colors.white),
          Spacer(flex: 3),
          OpacityFeedback(
            child: Icon(Icons.skip_previous, size: 36, color: Colors.white),
            onPressed: controller.prevSong,
          ),
          Spacer(flex: 2),
          OpacityFeedback(
            onPressed: controller.playOrPause,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Icon(
                  controller.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 36,
                ),
              ),
            ),
          ),
          Spacer(flex: 2),
          OpacityFeedback(
            child: Icon(Icons.skip_next, size: 36, color: Colors.white),
            onPressed: controller.nextSong,
          ),
          Spacer(flex: 3),
          Icon(Icons.loop, size: 24, color: Colors.white),
        ],
      );
}

String formatDuration(int duration) {
  final seconds = (duration % 60).toString().padLeft(2, '0');
  return '${duration ~/ 60}:$seconds';
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required Offset thumbCenter,
      bool isDiscrete = false,
      bool isEnabled = false,
      double additionalActiveTrackHeight = 2}) {
    super.paint(context, offset,
        parentBox: parentBox,
        sliderTheme: sliderTheme,
        enableAnimation: enableAnimation,
        textDirection: textDirection,
        thumbCenter: thumbCenter,
        isDiscrete: isDiscrete,
        isEnabled: isEnabled,
        additionalActiveTrackHeight: 0);
  }
}
