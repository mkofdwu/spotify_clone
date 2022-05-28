import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/constants/library.dart';
import 'package:spotify_clone/constants/routes.dart';
import 'package:spotify_clone/utils/common_widgets.dart';
import 'package:spotify_clone/widgets/app_bottom_bar.dart';
import 'package:spotify_clone/widgets/opacity_feedback.dart';
import 'package:spotify_clone/widgets/playlist_tile.dart';
import 'package:spotify_clone/widgets/shrink_feedback.dart';

class YourLibraryView extends StatelessWidget {
  const YourLibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMainScrollView(),
      bottomSheet: AppBottomBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() => PreferredSize(
        preferredSize: Size.fromHeight(124),
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 2, color: Colors.black)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Column(
                children: [
                  _buildTop(),
                  SizedBox(height: 16),
                  _buildFilterOptions(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildTop() => Row(
        children: [
          _buildAvatar(),
          SizedBox(width: 16),
          styledText(
            'Your Library',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          Spacer(),
          Icon(Icons.search),
          SizedBox(width: 20),
          Icon(Icons.add),
        ],
      );

  Widget _buildAvatar() => Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Color(0xFFF573A0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: styledText(
            'M',
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  Widget _buildFilterOptions() => Row(
        children: [
          _buildChip('Playlists'),
          SizedBox(width: 8),
          _buildChip('Albums'),
        ],
      );

  Widget _buildChip(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.6)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      );

  Widget _buildMainScrollView() => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: _buildDisplayOptions(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: library.length,
                (context, i) => ShrinkFeedback(
                  onPressed: () {
                    if (library[i].title == 'Liked Songs') {
                      Get.toNamed(Routes.likedSongs);
                    } else if (library[i].isAlbum) {
                      Get.toNamed(Routes.album, arguments: library[i]);
                    }
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: PlaylistTile(
                      playlist: library[i],
                      isSelected: false,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );

  Widget _buildDisplayOptions() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSortByButton(),
          _buildViewButton(),
        ],
      );

  Widget _buildSortByButton() => OpacityFeedback(
        onPressed: () {},
        child: Row(
          children: [
            Icon(Icons.sort, size: 16),
            SizedBox(width: 12),
            styledText('Recently played', fontSize: 14),
          ],
        ),
      );

  Widget _buildViewButton() => OpacityFeedback(
        onPressed: () {},
        child: Icon(Icons.grid_view, size: 18),
      );
}
