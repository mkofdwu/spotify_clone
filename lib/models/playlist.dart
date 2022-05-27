import 'song.dart';

class Playlist {
  final String coverImage;
  final String title;
  final String ownerName;
  final bool isAlbum;
  final bool isPinned;
  final List<Song> songs;

  Playlist({
    required this.coverImage,
    required this.title,
    required this.ownerName,
    required this.isAlbum,
    required this.isPinned,
    required this.songs,
  });
}
