import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music/MusicHomePage.dart';


void main() => runApp(const MusicApp());

// Data model for an artist and their songs
class ArtistData {
  final String name;
  final String imageUrl;
  final List<Song> songs;

  const ArtistData({
    required this.name,
    required this.imageUrl,
    required this.songs,
  });
}

// Data model for a single song
class Song {
  final String title;
  final String artist;
  final String duration;

  const Song({
    required this.title,
    required this.artist,
    required this.duration,
  });
}


// A complete list of artists with their songs and image URLs
final Map<String, ArtistData> artistsData = {
  'Ilaiyaraaja': ArtistData(
    name: 'Ilaiyaraaja',
    imageUrl:
    'https://images.moneycontrol.com/static-mcnews/2023/06/Ilaiyaraaja-1.jpg?impolicy=website&width=1600&height=900',
    songs: const [
      Song(title: 'Thenpandi Seemaiyile', artist: 'Ilaiyaraaja', duration: '5:00'),
      Song(title: 'Mandram Vantha Thendral', artist: 'Ilaiyaraaja', duration: '4:30'),
      Song(title: 'Ennulle Ennulle', artist: 'Ilaiyaraaja', duration: '4:55'),
      Song(title: 'Poongatrile', artist: 'Ilaiyaraaja', duration: '4:20'),
      Song(title: 'Solaikuyile', artist: 'Ilaiyaraaja', duration: '4:45'),
    ],
  ),
  'AR Rahman': ArtistData(
    name: 'AR Rahman',
    imageUrl:
    'https://upload.wikimedia.org/wikipedia/commons/3/3b/AR_Rahman_At_The_%E2%80%98Marvel_Anthem%E2%80%99_Launch_%283x4_cropped%29.jpg',
    songs: const [
      Song(title: 'Urvasi Urvasi', artist: 'AR Rahman', duration: '5:10'),
      Song(title: 'Vande Mataram', artist: 'AR Rahman', duration: '5:40'),
      Song(title: 'Jai Ho', artist: 'AR Rahman', duration: '5:15'),
      Song(title: 'Kandukondain Kandukondain', artist: 'AR Rahman', duration: '4:50'),
      Song(title: 'Nenje Ezhu', artist: 'AR Rahman', duration: '5:25'),
    ],
  ),
  'SP Balasubrahmanyam': ArtistData(
    name: 'SP Balasubrahmanyam',
    imageUrl:
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1G7jmr0pff79ZiYb838inj_OLpNHBM9URGg&s',
    songs: const [
      Song(title: 'Mannil Indha Kadhalandri', artist: 'SP Balasubrahmanyam', duration: '4:10'),
      Song(title: 'Keladi Kanmani', artist: 'SP Balasubrahmanyam', duration: '4:40'),
      Song(title: 'Engeyum Eppodhum', artist: 'SP Balasubrahmanyam', duration: '4:20'),
      Song(title: 'Naan Pesa Ninaipadhellam', artist: 'SP Balasubrahmanyam', duration: '4:30'),
      Song(title: 'Sundari Neeyum', artist: 'SP Balasubrahmanyam', duration: '5:00'),
    ],
  ),
  'KS Chithra': ArtistData(
    name: 'KS Chithra',
    imageUrl:
    'https://media.assettype.com/indulgexpress%2F2024-10-22%2Fgv7cy7zw%2FI-am-truly-overwhelmed-and-moved-to-experience-this-sea-of-love-and-affection-I-received-from-all-over-the-world-on-my-birthday.-I-bow-my-head-in-gratitude.-Thank-you-and-God-bless-you-all.-KSChithra.jpg?w=480&auto=format%2Ccompress&fit=max',
    songs: const [
      Song(title: 'Oru Murai Vanthu Parthaya', artist: 'KS Chithra', duration: '4:05'),
      Song(title: 'Kannalane', artist: 'KS Chithra', duration: '5:10'),
      Song(title: 'Anjali Anjali', artist: 'KS Chithra', duration: '4:45'),
      Song(title: 'Singara Velane', artist: 'KS Chithra', duration: '5:20'),
      Song(title: 'Pudhu Vellai Mazhai', artist: 'KS Chithra', duration: '5:30'),
    ],
  ),
  'Lata Mangeshkar': ArtistData(
    name: 'Lata Mangeshkar',
    imageUrl:
    'https://blog.bharatlyrics.com/wp-content/uploads/2024/01/Lata-Mangeshkar-Biography.png',
    songs: const [
      Song(title: 'Ajeeb Dastan Hai Yeh', artist: 'Lata Mangeshkar', duration: '5:00'),
      Song(title: 'Lag Jaa Gale', artist: 'Lata Mangeshkar', duration: '4:15'),
      Song(title: 'Tere Bina Zindagi Se', artist: 'Lata Mangeshkar', duration: '5:50'),
      Song(title: 'Inhi Logon Ne', artist: 'Lata Mangeshkar', duration: '3:50'),
      Song(title: 'Tujhe Dekha To', artist: 'Lata Mangeshkar', duration: '5:05'),
    ],
  ),
  'Thaman S': ArtistData(
    name: 'Thaman S',
    imageUrl:
    'https://c.saavncdn.com/artists/Thaman_S__007_20231106094011_500x500.jpg',
    songs: const [
      Song(title: 'Butta Bomma', artist: 'Thaman S', duration: '4:20'),
      Song(title: 'Samajavaragamana', artist: 'Thaman S', duration: '3:40'),
      Song(title: 'Kurchi Madathapetti', artist: 'Thaman S', duration: '4:00'),
      Song(title: 'Sweety', artist: 'Thaman S', duration: '4:15'),
      Song(title: 'Sir Osthara', artist: 'Thaman S', duration: '4:30'),
    ],
  ),
  // S. P. Balasubrahmanyam - Placeholder (URL 1)
  'SP Balasubrahmanyam': ArtistData(
    name: 'S. P. Balasubrahmanyam',
    imageUrl: 'https://yt3.googleusercontent.com/ytc/AIdro_kA66CGEVLVE0h0YpG7iU87PR2QCQcKwFC6pnD_Xk7_pRo=s900-c-k-c0x00ffffff-no-rj', // Maximum Album/Notable Album
    songs: const [
      Song(title: 'Mere Rang Mein', artist: 'SPB', duration: '6:50'),
      Song(title: 'Pehla Pehla Pyar', artist: 'SPB', duration: '4:20'),
      Song(title: 'Na Cheli Rojave', artist: 'SPB', duration: '5:00'),
      Song(title: 'Ye Swapnalokala', artist: 'SPB', duration: '4:10'),
      Song(title: 'Dekha Hai Pehli Baar', artist: 'SPB', duration: '4:55'),
    ],
  ),
  // Shreya Ghoshal - Placeholder (URL 2)
  'Shreya Ghoshal': ArtistData(
    name: 'Shreya Ghoshal',
    imageUrl: 'https://yt3.googleusercontent.com/Tyx1R_RCijQJcBOOJEDqubRkpH0CYKeb_8KfxY_KCrGVktmwkB9yXYgQmwXySThHppPycR75=s900-c-k-c0x00ffffff-no-rj',
    songs: const [
      Song(title: 'Bairi Piya', artist: 'Shreya Ghoshal', duration: '5:05'),
      Song(title: 'Dola Re Dola', artist: 'Shreya Ghoshal', duration: '6:35'),
      Song(title: 'Barso Re', artist: 'Shreya Ghoshal', duration: '5:29'),
      Song(title: 'Teri Ore', artist: 'Shreya Ghoshal', duration: '5:10'),
      Song(title: 'Manwa Laage', artist: 'Shreya Ghoshal', duration: '4:30'),
    ],
  ),
  // Sunitha - Identified from URL 7
  'Sunitha': ArtistData(
    name: 'Sunitha',
    imageUrl:
    'https://phanikumarnaidu.wordpress.com/wp-content/uploads/2013/02/singer-sunitha-4461.jpg',
    songs: const [
      Song(title: 'Pedavi Datani', artist: 'Sunitha', duration: '5:10'),
      Song(title: 'Em Sandeham Ledu', artist: 'Sunitha', duration: '4:45'),
      Song(title: 'Nenunnanani', artist: 'Sunitha', duration: '4:20'),
      Song(title: 'Yela Yela', artist: 'Sunitha', duration: '4:00'),
      Song(title: 'Ee Velalo Neevu', artist: 'Sunitha', duration: '4:30'),
    ],
  ),
  // S. Janaki - Identified from URL 8
  'S Janaki': ArtistData(
    name: 'S. Janaki',
    imageUrl:
    'https://thelistacademy.com/wp-content/uploads/2020/07/s.-janaki5f0f23984f0af.jpg',
    songs: const [
      Song(title: 'Sankarabharanam Title Song', artist: 'S. Janaki', duration: '5:20'),
      Song(title: 'Amma Amma', artist: 'S. Janaki', duration: '4:00'),
      Song(title: 'Kanmani Anbodu', artist: 'S. Janaki', duration: '4:55'),
      Song(title: 'Muthu Mani', artist: 'S. Janaki', duration: '4:30'),
      Song(title: 'Naguva Nayana', artist: 'S. Janaki', duration: '4:15'),
    ],
  ),
  // Mangli - Identified from URL 10
  'Mangli': ArtistData(
    name: 'Mangli',
    imageUrl:
    'https://www.cinejosh.com/newsimg/newsmainimg/mangli-on-her-marriage-rumours_b_0510230326.jpg',
    songs: const [
      Song(title: 'Saranga Dariya', artist: 'Mangli', duration: '4:10'),
      Song(title: 'Ramuloo Ramulaa', artist: 'Mangli', duration: '3:20'),
      Song(title: 'Oo Anthiya Oo Oo Anthiya', artist: 'Mangli', duration: '3:40'),
      Song(title: 'Mangli Bonalu Song', artist: 'Mangli', duration: '5:00'),
      Song(title: 'Bullet Song', artist: 'Mangli', duration: '4:05'),
    ],
  ),
  'hariharanData':ArtistData(
    name: 'Hariharan',
    imageUrl:
    'https://m.media-amazon.com/images/M/MV5BOTQzOWJiYjEtZmUxMC00YjA5LTgzNjUtYjMyZTVmZjVmMmZiXkEyXkFqcGc@.V1.jpg',
    songs: const [
      Song(title: 'Tu Hi Re', artist: 'Hariharan', duration: '7:12'),
      Song(title: 'Nenjukkul Peidhidum', artist: 'Hariharan', duration: '6:15'),
      Song(title: 'Hai Rama', artist: 'Hariharan', duration: '4:59'),
      Song(title: 'Pachchadanamey', artist: 'Hariharan', duration: '5:41'),
      Song(title: 'Yun Hi Chala Chal', artist: 'Hariharan', duration: '7:26'),
    ],
  ),
// 2. Anirudh Ravichander
// -----------------------------------------------------------------------------
  'anirudhRavichanderData': ArtistData(
    name: 'Anirudh Ravichander',
    imageUrl:
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjHqp2r1cAKitCvRWerMqDmM2CNetnGU9CGQ&s',
    songs: const [
      Song(title: 'Why This Kolaveri Di', artist: 'Dhanush', duration: '4:09'),
      Song(title: 'Naa Ready', artist: 'Anirudh Ravichander, Vijay', duration: '4:11'),
      Song(title: 'Chaleya', artist: 'Arijit Singh, Shilpa Rao', duration: '3:20'),
      Song(title: 'Vaathi Coming', artist: 'Anirudh Ravichander', duration: '3:56'),
      Song(title: 'Jailer Theme', artist: 'Anirudh Ravichander', duration: '1:00'),
    ],
  ),
  'sidSriramData': ArtistData(
    name: 'Sid Sriram',
    imageUrl:
    'https://i.scdn.co/image/ab6761610000e5eb5ba2d75eb08a2d672f9b69b7',
    songs: const [
      Song(title: 'Kalaavathi', artist: 'Sid Sriram', duration: '4:30'),
      Song(title: 'Inkem Inkem Inkem Kaavaale', artist: 'Sid Sriram', duration: '4:50'),
      Song(title: 'Ennadi Maayavi Nee', artist: 'Sid Sriram', duration: '4:21'),
      Song(title: 'Adiye', artist: 'Sid Sriram', duration: '5:30'),
      Song(title: 'Samajavaragamana', artist: 'Sid Sriram', duration: '3:22'),
    ],
  ),
// -----------------------------------------------------------------------------
  'sonuNigamData' : ArtistData(
    name: 'Sonu Nigam',
    imageUrl:
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1G7jmr0pff79ZiYb838inj_OLpNHBM9URGg&s',
    songs: const [
      Song(title: 'Kal Ho Naa Ho', artist: 'Sonu Nigam', duration: '5:21'),
      Song(title: 'Suraj Hua Maddham', artist: 'Sonu Nigam, Alka Yagnik', duration: '6:59'),
      Song(title: 'Abhi Mujh Mein Kahin', artist: 'Sonu Nigam', duration: '5:28'),
      Song(title: 'Sandese Aate Hain', artist: 'Sonu Nigam, Roop Kumar Rathod', duration: '6:53'),
      Song(title: 'Panchhi Nadiyan', artist: 'Sonu Nigam, Alka Yagnik', duration: '6:30'),
    ],
  ),
  'vijayAntonyData' : ArtistData(
    name: 'Vijay Antony',
    imageUrl:
    'https://m.media-amazon.com/images/I/41ebJJtw-sL.UXNaN_FMjpg_QL85.jpg',
    songs: const [
      Song(title: 'Nakka Mukka', artist: 'Vijay Antony', duration: '4:11'),
      Song(title: 'Chinna Thamarai', artist: 'Krish, Suchitra', duration: '5:02'),
      Song(title: 'Aathichudi', artist: 'Vijay Antony, Balaji', duration: '5:20'),
      Song(title: 'Dailamo Dailamo', artist: 'Vijay Antony, Sangeetha Rajeshwaran', duration: '4:37'),
      Song(title: 'Poochandi', artist: 'Vijay Antony', duration: '4:49'),
    ],
  ),
  'deviSriPrasadData' : ArtistData(
    name: 'Devi Sri Prasad',
    imageUrl:
    'https://static.toiimg.com/thumb/msid-114932012,width-1070,height-580,imgsize-45212,resizemode-75,overlay-toi_sw,pt-32,y_pad-40/photo.jpg',
    songs: const [
      Song(title: 'O Podu', artist: 'Karthik, Kalpana', duration: '4:51'),
      Song(title: 'Srivalli', artist: 'Sid Sriram', duration: '3:44'),
      Song(title: 'Ringa Ringa', artist: 'Priya Hemesh', duration: '5:32'),
      Song(title: 'Ammadu Let’s Do Kummudu', artist: 'DSP, Ranina Reddy', duration: '4:35'),
      Song(title: 'Jigelu Rani', artist: 'Ragasya', duration: '4:30'),
    ],
  ),
  'sjSuryahData' : ArtistData(
    name: 'S. J. Suryah',
    imageUrl:
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnHJKvpfmwDVgA2kR8U3sEGhdoNqMl1SwNjA&s',
    songs: const [
      Song(title: 'Vaaji Vaaji', artist: 'Hariharan, Sadhana Sargam', duration: '6:00'), // Actor
      Song(title: 'Thottal Poomalarum', artist: 'Hariharan, Harini', duration: '5:33'), // Composer
      Song(title: 'Kumbakarai', artist: 'Karthik, Anuradha Sriram', duration: '5:21'), // Actor
      Song(title: 'Pattu Pattu', artist: 'Anuradha Sriram, Shankar Mahadevan', duration: '5:01'), // Actor
      Song(title: 'New New', artist: 'Karthik, Vijay Prakash, Sunitha', duration: '4:32'), // Composer
    ],
  ),

// -----------------------------------------------------------------------------
// 8. Yuvan Shankar Raja
// -----------------------------------------------------------------------------
  'yuvanShankarRajaData' : ArtistData(
    name: 'Yuvan Shankar Raja',
    imageUrl:
    'https://c.files.bbci.co.uk/D19C/production/_132706635_gettyimages-453487234.jpg',
    songs: const [
      Song(title: 'Ninaithu Ninaithu', artist: 'Yuvan Shankar Raja', duration: '5:35'),
      Song(title: 'Oru Naalil', artist: 'Manikka Vinayagam, Vijay Yesudas', duration: '5:08'),
      Song(title: 'Kadhal Valarthen', artist: 'S. P. B. Charan', duration: '5:49'),
      Song(title: 'Rowdy Baby', artist: 'Dhanush, Dhee', duration: '4:34'),
      Song(title: 'Arabu Naade', artist: 'Karthik, Chorus', duration: '4:20'),
    ],
  ),
  'harrisJayarajData' : ArtistData(
    name: 'Harris Jayaraj',
    imageUrl:
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6ImQwKVkRgOJn1coZc2SU6-eSoDtxZ_8tlQ&s',
    songs: const [
      Song(title: 'Vaseegara', artist: 'Bombay Jayashri', duration: '5:08'),
      Song(title: 'Nenjukkul Peidhidum', artist: 'Hariharan', duration: '6:15'), // Shared with Hariharan, but composed by Harris
      Song(title: 'Adiye Adiye', artist: 'Karthik', duration: '5:00'),
      Song(title: 'Hosanna', artist: 'Vijay Prakash, Suzanne D’Mello', duration: '5:30'),
      Song(title: 'Ennamo Seidhai', artist: 'S P B Charan, Mahalakshmi Iyer', duration: '5:10'),
    ],
  ),
  'Usha Uthup': ArtistData(
    name: 'Usha Uthup',
    imageUrl:
    'https://www.postoast.com/wp-content/uploads/2022/02/Best-Female-playback-singers-in-India-Usha-Uthup.webp',
    songs: const [
      Song(title: 'Darling', artist: 'Usha Uthup', duration: '3:50'),
      Song(title: 'Rambha Ho Ho Ho', artist: 'Usha Uthup', duration: '6:10'),
      Song(title: 'Hari Om Hari', artist: 'Usha Uthup', duration: '5:20'),
      Song(title: 'Koi Yahan Nache Nache', artist: 'Usha Uthup', duration: '6:00'),
      Song(title: 'One Two Cha Cha Cha', artist: 'Usha Uthup', duration: '3:25'),
    ],
  ),
  // G. V. Prakash Kumar - Identified from URL 14
  'G V Prakash Kumar': ArtistData(
    name: 'G. V. Prakash Kumar',
    imageUrl:
    'https://in.bmscdn.com/iedb/artist/images/website/poster/large/g-v-prakash-kumar-3973-15-02-2022-01-57-26.jpg',
    songs: const [
      Song(title: 'Pookal Pookum', artist: 'GVP', duration: '5:40'),
      Song(title: 'Manasellam Mazhaiye', artist: 'GVP', duration: '5:20'),
      Song(title: 'Pirai Thedum', artist: 'GVP', duration: '4:00'),
      Song(title: 'Neeve', artist: 'GVP', duration: '3:50'),
      Song(title: 'Unnale (Love Theme)', artist: 'GVP', duration: '2:10'),
    ],
  ),
};

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Singers & Composers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212), // Darker background for a sleek look
        useMaterial3: false,
      ),
      // Start the app on the Home Page, assuming MusicHomePage is your initial view
      home: const MusicHomePage(),
      // Define a route for the PlaylistPage if you start on Home
      routes: {
        '/playlist': (context) => const PlaylistPage(),
      },
    );
  }
}

// =========================================================================
//  PlaylistPage (Artist Gallery) Implementation
// =========================================================================

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  // ===== Time & Typewriter =====
  late Timer _clockTimer;
  late Timer _typeTimer;
  String _utcText = '';
  final String _fullTitle = 'Music Artists Gallery';
  String _typedTitle = '';
  int _typeIndex = 0;

  @override
  void initState() {
    super.initState();
    _startClock();
    _startTypewriter();
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _typeTimer.cancel();
    super.dispose();
  }

  void _startClock() {
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now().toUtc();
      final formattedTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} UTC';
      if (mounted) {
        setState(() {
          _utcText = formattedTime;
        });
      }
    });
  }

  void _startTypewriter() {
    _typeTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_typeIndex < _fullTitle.length) {
        if (mounted) {
          setState(() {
            _typedTitle = _fullTitle.substring(0, _typeIndex + 1);
            _typeIndex++;
          });
        }
      } else {
        _typeTimer.cancel();
      }
    });
  }

  void _onCardTap(ArtistData artist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongsPage(artist: artist),
      ),
    );
  }

  void _onSearchTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search not yet implemented')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _BottomNav(
        onHome: () {
          // Correctly navigate back to the Home Page and replace the current view
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MusicHomePage()),
          );
        },
        onPlaylist: () {}, // Already on Playlist
        onPremium: () => _showSnack('Premium (no action)'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Sleek, deep-space background
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: Column(
                    children: [
                      Text(
                        _typedTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFffeb3b), // Brighter yellow
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 10,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Global Time: $_utcText',
                        style: const TextStyle(fontSize: 14, color: Color(0xFFb3e5fc)),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1400),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 90),
                      child: _GalleryWrap(
                        artists: artistsData,
                        onCardTap: _onCardTap,
                        onSearchTap: _onSearchTap,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
    );
  }
}

// ===================== Gallery =====================
class _GalleryWrap extends StatelessWidget {
  final Map<String, ArtistData> artists;
  final Function(ArtistData) onCardTap;
  final VoidCallback onSearchTap;

  const _GalleryWrap({
    required this.artists,
    required this.onCardTap,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 24,
      runSpacing: 24,
      children: artists.entries
          .map((entry) => _GalleryCard(
        artist: entry.value,
        onTap: () => onCardTap(entry.value),
        onSearch: onSearchTap,
      ))
          .toList(),
    );
  }
}

// IMPROVED _GalleryCard Design (Amazing Features)
class _GalleryCard extends StatelessWidget {
  final ArtistData artist;
  final VoidCallback onTap;
  final VoidCallback onSearch;

  const _GalleryCard({
    required this.artist,
    required this.onTap,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150, // Increased width for better display
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.withOpacity(0.5), width: 1),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 16, offset: Offset(0, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Artist Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                artist.imageUrl,
                fit: BoxFit.cover,
                height: 150, // Large image area
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
                  color: Colors.grey.shade800,
                  child: const Center(child: Icon(Icons.person, size: 50, color: Colors.white70)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    artist.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  _GradientPillButton(
                    label: 'View Songs',
                    onPressed: onTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientPillButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _GradientPillButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onPressed,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF6a11cb), Color(0xFF2575fc)], // Deep purple to blue gradient
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// ===================== Bottom Nav =====================
class _BottomNav extends StatelessWidget {
  final VoidCallback onHome;
  final VoidCallback onPlaylist;
  final VoidCallback onPremium;

  const _BottomNav({
    required this.onHome,
    required this.onPlaylist,
    required this.onPremium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1e1e1e), // Darker Nav bar
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(0, -5),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavBtn(label: ' Home', onTap: onHome, icon: Icons.home),
            _NavBtn(label: ' Playlist', onTap: onPlaylist, icon: Icons.queue_music),
            _NavBtn(label: ' Premium', onTap: onPremium, icon: Icons.workspace_premium),
          ],
        ),
      ),
    );
  }
}

class _NavBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData icon;

  const _NavBtn({required this.label, required this.onTap, required this.icon});

  @override
  State<_NavBtn> createState() => _NavBtnState();
}

class _NavBtnState extends State<_NavBtn> with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 1.1),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF282828),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: Colors.white, size: 20),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== SongsPage (Clean and Amazing Designs) =====================
class SongsPage extends StatefulWidget {
  final ArtistData artist;

  const SongsPage({super.key, required this.artist});

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  int? selectedIndex;
  bool isPlaying = false;

  void _onSongTap(int index) {
    if (selectedIndex == index) {
      // If tapping the currently playing song, open song detail
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SongDetailPage(
            song: widget.artist.songs[index],
            relatedSongs: widget.artist.songs.where((s) => s.title != widget.artist.songs[index].title).toList(),
          ),
        ),
      );
    } else {
      // Start playing a new song
      setState(() {
        selectedIndex = index;
        isPlaying = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Playing: ${widget.artist.songs[index].title}')),
      );
    }
  }

  void _togglePlayPause() {
    if (selectedIndex == null) return;
    setState(() {
      isPlaying = !isPlaying;
    });
    final song = widget.artist.songs[selectedIndex!];

  }

  @override
  Widget build(BuildContext context) {
    final nowPlaying = selectedIndex != null ? widget.artist.songs[selectedIndex!] : null;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: const Color(0xFF1e1e1e),
                expandedHeight: 280.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    widget.artist.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                    ),
                  ),
                  background: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                        stops: [0.7, 1.0],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.darken,
                    child: Image.network(
                      widget.artist.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, bottom: 10),
                  child: const Text(
                    'Top Songs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final song = widget.artist.songs[index];
                    final isCurrent = selectedIndex == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                      child: Card(
                        color: isCurrent
                            ? Colors.blueGrey.withOpacity(0.22)
                            : Colors.white.withOpacity(0.05),
                        elevation: isCurrent ? 4 : 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: isCurrent
                              ? Icon(isPlaying ? Icons.graphic_eq : Icons.pause_circle_filled, color: Colors.blueAccent)
                              : Text('${index + 1}', style: TextStyle(color: Colors.white70)),
                          title: Text(
                            song.title,
                            style: TextStyle(
                              color: isCurrent ? Colors.blueAccent : Colors.white,
                              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(song.duration, style: TextStyle(color: Colors.blueAccent)),
                              if (isCurrent)
                                IconButton(
                                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.blueAccent),
                                  onPressed: _togglePlayPause,
                                ),
                            ],
                          ),
                          onTap: () => _onSongTap(index),
                        ),
                      ),
                    );
                  },
                  childCount: widget.artist.songs.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          if (nowPlaying != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900]?.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black87, blurRadius: 10, offset: Offset(0, -2)),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.artist.imageUrl,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nowPlaying.title,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            nowPlaying.artist,
                            style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle_fill,
                        color: isPlaying ? Colors.greenAccent : Colors.blueAccent,
                        size: 36,
                      ),
                      onPressed: _togglePlayPause,
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
class SongDetailPage extends StatelessWidget {
  final Song song;
  final List<Song> relatedSongs;

  const SongDetailPage({
    super.key,
    required this.song,
    required this.relatedSongs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(song.title),
        backgroundColor: const Color(0xFF1e1e1e),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${song.title}', style: _headerStyle),
            const SizedBox(height: 8),
            Text('Artist: ${song.artist}', style: _textStyle),
            const SizedBox(height: 8),
            const SizedBox(height: 16),
            Text('Related Songs', style: _headerStyle),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: relatedSongs.length,
                itemBuilder: (context, index) {
                  final related = relatedSongs[index];
                  return ListTile(
                    title: Text(related.title),
                    subtitle: Text('By ${related.artist}'),
                    trailing: Text(related.duration),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SongDetailPage(
                            song: related,
                            relatedSongs: relatedSongs.where((s) => s.title != related.title).toList(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const TextStyle _headerStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
const TextStyle _textStyle = TextStyle(fontSize: 16, color: Colors.white70);

