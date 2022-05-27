import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/utils/common_widgets.dart';

// shares some similarities with SongTile, so a lot of code is copied from there
class PlaylistTile extends StatelessWidget {
  final Playlist playlist;
  final bool isSelected;

  const PlaylistTile({
    Key? key,
    required this.playlist,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // image
          Image.asset(
            playlist.coverImage,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget _buildDetails() => expandedColumnStart([
        styledText(
          playlist.title,
          color: isSelected ? Palette.green : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          oneLineEllipsis: true,
        ),
        SizedBox(height: 2),
        Row(
          children: [
            if (playlist.isPinned)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.push_pin,
                  color: Palette.green,
                  size: 13,
                ),
              ),
            styledText(
              playlist.isAlbum ? 'Album' : 'Playlist',
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
            ),
            Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            styledText(
              playlist.title == 'Liked Songs'
                  ? '${playlist.songs.length} songs'
                  : playlist.ownerName,
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
            ),
          ],
        ),
      ]);
}
