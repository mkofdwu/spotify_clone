import 'package:flutter/material.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/widgets/song_tag.dart';

class SongTile extends StatelessWidget {
  final Song song;

  const SongTile({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // flutter has a listtile type, but in this case spotify's tile
    // is a bit more customized. Hence, we want to create a custom widget
    // with our own UI definition
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // image
          Image.asset(song.coverImage,
              width: 50, height: 50, fit: BoxFit.cover),
          SizedBox(width: 12),
          Expanded(
            child: _buildDetails(),
          ),
          SizedBox(width: 16),
          if (song.liked) ...[
            Icon(Icons.favorite, color: Color(0xFF1ed760), size: 20),
            SizedBox(width: 24),
          ],
          Icon(
            Icons.more_vert,
            color: Colors.white.withOpacity(0.6),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              for (final tag in song.tags) SongTag(tag: tag),
              Flexible(
                child: Text(
                  song.artistName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
