class Song {
  final String coverImage;
  final String title;
  final String artistName;
  final List<String> tags; // lyrics, e
  final bool liked;

  Song({
    required this.coverImage,
    required this.title,
    required this.artistName,
    required this.tags,
    required this.liked,
  });
}
