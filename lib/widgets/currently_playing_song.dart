import 'package:flutter/material.dart';
import 'package:spotify_clone/models/song.dart';

class CurrentlyPlayingSong extends StatelessWidget {
  final Song song;

  const CurrentlyPlayingSong({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      song.artistName,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                song.liked ? Icons.favorite : Icons.favorite_border,
                color: song.liked ? Color(0xFF1ed760) : Colors.white,
                size: 28,
              ),
              SizedBox(width: 16),
              Icon(
                Icons.play_arrow,
                size: 34,
                color: Colors.white,
              ),
              SizedBox(width: 8),
            ],
          ),
          SizedBox(height: 8),
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
    );
  }
}
