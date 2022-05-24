import 'package:flutter/material.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/views/liked_songs.dart';
import 'package:spotify_clone/widgets/currently_playing_song.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'CircularStd',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const LikedSongsView(),
    );
  }
}
