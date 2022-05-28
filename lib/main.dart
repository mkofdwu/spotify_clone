import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/constants/routes.dart';
import 'package:spotify_clone/controllers/song_controller.dart';
import 'package:spotify_clone/views/album.dart';
import 'package:spotify_clone/views/current_song.dart';
import 'package:spotify_clone/views/liked_songs.dart';
import 'package:spotify_clone/views/your_library.dart';

void main() {
  Get.put(SongController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spotify Clone',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'CircularStd',
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      themeMode: ThemeMode.dark,
      defaultTransition: Transition.fadeIn,
      initialRoute: Routes.yourLibrary,
      getPages: [
        GetPage(
          name: Routes.yourLibrary,
          page: () => YourLibraryView(),
        ),
        GetPage(
          name: Routes.likedSongs,
          page: () => LikedSongsView(),
        ),
        GetPage(
          name: Routes.album,
          page: () => AlbumView(),
        ),
        GetPage(
          name: Routes.currentSong,
          page: () => CurrentSongView(),
          transition: Transition.downToUp,
        ),
      ],
    );
  }
}
