import 'dart:ui';

import 'package:privio/src/domain/state_management/pods.dart';
import 'package:privio/src/screens/movies/components/video_player_options.dart';
import 'package:privio/src/screens/widgets/custom_slider.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privio/src/domain/models/movie_brief_model.dart';
import 'package:privio/src/screens/movies/components/custom_flexible_spacerbar.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/images.dart';
import 'package:video_player/video_player.dart';
import 'package:supercharged/supercharged.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key, required this.model}) : super(key: key);
  final MovieBriefModel model;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    context
        .read(videoPlayService)
        .initVideo('assets/images/movie_trailer.mp4')
        .then((value) => setState(() {
              _videoPlayerController =
                  context.read(videoPlayService).videoPlayerController;
            }));

    context.read(videoPlayService).videoPlayerController.addListener(() {
      context.read(videoDurationService).state =
          _videoPlayerController.value.position;
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Entire Build##############");
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.height * .9
                      : MediaQuery.of(context).size.height * .3,
              floating: true,
              pinned: true,
              flexibleSpace: CustomFlexibleSpaceBar(
                background: GestureDetector(
                  onTap: () => context.read(videoPlayService).hideOptions(),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: _videoPlayerController.value.isInitialized
                        ? VideoPlayer(_videoPlayerController)
                        : const SizedBox(),
                  ),
                ),
                title: LayoutBuilder(builder: (context, constraints) {
                  var isCollapsed = constraints.maxHeight ==
                      MediaQuery.of(context).padding.top + kToolbarHeight;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight - 10,
                        width: constraints.maxWidth,
                        child: Stack(
                          children: [
                            _buildLargePlayButton(isCollapsed),
                            _videoOptions(),
                          ],
                        ),
                      ),
                      _videoPlayedMoverSlider(),
                    ],
                  );
                }),
                titlePadding: EdgeInsets.zero,
              ),
            ),
            SliverList(delegate: SliverChildBuilderDelegate((_, index) {
              return const ListTile(
                title: Text("Hello World"),
              );
            }))
          ],
        ),
      ),
    );
  }

  Widget _buildLargePlayButton(bool isCollapsed) {
    return Consumer(builder: (context, watch, child) {
      return AnimatedCrossFade(
          crossFadeState: watch(videoPlayService).isPlaying && isCollapsed
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: 250.milliseconds,
          firstChild: const SizedBox(),
          secondChild: _buildPlayButton(watch(videoPlayService).isPlaying));
    });
  }

  Consumer _videoOptions() {
    return Consumer(builder: (_, watch, child) {
      return AnimatedPositioned(
        duration: 500.milliseconds,
        bottom: watch(videoPlayService).isOptionVisible ? -100 : 0,
        left: 0,
        right: 0,
        child: const SizedBox(
          height: 70,
          child: VideoPlayOptionsWidets(),
        ),
      );
    });
  }

  Padding _videoPlayedMoverSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Consumer(builder: (context, watch, child) {
        var currentDuration =
            watch(videoDurationService).state.inMicroseconds.toDouble();
        var maxDuraiton =
            _videoPlayerController.value.duration.inMicroseconds.toDouble();
        return CustomSlider(
          min: 0,
          max: maxDuraiton,
          thumbRadius: 0,
          sliderSize: const Size.fromHeight(5),
          value: currentDuration,
          onChanged: (value) =>
              context.read(videoPlayService).move(value.toInt().microseconds),
        );
      }),
    );
  }

  Widget _buildPlayButton(bool isPlaying) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Material(
              type: MaterialType.transparency,
              child: IconButton(
                  iconSize: 15,
                  color: kWhiteColor,
                  onPressed: () => context.read(videoPlayService).playOrPause(),
                  icon: isPlaying
                      ? const Icon(FontAwesomeIcons.pause)
                      : const Icon(FontAwesomeIcons.play)),
            )),
      ),
    );
  }
}
