import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/utils/common_widgets.dart';
import 'package:spotify_clone/views/song.dart';
import 'package:spotify_clone/widgets/opacity_feedback.dart';

class CurrentlyPlayingSong extends StatelessWidget {
  final Song song;
  final double position; // from 0 to 1
  final bool isPlaying;
  final Function() playOrPause;

  const CurrentlyPlayingSong({
    Key? key,
    required this.song,
    required this.position,
    required this.isPlaying,
    required this.playOrPause,
  }) : super(key: key);

  void toSongView(BuildContext context) =>
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) => SongView()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toSongView(context),
      child: _background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildDetailsAndActions(),
            SizedBox(height: 6),
            _buildPositionIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _background({required Widget child}) => Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xFF48443C),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: Offset(0, 12),
              blurRadius: 24,
            ),
          ],
        ),
        child: child,
      );

  Widget _buildDetailsAndActions() => Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              song.coverImage,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          expandedColumnStart([
            styledText(
              song.title,
              fontWeight: FontWeight.w700,
              oneLineEllipsis: true,
            ),
            styledText(
              song.artistName,
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
              oneLineEllipsis: true,
            ),
          ]),
          SizedBox(width: 12),
          Icon(
            song.liked ? Icons.favorite : Icons.favorite_border,
            color: song.liked ? Palette.green : Colors.white,
            size: 28,
          ),
          SizedBox(width: 12),
          OpacityFeedback(
            onPressed: playOrPause,
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              size: 34,
            ),
          ),
          SizedBox(width: 4),
        ],
      );

  Widget _buildPositionIndicator() => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          height: 3,
          child: LinearProgressIndicator(
            value: position,
            color: Colors.white,
            backgroundColor: Colors.white.withOpacity(0.1),
          ),
        ),
      );
}
