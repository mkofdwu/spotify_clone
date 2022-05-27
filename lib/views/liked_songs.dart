import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/constants/liked_songs.dart';
import 'package:spotify_clone/controllers/song_controller.dart';
import 'package:spotify_clone/utils/common_widgets.dart';
import 'package:spotify_clone/widgets/currently_playing_song.dart';
import 'package:spotify_clone/widgets/opacity_feedback.dart';
import 'package:spotify_clone/widgets/play_shuffle_button.dart';
import 'package:spotify_clone/widgets/shrink_feedback.dart';
import 'package:spotify_clone/widgets/song_tile.dart';

class LikedSongsView extends StatefulWidget {
  const LikedSongsView({Key? key}) : super(key: key);

  @override
  State<LikedSongsView> createState() => _LikedSongsViewState();
}

class _LikedSongsViewState extends State<LikedSongsView> {
  final _scrollController = ScrollController();
  // feels kind of hacky idk
  double _appBarOpacity = 0;
  double _appBarTextOpacity = 0;

  SongController get controller => Get.find<SongController>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset < 40) {
          _appBarOpacity = 0;
          _appBarTextOpacity = 0;
        } else {
          _appBarOpacity = min((_scrollController.offset - 40) / 10, 1);
          _appBarTextOpacity = min((_scrollController.offset - 40) / 60, 1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // first section: building the main listview
    return GetBuilder<SongController>(builder: (controller) {
      return Scaffold(
        appBar: _buildAppBar(),
        extendBodyBehindAppBar: true,
        body: _buildMainScrollView(),
        bottomNavigationBar: controller.currentSong == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(8),
                child: SafeArea(
                  child: CurrentlyPlayingSong(
                    song: controller.currentSong!,
                    position: controller.position / controller.totalDuration,
                    isPlaying: controller.isPlaying,
                    playOrPause: controller.playOrPause,
                  ),
                ),
              ),
      );
    });
  }

  PreferredSizeWidget _buildAppBar() => PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF293360).withOpacity(_appBarOpacity),
                Color(0xFF212740).withOpacity(_appBarOpacity),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  OpacityFeedback(
                    onPressed: Get.back,
                    child: Icon(Icons.arrow_back, size: 20),
                  ),
                  SizedBox(width: 28),
                  styledText(
                    'Liked Songs',
                    color: Colors.white.withOpacity(_appBarTextOpacity),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildMainScrollView() => CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: likedSongs.length,
                (context, i) => ShrinkFeedback(
                  // wrap with material to make entire tile clickable
                  child: Material(
                    color: Colors.transparent,
                    child: SongTile(
                      song: likedSongs[i],
                      isSelected: likedSongs[i] == controller.currentSong,
                    ),
                  ),
                  onPressed: () {
                    controller.selectSongInPlaylist(likedSongs, i);
                  },
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildHeader() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2a41a9),
              Color(0xFF121212),
            ],
          ),
        ),
        child: SafeArea(
          // kind of a weird setup
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                expandedColumnStart([
                  styledText(
                    'Liked Songs',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 8),
                  styledText(
                    '166 songs',
                    color: Colors.white.withOpacity(0.6),
                  ),
                  SizedBox(height: 8),
                  _buildEnhanceButton(),
                ]),
                PlayShuffleButton(),
              ],
            ),
          ),
        ),
      );

  Widget _buildEnhanceButton() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          'Enhance',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      );
}
