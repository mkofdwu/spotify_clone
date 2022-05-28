import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/controllers/song_controller.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/utils/common_widgets.dart';
import 'package:spotify_clone/widgets/album_song_tile.dart';
import 'package:spotify_clone/widgets/app_bottom_bar.dart';
import 'package:spotify_clone/widgets/opacity_feedback.dart';
import 'package:spotify_clone/widgets/play_shuffle_button.dart';
import 'package:spotify_clone/widgets/shrink_feedback.dart';

class AlbumView extends StatefulWidget {
  const AlbumView({Key? key}) : super(key: key);

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  final _scrollController = ScrollController();
  // feels kind of hacky idk
  double _appBarOpacity = 0;
  double _appBarTextOpacity = 0;

  SongController get controller => Get.find<SongController>();
  Playlist get album => Get.arguments as Playlist;

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
    return GetBuilder<SongController>(builder: (controller) {
      return Scaffold(
        appBar: _buildAppBar(),
        extendBodyBehindAppBar: true,
        body: _buildMainScrollView(),
        bottomSheet: AppBottomBar(),
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
                  Flexible(
                    child: styledText(
                      album.title,
                      color: Colors.white.withOpacity(_appBarTextOpacity),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      oneLineEllipsis: true,
                    ),
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
          _buildHeader(),
          _buildMainList(),
          _buildBottomDetails(),
        ],
      );

  Widget _buildHeader() => SliverToBoxAdapter(
        child: _headerBackground(SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCoverImage(),
                SizedBox(height: 24),
                styledText(
                  album.title,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 12),
                _buildArtistDetails(small: true),
                SizedBox(height: 8),
                _buildAlbumDetails(),
                _buildAlbumOptions(),
              ],
            ),
          ),
        )),
      );

  Widget _buildMainList() => SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: album.songs.length,
            (context, i) => ShrinkFeedback(
              // wrap with material to make entire tile clickable
              child: Material(
                color: Colors.transparent,
                child: AlbumSongTile(
                  song: album.songs[i],
                  isSelected: album.songs[i] == controller.currentSong,
                ),
              ),
              onPressed: () {
                controller.selectSongInPlaylist(album.songs, i);
              },
            ),
          ),
        ),
      );

  Widget _buildBottomDetails() {
    final double bottomPadding = controller.currentSong == null ? 80 : 150;
    return SliverSafeArea(
      top: false,
      sliver: SliverPadding(
        padding: EdgeInsets.fromLTRB(20, 14, 20, bottomPadding),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            styledText(
              'November 18, 2014',
              fontSize: 16,
            ),
            styledText(
              '30 songs · 2 hr 19 min',
              fontSize: 16,
            ),
            SizedBox(height: 18),
            _buildArtistDetails(small: false),
            SizedBox(height: 24),
            styledText(
              'You might also like',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ]),
        ),
      ),
    );
  }

  Widget _headerBackground(Widget child) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8e9da4),
              Color(0xFF121212),
            ],
          ),
        ),
        child: child,
      );

  Widget _buildCoverImage() => Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: Offset(0, 20),
                blurRadius: 30,
              )
            ],
          ),
          child: Image.asset(
            album.coverImage,
            width: 200,
            height: 200,
          ),
        ),
      );

  Widget _buildArtistDetails({required bool small}) => Row(
        children: [
          CircleAvatar(
            radius: small ? 10 : 20,
            backgroundImage: AssetImage('assets/images/hans_zimmer.jpeg'),
          ),
          SizedBox(width: small ? 8 : 12),
          styledText(
            'Hans Zimmer',
            fontSize: small ? 12 : 16,
            fontWeight: small ? FontWeight.w700 : FontWeight.w400,
          ),
        ],
      );

  Widget _buildAlbumDetails() => Row(
        children: [
          styledText(
            'Album',
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          styledText(
            album.albumReleaseDate!.year.toString(),
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ],
      );

  Widget _buildAlbumOptions() => Row(
        children: [
          Icon(
            Icons.favorite,
            color: Palette.green,
          ),
          SizedBox(width: 20),
          Icon(
            Icons.more_vert,
            color: Colors.white.withOpacity(0.8),
          ),
          Spacer(),
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Palette.green,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Icon(Icons.play_arrow, color: Colors.black, size: 32),
            ),
          ),
        ],
      );
}
