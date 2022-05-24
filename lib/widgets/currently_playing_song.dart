import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/views/song.dart';

class CurrentlyPlayingSong extends StatelessWidget {
  final Song song;

  const CurrentlyPlayingSong({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: ((context, animation, secondaryAnimation) =>
              SongView(song: song)),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ));
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xFF48443C),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        song.artistName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Icon(
                  song.liked ? Icons.favorite : Icons.favorite_border,
                  color: song.liked ? Palette.green : Colors.white,
                  size: 28,
                ),
                SizedBox(width: 12),
                Icon(
                  Icons.play_arrow,
                  size: 34,
                  color: Colors.white,
                ),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(height: 6),
            // progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  value: 0.2,
                  color: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
