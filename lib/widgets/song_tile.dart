import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/utils/common_widgets.dart';
import 'package:spotify_clone/widgets/song_tag.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final bool isSelected;

  const SongTile({
    Key? key,
    required this.song,
    required this.isSelected,
  }) : super(key: key);

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
          _buildDetails(),
          SizedBox(width: 16),
          if (song.liked) ...[
            Icon(Icons.favorite, color: Palette.green, size: 20),
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

  Widget _buildDetails() => expandedColumnStart([
        styledText(
          song.title,
          color: isSelected ? Palette.green : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          oneLineEllipsis: true,
        ),
        SizedBox(height: 4),
        Row(
          children: [
            for (final tag in song.tags) SongTag(tag: tag),
            Flexible(
              child: styledText(
                song.artistName,
                color: Colors.white.withOpacity(0.6),
                oneLineEllipsis: true,
              ),
            ),
          ],
        ),
      ]);
}
