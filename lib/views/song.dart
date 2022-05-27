import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/controllers/song_controller.dart';
import 'package:spotify_clone/utils/common_widgets.dart';
import 'package:spotify_clone/widgets/opacity_feedback.dart';

class SongView extends StatelessWidget {
  const SongView({Key? key}) : super(key: key);

  SongController get controller => Get.find<SongController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SongController>(builder: (controller) {
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
            child: _mainUi(),
          ),
        ),
      );
    });
  }

  Widget _mainUi() {
    final song = controller.currentSong;
    return Column(
      children: [
        _buildTop(),
        SizedBox(height: 70),
        Image.asset(
          song!.coverImage,
          width: Get.width - 48,
          height: Get.width - 48,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 70),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              _buildSongDetails(song),
              SizedBox(height: 28),
              _buildPositionIndicator(),
              SizedBox(height: 2),
              _buildDurationTexts(),
              SizedBox(height: 8),
              _buildActions(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTop() => Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Row(
          children: [
            OpacityFeedback(
              onPressed: Get.back,
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  styledText(
                    'PLAYING FROM YOUR LIBRARY',
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                  SizedBox(height: 2),
                  styledText(
                    'Liked Songs',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
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
          expandedColumnStart([
            styledText(
              song.title,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              oneLineEllipsis: true,
            ),
            styledText(
              song.artistName,
              color: Colors.white.withOpacity(0.6),
              fontSize: 16,
              oneLineEllipsis: true,
            ),
          ]),
          SizedBox(width: 16),
          Icon(
            song.liked ? Icons.favorite : Icons.favorite_border,
            color: song.liked ? Palette.green : Colors.white,
            size: 24,
          ),
        ],
      );

  Widget _buildPositionIndicator() => FractionallySizedBox(
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

  Widget _buildDurationTexts() => Row(
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
      );

  Widget _buildActions() => Row(
        children: [
          Icon(Icons.shuffle, size: 24, color: Colors.white),
          Spacer(flex: 3),
          OpacityFeedback(
            onPressed: controller.prevSong,
            child: Icon(Icons.skip_previous, size: 36, color: Colors.white),
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
            onPressed: controller.nextSong,
            child: Icon(Icons.skip_next, size: 36, color: Colors.white),
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
