import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'gemini_service.dart';

class Song {
  final String name;
  final String singer;
  final String url;
  final String img;

  Song({
    required this.name,
    required this.singer,
    required this.url,
    required this.img,
  });
}

class AIPage extends StatefulWidget {
  const AIPage({super.key});

  @override
  State<AIPage> createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> with SingleTickerProviderStateMixin {

  static const String _LOTTIE_ASSET = "assets/loading.lottie.json";

  final AudioPlayer player = AudioPlayer();
  final TextEditingController controller = TextEditingController();

  List<Song> songs = [];
  Song? currentSong;

  bool loading = false;
  bool isPlaying = false;

  final List<Song> appSongs = [

    Song(
      name: "Shape of You",
      singer: "Ed Sheeran",
      url:
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
      img:
      "https://i.scdn.co/image/ab67616d0000b273c6a7a2f0ed4d7e4f88e969b1",
    ),

    Song(
      name: "Perfect",
      singer: "Ed Sheeran",
      url:
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
      img:
      "https://i.scdn.co/image/ab67616d0000b273c6a7a2f0ed4d7e4f88e969b1",
    ),

    Song(
      name: "Believer",
      singer: "Imagine Dragons",
      url:
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
      img:
      "https://i.scdn.co/image/ab67616d0000b273e7df7c4c0d6f7f0a1d4a3b4c",
    ),

    Song(
      name: "Let Her Go",
      singer: "Passenger",
      url:
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
      img:
      "https://i.scdn.co/image/ab67616d0000b273ff9ca10b55ce82ae553c8228",
    ),

    Song(
      name: "Faded",
      singer: "Alan Walker",
      url:
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3",
      img:
      "https://i.scdn.co/image/ab67616d0000b273d1a8a4c0f9b8679513762c1f",
    ),
  ];

  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.9,
      upperBound: 1,
    )..forward();
  }

  Future<void> askAI() async {

    if (controller.text.trim().isEmpty) return;

    setState(() {
      loading = true;
      songs.clear();
    });

    String prompt = """
User mood: ${controller.text}

From this list choose songs:

${appSongs.map((e) => e.name).join(",")}

Return only song names.
""";

    final result = await GeminiService.askAI(prompt);

    List<String> names = result.split("\n");

    List<Song> matched = appSongs
        .where((song) =>
        names.any((name) => name.toLowerCase().contains(song.name.toLowerCase())))
        .toList();

    setState(() {
      songs = matched;
      loading = false;
    });
  }

  Future<void> playSong(Song song) async {

    await player.setUrl(song.url);
    player.play();

    setState(() {
      currentSong = song;
      isPlaying = true;
    });

    player.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });
  }

  void nextSong() {

    int index = songs.indexOf(currentSong!);

    if (index < songs.length - 1) {
      playSong(songs[index + 1]);
    }
  }

  void prevSong() {

    int index = songs.indexOf(currentSong!);

    if (index > 0) {
      playSong(songs[index - 1]);
    }
  }

  @override
  void dispose() {
    player.dispose();
    controller.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Smart Music AI"),
        centerTitle: true,
      ),

      body: Stack(
        children: [

          Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [

                TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Search Melody or OtherSongs",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ScaleTransition(
                  scale: _buttonController,
                  child: ElevatedButton(
                    onPressed: askAI,
                    child: const Text("Find Songs"),
                  ),
                ),

                const SizedBox(height: 20),

                if (loading)
                  const CircularProgressIndicator(),

                Expanded(
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {

                      final song = songs[index];

                      return Card(
                        child: ListTile(
                          leading: Hero(
                            tag: "album-${song.name}",
                            child: Image.network(song.img, width: 50),
                          ),
                          title: Text(song.name),
                          subtitle: Text(song.singer),
                          trailing: const Icon(Icons.play_arrow),
                          onTap: () => playSong(song),
                        ),
                      );
                    },
                  ),
                )

              ],
            ),
          ),

          if (currentSong != null)
            AnimatedSlide(
              duration: const Duration(milliseconds: 400),
              offset: const Offset(0, 0),

              child: Align(
                alignment: Alignment.bottomCenter,
                child: _MiniPlayer(
                  song: currentSong!,
                  player: player,
                  onTap: () {},
                  onNext: nextSong,
                  onPrev: prevSong,
                  isPlaying: isPlaying,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class _MiniPlayer extends StatelessWidget {

  const _MiniPlayer({
    required this.song,
    required this.player,
    required this.onTap,
    required this.onNext,
    required this.onPrev,
    required this.isPlaying,
  });

  final Song song;
  final AudioPlayer player;
  final VoidCallback onTap;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 15,
            )
          ],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            StreamBuilder<Duration?>(
              stream: player.durationStream,
              builder: (context, durationSnapshot) {

                final total = durationSnapshot.data ?? Duration.zero;

                return StreamBuilder<Duration>(
                  stream: player.positionStream,
                  builder: (context, positionSnapshot) {

                    final pos = positionSnapshot.data ?? Duration.zero;

                    double progress =
                    total.inMilliseconds > 0
                        ? pos.inMilliseconds / total.inMilliseconds
                        : 0;

                    return LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation(
                        Color(0xFF1DB954),
                      ),
                      minHeight: 2,
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 8),

            Row(
              children: [

                Hero(
                  tag: "album-${song.name}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(song.img,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(song.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),

                      Text(song.singer,
                          style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),

                if (isPlaying)
                  Lottie.asset(
                    "assets/music_wave.json",
                    width: 40,
                    height: 40,
                    repeat: true,
                  ),

                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  color: Colors.white,
                  onPressed: onPrev,
                ),

                IconButton(
                  icon: Icon(
                    isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  color: const Color(0xFF1DB954),
                  iconSize: 32,
                  onPressed: () async {

                    if (isPlaying) {
                      await player.pause();
                    } else {
                      await player.play();
                    }
                  },
                ),

                IconButton(
                  icon: const Icon(Icons.skip_next),
                  color: Colors.white,
                  onPressed: onNext,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}