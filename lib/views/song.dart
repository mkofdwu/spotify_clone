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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.3,
                        color: Colors.white,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0:00',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        Text(
                          '3:26',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.shuffle, size: 24, color: Colors.white),
                        Spacer(flex: 3),
                        Icon(Icons.skip_previous,
                            size: 36, color: Colors.white),
                        Spacer(flex: 2),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Icon(Icons.play_arrow, size: 36),
                          ),
                        ),
                        Spacer(flex: 2),
                        Icon(Icons.skip_next, size: 36, color: Colors.white),
                        Spacer(flex: 3),
                        Icon(Icons.loop, size: 24, color: Colors.white),
                      ],
                    ),
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
}
