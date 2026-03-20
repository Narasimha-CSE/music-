// Update your Song model like this
class Song {
  final String title;
  final String artist;
  final String composer; // <-- add this field
  final String duration;

  const Song({
    required this.title,
    required this.artist,
    required this.composer, // <-- required parameter
    required this.duration,
  });
}
