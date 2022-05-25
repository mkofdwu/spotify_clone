import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/widgets/opacity_feedback.dart';

class SongView extends StatefulWidget {
  final Song song;

  const SongView({Key? key, required this.song}) : super(key: key);

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _totalDuration = Duration.zero;

  AudioPlayer? _player;
  AudioCache? _cache;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _cache = AudioCache(fixedPlayer: _player);

    _player!.onDurationChanged.listen((duration) {
      setState(() => _totalDuration = duration);
    });
    _player!.onAudioPositionChanged.listen((newPosition) {
      setState(() => _position = newPosition);
    });
    _player!.onPlayerCompletion.listen((event) {
      setState(() => _isPlaying = false);
    });
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                widget.song.coverImage,
                width: width - 48,
                height: width - 48,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    _buildSongDetails(),
                    SizedBox(height: 28),
                    _buildPositionIndicator(),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(_position),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        Text(
                          formatDuration(_totalDuration),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    _buildActions(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
              onPressed: () => Navigator.pop(context),
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

  Widget _buildSongDetails() => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  widget.song.artistName,
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
            widget.song.liked ? Icons.favorite : Icons.favorite_border,
            color: widget.song.liked ? Palette.green : Colors.white,
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
            max: _totalDuration.inSeconds.toDouble(),
            value: _position.inSeconds.toDouble(),
            onChanged: (value) {
              _player!.seek(Duration(seconds: value.toInt()));
            },
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.1),
          ),
        ),
      );

  Widget _buildActions() => Row(
        children: [
          Icon(Icons.shuffle, size: 24, color: Colors.white),
          Spacer(flex: 3),
          Icon(Icons.skip_previous, size: 36, color: Colors.white),
          Spacer(flex: 2),
          OpacityFeedback(
            onPressed: () {
              setState(() => _isPlaying = !_isPlaying);
              if (_isPlaying) {
                _cache!.play(widget.song.mp3Path);
              } else {
                _player!.pause();
              }
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 36,
                ),
              ),
            ),
          ),
          Spacer(flex: 2),
          Icon(Icons.skip_next, size: 36, color: Colors.white),
          Spacer(flex: 3),
          Icon(Icons.loop, size: 24, color: Colors.white),
        ],
      );
}

String formatDuration(Duration duration) {
  final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  return '${duration.inMinutes}:$seconds';
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
