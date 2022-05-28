import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spotify_clone/controllers/song_controller.dart';
import 'package:spotify_clone/widgets/currently_playing_song.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({Key? key}) : super(key: key);

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  @override
  Widget build(BuildContext context) {
    final bottomPadding =
        MediaQuery.of(Scaffold.of(context).context).viewPadding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(8, 16, 8, bottomPadding + 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0),
            // Colors.black,
            Colors.black,
          ],
          stops: [0, 0.6],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<SongController>(builder: (controller) {
            if (controller.currentSong == null) return SizedBox();
            return CurrentlyPlayingSong(
              song: controller.currentSong!,
              position: controller.position / controller.totalDuration,
              isPlaying: controller.isPlaying,
              playOrPause: controller.playOrPause,
            );
          }),
          SizedBox(height: 8),
          Theme(
            data: ThemeData(
              // disable splash when clicking nav item
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              unselectedItemColor: Colors.white.withOpacity(0.6),
              selectedItemColor: Colors.white,
              selectedLabelStyle: TextStyle(fontSize: 10, height: 1.6),
              unselectedLabelStyle: TextStyle(fontSize: 10, height: 1.6),
              iconSize: 28,
              currentIndex: 3,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: 'Discover',
                  icon: Icon(Icons.explore_outlined),
                  activeIcon: Icon(Icons.explore),
                ),
                BottomNavigationBarItem(
                  label: 'Search',
                  icon: Icon(Icons.search_outlined),
                  activeIcon: Icon(Icons.search),
                ),
                BottomNavigationBarItem(
                  label: 'Your Library',
                  icon: Icon(Icons.library_music_outlined),
                  activeIcon: Icon(Icons.library_music),
                ),
                BottomNavigationBarItem(
                  label: 'Concerts',
                  icon: Icon(Icons.airplane_ticket_outlined),
                  activeIcon: Icon(Icons.airplane_ticket),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
