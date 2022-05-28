import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/utils/common_widgets.dart';

class AlbumSongTile extends StatelessWidget {
  final Song song;
  final bool isSelected;

  const AlbumSongTile({
    Key? key,
    required this.song,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          _buildDetails(),
          SizedBox(width: 16),
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
        styledText(
          song.artistName,
          color: Colors.white.withOpacity(0.6),
          oneLineEllipsis: true,
        ),
      ]);
}
