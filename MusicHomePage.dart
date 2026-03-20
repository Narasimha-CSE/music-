import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'PlaylistPage.dart'; // Ensure this file exists
import 'PremiumPage.dart'; // Ensure this file exists
import 'dart:math';
import 'package:lottie/lottie.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'ai_page.dart';
// Requires 'lottie' dependency in pubspec.yaml

// NOTE: You must add the lottie dependency to your pubspec.yaml:
// dependencies:
//   flutter:
//     sdk: flutter
//   ...
//   lottie: ^3.1.0
// Also ensure you have placeholder files for PlaylistPage.dart and PremiumPage.dart
// and a Lottie JSON file at 'assets/lottie/music_visualizer.json'

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void _openAIPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AIPage(),
      ),
    );
  }

  // GEMINI BUTTON
  Widget buildGeminiButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.auto_awesome),
      label: const Text("Music AI"),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1DB954),
      ),
      onPressed: () {
        _openAIPage(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music App"),
        backgroundColor: const Color(0xFF1DB954),
      ),
      body: Center(
        child: buildGeminiButton(context),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Music",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
        ),
        primaryColor: const Color(0xFF1DB954),
        sliderTheme: const SliderThemeData(thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7)),
      ),
      home: const MusicHomePage(),
    );
  }

/* ----------------------------- DATA MODELS ----------------------------- */

class Song {
  final String name;
  final String img;
  final String desc;
  final String audio;
  final String singer;
  final String movie;
  final List<String> lyrics;

  Song({
    required this.name,
    required this.img,
    required this.desc,
    required this.audio,
    this.singer = "Unknown",
    this.movie = "Unknown",
    this.lyrics = const [],
  });
}

/* ----------------------------- STATIC DATA (Truncated for brevity, assuming integrity) ----------------------------- */

const _DEFAULT_AUDIO = "";
// ... (All maps and lists like _songDesc, Recentlyplayed, TrendingMusic, etc., remain unchanged)

List<Song> _makeList(List<Map<String, String>> raw) {
  // ... (implementation remains unchanged)
  const Map<String, String> _songDesc = {
    "Chill Vibes": "Relaxing chill beats for study or late-night focus.",
    "Focus Beats": "Instrumental rhythms to keep you in flow.",
    "Night Mode": "Smooth tracks for the late hours.",
    "Lo-Fi Drive": "Lo-fi warmth for long drives and rainy days.",
    "Romantic": "Heart-melting ballads and soft pop.",
    "Top 50": "The hottest tracks topping the charts.",
    "Viral India": "Songs taking India by storm.",
    "EDM Boom": "Festival-ready bangers & drops.",
    "Rap Rotation": "Bars, beats, and basslines.",
    "Trending": "What everyone is playing right now.",
    "Chuttamalle-DEVARA": "From the blockbuster movie DEVARA.",
    "Nuvvunte chaaley-ANDHRA KING TALUKA": "A soulful melody that captures the heart.",
    "Bujji Talli-THANDEL ": "A peppy number from THANDEL.",
    "Namo Namah shivavaya-THANDEL ": "A divine, spiritual track.",
    "Kissik-PUSHPA-2": "A trendy song from PUSHPA-2.",
    "Naa Naa Hyraanaa-GAME CHANGER": "An energetic song from GAME CHANGER.",
    "All Hail The Tiger-DEVARA": "The powerful anthem from DEVARA.",
    "Bohemian Rhapsody": "An iconic rock opera by Queen.",
    "Stairway to Heaven": "A legendary rock ballad by Led Zeppelin.",
    "Hotel California": "The Eagles' timeless rock masterpiece.",
    "Come as You Are": "A classic grunge anthem by Nirvana.",
    "Holocene": "A beautiful indie folk track by Bon Iver.",
    "Mess Is Mine": "A heartfelt indie folk song by Vance Joy.",
    "The Stable Song": "An intimate and warm folk song by Gregory Alan Isakov.",
    "Bloom": "A serene and uplifting folk track by The Paper Kites",
  };
  const Map<String, String> _singerMap = {
    "Chuttamalle-DEVARA": "Anirudh Ravichander, Ramya Behara",
    "Nuvvunte chaaley-ANDHRA KING TALUKA": "Haricharan",
    "Bujji Talli-THANDEL ": "Armaan Malik",
    "Namo Namah shivavaya-THANDEL ": "Vijay Prakash",
    "Kissik-PUSHPA-2": "Devi Sri Prasad",
    "Naa Naa Hyraanaa-GAME CHANGER": "Shankar Mahadevan, S. Thaman",
    "All Hail The Tiger-DEVARA": "Anirudh Ravichander",
    "Bohemian Rhapsody": "Queen",
    "Stairway to Heaven": "Led Zeppelin",
    "Hotel California": "The Eagles",
    "Come as You Are": "Nirvana",
    "Holocene": "Bon Iver",
    "Mess Is Mine": "Vance Joy",
    "The Stable Song": "Gregory Alan Isakov",
    "Bloom": "The Paper Kites",
  };
  const Map<String, String> _movieMap = {
    "Chuttamalle-DEVARA": "DEVARA",
    "Nuvvunte chaaley-ANDHRA KING TALUKA": "ANDHRA KING TALUKA",
    "Bujji Talli-THANDEL ": "THANDEL",
    "Namo Namah shivavaya-THANDEL ": "THANDEL",
    "Kissik-PUSHPA-2": "PUSHPA-2",
    "Naa Naa Hyraanaa-GAME CHANGER": "GAME CHANGER",
    "All Hail The Tiger-DEVARA": "DEVARA",
    "Bohemian Rhapsody": "Unknown",
    "Stairway to Heaven": "Unknown",
    "Hotel California": "Unknown",
    "Come as You Are": "Unknown",
    "Holocene": "Unknown",
    "Mess Is Mine": "Unknown",
    "The Stable Song": "Unknown",
    "Bloom": "Unknown",
  };
  const Map<String, List<String>> _lyricsMap = {
    "Chuttamalle-DEVARA": [
      "Chuttamalle chuttumalle nuvvu nenu kalisunte...",
      "Choopulake choopu patti vaatakese pedaalake...",
      "Mellaga mellaga kalisi...",
      "Needa laaga chuttukoni...",
      "Vennela laaga veeraatla...",
      "Veesukunna vaallu naalo...",
      "Ninnu chooda chooda...",
      "Naalo nene kaani..."
    ],
    "All Hail The Tiger-DEVARA": [
      "All Hail The Tiger, Devara...",
      "All Hail The Tiger, Devara...",
      "Cheema chuttu choodu chukkala...",
      "Cheema chuttu choodu chukkala...",
      "Puli vaadu vachadu...",
      "Puli vaadu vachadu...",
      "Devaa raa...",
      "Devaa raa..."
    ],
  };
  return raw.map((m) {
    final name = m["name"]!;
    return Song(
      name: name,
      img: m["img"]!,
      desc: _songDesc[name] ?? "Hand-picked selection for your vibe.",
      audio: m["audio"] ?? _DEFAULT_AUDIO,
      singer: _singerMap[name] ?? "Various Artists",
      movie: _movieMap[name] ?? "Original",
      lyrics: _lyricsMap[name] ?? ["Lyrics not available for this song."],
    );
  }).toList();
}
final List<Song> Recentlyplayed = _makeList([
  {"name": "Chill Vibes", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjHqp2r1cAKitCvRWerMqDmM2CNetnGU9CGQ&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Focus Beats", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCL9tSv8Nxwk_sNS2BNltBEEEcI_uBIk0bJA&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Night Mode", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_hYEYTzH-nYV9tsWxvXZENIuJGbwmXph_ug&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Lo-Fi Drive", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFFyMbgxfEQk1SVtLtE9iwTqn4xnHawcPSyg&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Romantic", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGBULklRqXvcmX8uUeO4aant-Xs56P2kSU6g&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Top 50", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzdEy5c-Kenv7lKsL_OZ4jHnNcgSj1Za6m_Q&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Viral India", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlfhDK0XaVOweFoNRhkMjyKcaXuN9C-SNAlQ&s", "audio": "assets/audio/All Hail The Tiger.mp3"},
  {"name": "EDM Boom", "img": "https://i.ytimg.com/vi/60ItHLz5WEA/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Rap Rotation", "img": "https://i.ytimg.com/vi/lRqqrgxBX5E/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Trending", "img": "https://i.ytimg.com/vi/E7wJTI-1dvQ/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Chill Vibes", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTx6MHjXbcF7nRcitFWxSPzdWT35faua4xQ5g&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Focus Beats", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWx4M3LtiG_aBGFc7J9DadMJ3sNUFlJIHqYw&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Night Mode", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs8gZRJg3rItmeVnEzVKX6lqj9TkQIM4zltQ&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Lo-Fi Drive", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIYhD-92q8L-Hqm4BAxTtaC-ppvwIJmeqVDw&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Romantic", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStv_l0irOsBZ-Csj_d0Btp9izk9LtSUgHdWQ&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Top 50", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD5Qy-G6UwsI8ZbkTLrKQZPzX9lW-0Cb2yVw&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Viral India", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEs60NrxU2i_esU63V-tQxftF7zUCv32ei8w&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "EDM Boom", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQiC05zKqgMIstYbQjv6Xu5GeGTn5fT59JqQ&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Rap Rotation", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUNLOnsK1RQi4dmXY0w-nn-n177Gh77pIZbA&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Trending", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-uOkXgae210riBbZBA61EBORBAjdimFRxHw&s", "audio": "assets/audio/Chuttamalle.mp3"},
]);

final List<Song> TrendingMusic = _makeList([
  {"name": "Chuttamalle-DEVARA", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTx6MHjXbcF7nRcitFWxSPzdWT35faua4xQ5g&s", "audio": "https://res.cloudinary.com/dk6xryobo/video/upload/v1773160667/Chuttamalle_1_y32mbt.mp3"},
  {"name": "Nuvvunte chaaley-ANDHRA KING TALUKA", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWx4M3LtiG_aBGFc7J9DadMJ3sNUFlJIHqYw&s", "audio": "https://res.cloudinary.com/dk6xryobo/video/upload/v1773162364/Nuvvunte_Chaley_swyzpq.mp3"},
  {"name": "Bujji Talli-THANDEL ", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs8gZRJg3rItmeVnEzVKX6lqj9TkQIM4zltQ&s", "audio": "https://res.cloudinary.com/dk6xryobo/video/upload/v1773161060/Bujji_Thalli_jwcbdh.mp3"},
  {"name": "Namo Namah shivavaya-THANDEL ", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIYhD-92q8L-Hqm4BAxTtaC-ppvwIJmeqVDw&s", "audio": "https://res.cloudinary.com/dk6xryobo/video/upload/v1773161051/Namo_Namah_Shivaya_fltltt.mp3"},
  {"name": "Kissik-PUSHPA-2", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStv_l0irOsBZ-Csj_d0Btp9izk9LtSUgHdWQ&s", "audio": "https://res.cloudinary.com/dk6xryobo/video/upload/v1773161049/Kissik_id4t8i.mp3"},
  {"name": "Naa Naa Hyraanaa-GAME CHANGER", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD5Qy-G6UwsI8ZbkTLrKQZPzX9lW-0Cb2yVw&s", "audio": "https://res.cloudinary.com/dk6xryobo/video/upload/v1773161049/Naanaa_Hyraanaa_m2tjyg.mp3"},
  {"name": "All Hail The Tiger-DEVARA", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEs60NrxU2i_esU63V-tQxftF7zUCv32ei8w&s", "audio": "https://res.cloudinary.com/dk6xryobo/video/upload/v1773161028/All_Hail_The_Tiger_pq3a1p.mp3"},
  {"name": "Peelings song-Pushpa-2", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQiC05zKqgMIstYbQjv6Xu5GeGTn5fT59JqQ&s", "audio": "https://res.cloudinary.com/dk6xryobo/video/upload/v1773162367/Peelings_egpfp7.mp3"},
  {"name": "godari gattumeeda-Sankrantiki vastunnam", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUNLOnsK1RQi4dmXY0w-nn-n177Gh77pIZbA&s", "audio": "https://res.cloudinary.com/dk6xryobo/video/upload/v1773161048/Godari_Gattu_di8qjh.mp3"},
  {"name": "The Rage Of Daku -Daaku Maharaj", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-uOkXgae210riBbZBA61EBORBAjdimFRxHw&s", "audio": "https://res.cloudinary.com/dk6xryobo/video/upload/v1773162030/The_Rage_of_Daaku_fyyaan.mp3"},
  {"name": "Aaya Sher-Paradise","img":"https://th-i.thgim.com/public/entertainment/movies/khrwfv/article69908639.ece/alternates/FREE_1200/Nani.jpeg","audio":"https://res.cloudinary.com/dk6xryobo/video/upload/v1773075400/Aaya-Sher-Anirudh-Ravichander-NaaSongs_cq4l8b.mp3"}
]);

final List<Song> Lovesongs = _makeList([
  {"name": "Chill Vibes", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjHqp2r1cAKitCvRWerMqDmM2CNetnGU9CGQ&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Focus Beats", "img": "https://i.scdn.co/image/ab6761610000e5eb5ba2d75eb08a2d672f9b69b7", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Night Mode", "img": "https://i.ytimg.com/vi/LJxlxgB9YHs/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Lo-Fi Drive", "img": "https://i.ytimg.com/vi/7NOSDKb0HlU/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Romantic", "img": "https://i.ytimg.com/vi/rkZz2RMF3Gs/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Top 50", "img": "https://i.ytimg.com/vi/yJg-Y5byMMw/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Viral India", "img": "https://i.ytimg.com/vi/VYOjWnS4cMY/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "EDM Boom", "img": "https://i.ytimg.com/vi/60ItHLz5WEA/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Rap Rotation", "img": "https://i.ytimg.com/vi/lRqqrgxBX5E/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Trending", "img": "https://i.ytimg.com/vi/E7wJTI-1dvQ/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
]);

final List<Song> Peacefullsongs = _makeList([
  {"name": "Chill Vibes", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjHqp2r1cAKitCvRWerMqDmM2CNetnGU9CGQ&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Focus Beats", "img": "https://i.scdn.co/image/ab6761610000e5eb5ba2d75eb08a2d672f9b69b7", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Night Mode", "img": "https://i.ytimg.com/vi/LJxlxgB9YHs/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Lo-Fi Drive", "img": "https://i.ytimg.com/vi/7NOSDKb0HlU/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Romantic", "img": "https://i.ytimg.com/vi/rkZz2RMF3Gs/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Top 50", "img": "https://i.ytimg.com/vi/yJg-Y5byMMw/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Viral India", "img": "https://i.ytimg.com/vi/VYOjWnS4cMY/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "EDM Boom", "img": "https://i.ytimg.com/vi/60ItHLz5WEA/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Rap Rotation", "img": "https://i.ytimg.com/vi/lRqqrgxBX5E/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Trending", "img": "https://i.ytimg.com/vi/E7wJTI-1dvQ/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
]);

final List<Song> Rapsongs = _makeList([
  {"name": "Chill Vibes", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjHqp2r1cAKitCvRWerMqDmM2CNetnGU9CGQ&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Focus Beats", "img": "https://i.scdn.co/image/ab6761610000e5eb5ba2d75eb08a2d672f9b69b7", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Night Mode", "img": "https://i.ytimg.com/vi/LJxlxgB9YHs/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Lo-Fi Drive", "img": "https://i.ytimg.com/vi/7NOSDKb0HlU/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Romantic", "img": "https://i.ytimg.com/vi/rkZz2RMF3Gs/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Top 50", "img": "https://i.ytimg.com/vi/yJg-Y5byMMw/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Viral India", "img": "https://i.ytimg.com/vi/VYOjWnS4cMY/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "EDM Boom", "img": "https://i.ytimg.com/vi/60ItHLz5WEA/maxresdefault.jpg", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Rap Rotation", "img": "https://i.gstatic.com/images?q=tbn:ANd9GcTUNLOnsK1RQi4dmXY0w-nn-n177Gh77pIZbA&s", "audio": "assets/audio/Chuttamalle.mp3"},
  {"name": "Trending", "img": "https://i.gstatic.com/images?q=tbn:ANd9GcS-uOkXgae210riBbZBA61EBORBAjdimFRxHw&s", "audio": "assets/audio/Chuttamalle.mp3"},
]);

final List<Song> RockClassics = _makeList([
  {"name": "Bohemian Rhapsody", "img": "https://i.scdn.co/image/ab67616d0000b273d2a71d8a436940a6b5711685", "audio": "assets/audio/bohemian_rhapsody.mp3"},
  {"name": "Stairway to Heaven", "img": "https://i.scdn.co/image/ab67616d0000b27341e05d0e2e2a392e21b0d24c", "audio": "assets/audio/stairway_to_heaven.mp3"},
  {"name": "Hotel California", "img": "https://i.scdn.co/image/ab67616d0000b2734e5a95f87b8b20c159147e44", "audio": "assets/audio/hotel_california.mp3"},
  {"name": "Come as You Are", "img": "https://i.scdn.co/image/ab67616d0000b273934d4025d0c000e47083049b", "audio": "assets/audio/come_as_you_are.mp3"},
]);

final List<Song> IndieFolk = _makeList([
  {"name": "Holocene", "img": "https://i.scdn.co/image/ab67616d0000b2736e3c545041a79f42ac4a6c42", "audio": "assets/audio/holocene.mp3"},
  {"name": "Mess Is Mine", "img": "https://i.scdn.co/image/ab67616d0000b27352f75a9733c7f938222d4f55", "audio": "assets/audio/mess_is_mine.mp3"},
  {"name": "The Stable Song", "img": "https://i.scdn.co/image/ab67616d0000b273752e50584285b51b7305963b", "audio": "assets/audio/the_stable_song.mp3"},
  {"name": "Bloom", "img": "https://i.scdn.co/image/ab67616d0000b273a215c54a9d7010f367916964", "audio": "assets/audio/bloom.mp3"},
]);


/* ----------------------------- HOME PAGE ----------------------------- */

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final player = AudioPlayer();
  Song? currentSong;
  List<Song> currentList = [];
  int currentIndex = 0;

  final _recentlyScroll = ScrollController();
  Timer? _autoTimer;
  int _navIndex = 0;

  static const String _LOTTIE_ASSET = 'assets/lottie/music_visualizer.json';

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    player.setLoopMode(LoopMode.off);

    player.playerStateStream.listen((state) {
      if (mounted) {
        if (state.processingState == ProcessingState.completed) {
          _nextTrack();
        }
        setState(() {}); // Rebuild to update MiniPlayer visualizer/play status
      }
    });
  }

  void _startAutoScroll() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(milliseconds: 55), (timer) {
      if (!_recentlyScroll.hasClients) return;
      final max = _recentlyScroll.position.maxScrollExtent;
      double next = _recentlyScroll.offset + 1.5;
      if (next >= max) next = 0;
      _recentlyScroll.jumpTo(next);
    });
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _recentlyScroll.dispose();
    player.dispose();
    super.dispose();
  }

  Future<void> _openPlayer(List<Song> list, int index, {bool autoplay = true}) async {
    currentList = List.of(list);
    currentIndex = index;
    setState(() => currentSong = currentList[currentIndex]);

    final src = currentSong?.audio ?? _DEFAULT_AUDIO;
    try {
      if (src.startsWith("http")) {
        await player.setUrl(src);
      } else {
        await player.setAsset(src);
      }
      if (autoplay) await player.play();
    } catch (e) {
      debugPrint("Audio load error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load song. Please try another one.')),
      );
    }
  }

  List<Song> _upNext() {
    if (currentList.isEmpty) return [];
    final total = currentList.length;
    final maxItems = total <= 6 ? total - 1 : (total >= 11 ? 10 : 5);
    final list = <Song>[];
    for (int i = 1; i <= maxItems; i++) {
      final idx = (currentIndex + i) % total;
      list.add(currentList[idx]);
    }
    return list;
  }

  List<Song> _getMoreSongsFromMovie(String movieName) {
    if (movieName.isEmpty || currentSong == null) return [];
    final originalSongName = currentSong!.name;
    // NOTE: This logic assumes all movie songs are contained within TrendingMusic.
    return TrendingMusic.where((song) => song.movie == movieName && song.name != originalSongName).toList();
  }

  Future<void> _nextTrack() async {
    if (currentList.isEmpty) return;
    currentIndex = (currentIndex + 1) % currentList.length;
    await _openPlayer(currentList, currentIndex, autoplay: true);
  }

  Future<void> _prevTrack() async {
    if (currentList.isEmpty) return;
    currentIndex = (currentIndex - 1 + currentList.length) % currentList.length;
    await _openPlayer(currentList, currentIndex, autoplay: true);
  }

  void _playSongFromIndex(int index) async {
    // This function is only called when selecting a song from a filtered list (SearchPage/Modal Queue).
    // The currentList is already set correctly by the SearchPage or is the existing list.
    await _openPlayer(currentList, index, autoplay: true);
    Navigator.pop(context); // Close the modal if it's open
  }

  void _onMiniPlayerTap() {
    if (currentSong != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withOpacity(0.8),
        builder: (BuildContext context) => _PlayerModal(
          player: player,
          currentSong: currentSong!,
          getQueue: _upNext,
          getMoreFromMovie: _getMoreSongsFromMovie,
          onPrev: _prevTrack,
          onNext: _nextTrack,
          onPick: (songIndex) => _playSongFromIndex(songIndex),
          currentList: currentList, // Pass current list for indexing fix
        ),
      );
    }
  }

  // OPEN AI PAGE
  void _openAIPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AIPage(),
      ),
    );
  }

// GEMINI AI BUTTON
  Widget buildGeminiButton() {
    return IconButton(
      icon: const Icon(Icons.auto_awesome, color: Colors.greenAccent),
      onPressed: () {
        _openAIPage();
      },
    );
  }

// SEARCH BAR
  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.transparent,
      child: InkWell(
        onTap: () {

          final allSongs = [
            ...TrendingMusic,
            ...Recentlyplayed,
            ...Lovesongs,
            ...Peacefullsongs,
            ...Rapsongs,
            ...RockClassics,
            ...IndieFolk
          ].toSet().toList();

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchPage(
                allSongs: allSongs,
                onSongSelected: (list, index) {
                  currentList = list;
                  _openPlayer(list, index);
                },
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
              )
            ],
          ),
          child: Row(
            children: [

              const Icon(Icons.search, color: Colors.white70),

              const SizedBox(width: 10),

              const Expanded(
                child: Text(
                  "Search songs, artists, movies...",
                  style: TextStyle(color: Colors.white70),
                ),
              ),

              // GEMINI BUTTON
              buildGeminiButton(),

            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  Widget _section(String title, List<Song> list, {ScrollController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.separated(
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              final s = list[i];
              return _CardItem(song: s, onTap: () => _openPlayer(list, i));
            },
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemCount: list.length,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = player.playerState.playing;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF191414), Color(0xFF121212)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.4]
              ),
            ),
          ),

          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 8),
                  centerTitle: false,
                  title: Text(
                    _getGreeting(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  background: Padding(
                    padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "-----🎵 Music ",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1DB954),
                              ),
                            ),
                            InkWell(
                              onTap: () { /* Handle profile tap */ },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2C2C2E),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person_rounded, size: 24, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Your daily mix of music to keep you company.",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: _searchBar()),

              if (isPlaying)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      // Lottie animation for music visualizer
                      child: Lottie.asset(
                        _LOTTIE_ASSET,
                        repeat: true,
                        reverse: false,
                        animate: isPlaying,
                        width: 150,
                        height: 50,
                        // Add error handling if the Lottie file is missing
                        errorBuilder: (context, error, stackTrace) => const Text("🎵 Playing Now...", style: TextStyle(color: Color(0xFF1DB954), fontSize: 18, fontStyle: FontStyle.italic)),
                      ),
                    ),
                  ),
                ),

              SliverToBoxAdapter(child: _section("Recently Played", Recentlyplayed, controller: _recentlyScroll)),
              SliverToBoxAdapter(child: _section("Trending Music", TrendingMusic)),
              SliverToBoxAdapter(child: _section("Love Songs", Lovesongs)),
              SliverToBoxAdapter(child: _section("Peaceful Songs", Peacefullsongs)),
              SliverToBoxAdapter(child: _section("Rap Songs", Rapsongs)),
              SliverToBoxAdapter(child: _section("Rock Classics", RockClassics)),
              SliverToBoxAdapter(child: _section("Indie Folk", IndieFolk)),

              SliverToBoxAdapter(child: SizedBox(height: currentSong != null ? 100 : 20)),
            ],
          ),

          if (currentSong != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: _MiniPlayer(
                song: currentSong!,
                player: player,
                onTap: _onMiniPlayerTap,
                onNext: _nextTrack,
                onPrev: _prevTrack,
                isPlaying: isPlaying,
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF191414),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _NavBtn(
                label: "Home",
                icon: Icons.home,
                selected: true,
                onTap: () => setState(() => _navIndex = 0),
              ),
              _NavBtn(
                label: "Playlist",
                icon: Icons.library_music,
                selected: _navIndex == 1,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PlaylistPage())),
              ),
              _NavBtn(
                label: "Premium",
                icon: Icons.workspace_premium,
                selected: _navIndex == 2,
                onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const PremiumPage())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ----------------------------- MINI PLAYER ----------------------------- */

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
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 15, spreadRadius: 1)
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Progress Bar (Slimmer)
            StreamBuilder<Duration?>(
              stream: player.durationStream,
              builder: (context, durationSnapshot) {
                final total = durationSnapshot.data ?? Duration.zero;
                return StreamBuilder<Duration>(
                  stream: player.positionStream,
                  builder: (context, positionSnapshot) {
                    final pos = positionSnapshot.data ?? Duration.zero;
                    double progress = total.inMilliseconds > 0 ? pos.inMilliseconds.toDouble() / total.inMilliseconds : 0.0;
                    return LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1DB954)),
                      minHeight: 2.0,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Hero(
                  tag: 'album-art-${song.name}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(song.img, width: 50, height: 50, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        song.singer,
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Visualizer next to controls
                if (isPlaying)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Lottie.asset(
                      _MusicHomePageState._LOTTIE_ASSET,
                      repeat: true,
                      reverse: false,
                      animate: isPlaying,
                      width: 40,
                      height: 40,
                      errorBuilder: (context, error, stackTrace) => const SizedBox(width: 40, height: 40),
                    ),
                  ),

                IconButton(
                  onPressed: onPrev,
                  icon: const Icon(Icons.skip_previous_rounded),
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
                  iconSize: 32,
                  color: const Color(0xFF1DB954),
                  onPressed: () async {
                    if (isPlaying) {
                      await player.pause();
                    } else {
                      await player.play();
                    }
                  },
                ),
                IconButton(
                  onPressed: onNext,
                  icon: const Icon(Icons.skip_next_rounded),
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ----------------------------- CARD WIDGET ----------------------------- */

class _CardItem extends StatelessWidget {
  const _CardItem({required this.song, required this.onTap});

  final Song song;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.network(
                  song.img,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.album_rounded, color: Colors.white30, size: 50),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Text(
                song.name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ----------------------------- NAV BUTTON ----------------------------- */

class _NavBtn extends StatelessWidget {
  const _NavBtn({required this.label, required this.icon, required this.selected, required this.onTap});
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: selected ? const Color(0xFF3D4261).withOpacity(0.5) : Colors.transparent,
        foregroundColor: selected ? Colors.white : Colors.white70,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onTap,
      icon: Icon(icon, color: selected ? const Color(0xFF1DB954) : Colors.white70),
      label: Text(label, style: const TextStyle(fontStyle: FontStyle.italic)),
    );
  }
}

/* ----------------------------- PLAYER MODAL ----------------------------- */

class _PlayerModal extends StatefulWidget {
  const _PlayerModal({
    required this.player,
    required this.currentSong,
    required this.getQueue,
    required this.onPrev,
    required this.onNext,
    required this.onPick,
    required this.getMoreFromMovie,
    required this.currentList,
  });

  final AudioPlayer player;
  final Song currentSong;
  final List<Song> Function() getQueue;
  final List<Song> Function(String) getMoreFromMovie;
  final Future<void> Function() onPrev;
  final Future<void> Function() onNext;
  final void Function(int) onPick;
  final List<Song> currentList;

  @override
  State<_PlayerModal> createState() => _PlayerModalState();
}

class _PlayerModalState extends State<_PlayerModal> with TickerProviderStateMixin {
  late final AnimationController _vizController;
  bool showLyrics = false;
  bool isLooping = false;
  bool showMoreFromMovie = false;

  // Track the index of the currently playing song within the full currentList
  int _currentPlayingIndex = 0;

  @override
  void initState() {
    super.initState();

    _currentPlayingIndex = widget.currentList.indexOf(widget.currentSong);

    _vizController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    widget.player.playerStateStream.listen((state) {
      if (mounted) {
        if (state.playing) {
          _vizController.repeat(reverse: true);
        } else {
          _vizController.stop();
        }
        setState(() {
          // Re-calculate index if the song changes (via next/prev)
          _currentPlayingIndex = widget.currentList.indexOf(widget.currentSong);
        });
      }
    });

    widget.player.loopModeStream.listen((mode) {
      if (mounted) {
        setState(() {
          isLooping = mode == LoopMode.one;
        });
      }
    });

    if (widget.player.playing) {
      _vizController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _vizController.dispose();
    super.dispose();
  }

  String _format(Duration d) {
    String two(int n) => n.toString().padLeft(2, "0");
    return "${two(d.inMinutes)}:${two(d.inSeconds.remainder(60))}";
  }

  void _toggleLoop() {
    setState(() {
      isLooping = !isLooping;
    });
    widget.player.setLoopMode(isLooping ? LoopMode.one : LoopMode.off);
  }

  // FIX: Helper to find the absolute index in the currentList
  int _getAbsoluteIndex(Song selectedSong) {
    return widget.currentList.indexOf(selectedSong);
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.getQueue();
    final moreFromMovie = widget.getMoreFromMovie(widget.currentSong.movie);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(
          builder: (context, c) {
            final isWide = c.maxWidth > 720;
            return Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1A1A1A), Color(0xFF0F0F0F)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 30)],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: isWide
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _cover(widget.currentSong.img, height: 320),
                    const SizedBox(width: 20),
                    Expanded(child: _metaAndControls(q, moreFromMovie)),
                  ],
                )
                    : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _cover(widget.currentSong.img, height: 260),
                    const SizedBox(height: 12),
                    _metaAndControls(q, moreFromMovie),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _cover(String url, {double height = 260}) {
    return Hero(
      tag: 'album-art-${widget.currentSong.name}',
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height,
            width: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.white.withOpacity(0.08), blurRadius: 15, spreadRadius: 3),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(url, fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _vizController,
              builder: (context, child) {
                final double scale = 0.9 + (1.0 - 0.9) * _vizController.value;
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.1), width: 3),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF1DB954).withOpacity(0.3), blurRadius: 20, spreadRadius: 5),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: height * 0.4,
            width: height * 0.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.6),
              border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
            ),
            child: const Icon(Icons.music_note_rounded, size: 60, color: Color(0xFF1DB954)),
          ),
        ],
      ),
    );
  }

  Widget _metaAndControls(List<Song> queue, List<Song> moreFromMovie) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Text(
            widget.currentSong.name,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            widget.currentSong.singer,
            style: const TextStyle(fontSize: 18, color: Color(0xFF1DB954)),
          ),
          const SizedBox(height: 6),
          Text(
            widget.currentSong.movie,
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          StreamBuilder<Duration>(
            stream: widget.player.positionStream,
            builder: (context, snapshot) {
              final pos = snapshot.data ?? Duration.zero;
              final total = widget.player.duration ?? Duration.zero;
              return Column(
                children: [
                  SliderTheme(
                    data: const SliderThemeData(
                      thumbColor: Color(0xFF1DB954),
                      activeTrackColor: Color(0xFF1DB954),
                      inactiveTrackColor: Colors.white12,
                      overlayColor: Color(0x201DB954),
                      trackHeight: 3,
                    ),
                    child: Slider(
                      value: total.inSeconds > 0 ? pos.inSeconds.toDouble().clamp(0.0, total.inSeconds.toDouble()) : 0.0,
                      max: total.inSeconds.toDouble(),
                      onChanged: (v) => widget.player.seek(Duration(seconds: v.toInt())),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_format(pos), style: const TextStyle(fontSize: 12, color: Colors.white70)),
                        Text(_format(total), style: const TextStyle(fontSize: 12, color: Colors.white70)),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(isLooping ? Icons.repeat_one_rounded : Icons.repeat_rounded, color: isLooping ? const Color(0xFF1DB954) : Colors.white70),
                onPressed: _toggleLoop,
              ),
              IconButton(
                iconSize: 48,
                onPressed: widget.onPrev,
                icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
              ),
              const SizedBox(width: 10),
              StreamBuilder<PlayerState>(
                stream: widget.player.playerStateStream,
                builder: (context, snapshot) {
                  final playing = snapshot.data?.playing ?? false;
                  return IconButton(
                    icon: Icon(playing ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded),
                    iconSize: 80,
                    color: const Color(0xFF1DB954),
                    onPressed: () async {
                      if (playing) {
                        await widget.player.pause();
                      } else {
                        await widget.player.play();
                      }
                    },
                  );
                },
              ),
              const SizedBox(width: 10),
              IconButton(
                iconSize: 48,
                onPressed: widget.onNext,
                icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
              ),
              IconButton(
                icon: const Icon(Icons.queue_music_rounded, color: Colors.white70),
                onPressed: () {
                  setState(() {
                    showLyrics = false;
                    showMoreFromMovie = false;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    showLyrics = true;
                    showMoreFromMovie = false;
                  });
                },
                icon: const Icon(Icons.text_fields_rounded, size: 20),
                label: const Text("Lyrics"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: showLyrics ? const Color(0xFF1DB954) : const Color(0xFF2C2C2E),
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    showMoreFromMovie = true;
                    showLyrics = false;
                  });
                },
                icon: const Icon(Icons.movie_filter_rounded, size: 20),
                label: const Text("More from Movie"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: showMoreFromMovie ? const Color(0xFF1DB954) : const Color(0xFF2C2C2E),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (showLyrics)
            _lyricsWidget(),
          if (showMoreFromMovie)
            _moreFromMovieWidget(moreFromMovie),
          if (!showLyrics && !showMoreFromMovie)
            _upNextWidget(queue),
        ],
      ),
    );
  }

  Widget _lyricsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Lyrics", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        const Divider(color: Colors.white24),
        ...widget.currentSong.lyrics.map(
              (line) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              line,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _moreFromMovieWidget(List<Song> list) {
    if (list.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "No other songs found from ${widget.currentSong.movie}.",
          style: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("More from Movie", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        const Divider(color: Colors.white24),
        ...list.map((song) {
          final absoluteIndex = _getAbsoluteIndex(song); // FIX: Use correct helper
          return _QueueItem(
            song: song,
            onTap: () {
              if (absoluteIndex != -1) {
                widget.onPick(absoluteIndex);
              }
            },
            isCurrent: song == widget.currentSong, // FIX: Check against current song
          );
        }),
      ],
    );
  }

  Widget _upNextWidget(List<Song> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Up Next", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        const Divider(color: Colors.white24),
        ...list.map((song) {
          final absoluteIndex = _getAbsoluteIndex(song); // FIX: Use correct helper
          return _QueueItem(
            song: song,
            onTap: () {
              if (absoluteIndex != -1) {
                widget.onPick(absoluteIndex);
              }
            },
            isCurrent: song == widget.currentSong, // FIX: Check against current song
          );
        }),
      ],
    );
  }
}

class _QueueItem extends StatelessWidget {
  const _QueueItem({required this.song, required this.onTap, required this.isCurrent});

  final Song song;
  final VoidCallback onTap;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: isCurrent ? const Color(0xFF1DB954).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(song.img, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isCurrent ? const Color(0xFF1DB954) : Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(song.singer, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Icon(isCurrent ? Icons.volume_up : Icons.play_arrow_rounded, color: isCurrent ? const Color(0xFF1DB954) : Colors.white70),
          ],
        ),
      ),
    );
  }
}

/* ----------------------------- OTHER PAGES (SearchPage) ----------------------------- */

class SearchPage extends StatefulWidget {
  final List<Song> allSongs;
  final Function(List<Song> filteredSongs, int selectedIndex) onSongSelected;

  const SearchPage({
    super.key,
    required this.allSongs,
    required this.onSongSelected,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<Song> _filteredSongs = [];
  String _currentBgImage = 'assets/backgrounds/default.jpg';

  final Map<String, List<String>> _bgImages = {
    'rap': ['assets/backgrounds/rap1.jpg'],
    'love': ['assets/backgrounds/love1.jpg'],
    'movie': ['assets/backgrounds/movie1.jpg'],
    'telugu': ['assets/backgrounds/telugu1.jpg'],
    'hindi': ['assets/backgrounds/hindi1.jpg'],
    'tamil': ['assets/backgrounds/tamil1.jpg'],
    'k-pop': ['assets/backgrounds/kpop1.jpg'],
    'rock': ['assets/backgrounds/rock1.jpg'],
  };

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      final query = _searchController.text.trim();
      if (query.isEmpty) {
        setState(() {
          _filteredSongs = [];
          _currentBgImage = 'assets/backgrounds/default.jpg';
        });
      } else {
        _filterSongs(query);
        _updateBackground(query);
      }
    });
  }

  void _filterSongs(String query) {
    final list = widget.allSongs.where((song) {
      final queryLower = query.toLowerCase();
      return song.name.toLowerCase().contains(queryLower) ||
          song.singer.toLowerCase().contains(queryLower) ||
          song.movie.toLowerCase().contains(queryLower);
    }).toList();

    setState(() => _filteredSongs = list);
  }

  void _updateBackground(String query) {
    final queryLower = query.toLowerCase();
    final rand = Random();

    final matchedKey = _bgImages.keys.firstWhere(
          (key) => queryLower.contains(key),
      orElse: () => '',
    );

    if (matchedKey.isNotEmpty) {
      final images = _bgImages[matchedKey]!;
      final newImage = images[rand.nextInt(images.length)];
      if (newImage != _currentBgImage) {
        setState(() => _currentBgImage = newImage);
      }
    } else {
      if (_currentBgImage != 'assets/backgrounds/default.jpg') {
        setState(() => _currentBgImage = 'assets/backgrounds/default.jpg');
      }
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search songs, artists, movies...",
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                _searchController.clear();
                FocusScope.of(context).unfocus();
              },
            )
                : null,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: Image.asset(
                _currentBgImage,
                key: ValueKey<String>(_currentBgImage),
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.55),
                colorBlendMode: BlendMode.darken,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SafeArea(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_searchController.text.isEmpty) {
      return const Center(
        child: Text(
          'Start typing to search music...',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    } else if (_filteredSongs.isEmpty) {
      return const Center(
        child: Text(
          'No results found.',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        itemCount: _filteredSongs.length,
        itemBuilder: (context, index) {
          final song = _filteredSongs[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                song.img,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[800],
                  child: const Icon(Icons.music_note, color: Colors.white30),
                ),
              ),
            ),
            title: Text(song.name, style: const TextStyle(color: Colors.white)),
            subtitle: Text(
              '${song.singer} • ${song.movie}',
              style: const TextStyle(color: Colors.white70),
            ),
            onTap: () {
              // Note: The selected list in search is the filtered list, not the currentList from HomePage.
              widget.onSongSelected(_filteredSongs, index);
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }
}
