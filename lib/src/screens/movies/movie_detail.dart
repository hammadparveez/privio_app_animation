import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:privio/src/domain/state_management/pods.dart';
import 'package:privio/src/screens/movies/components/video_container.dart';
import 'package:privio/src/screens/movies/components/video_option_container.dart';

import 'package:flutter/material.dart';

import 'package:privio/src/domain/models/movie_brief_model.dart';
import 'package:privio/src/screens/movies/components/custom_flexible_spacerbar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key, required this.model}) : super(key: key);
  final MovieBriefModel model;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  VideoPlayerController? _controller;
  @override
  void initState() {
    super.initState();
    context
        .read(videoPlayService)
        .initVideo('assets/images/movie_trailer.mp4')
        .then((value) => setState(() {
              _controller =
                  context.read(videoPlayService).videoPlayerController;
              _controller!.addListener(() {
                context.read(videoDurationService).state =
                    _controller!.value.position;
              });
            }));
  }

  @override
  void dispose() {
    _controller!.dispose();
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
                background: const VideoContainer(),
                title: _buildOptionsContainer(),
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

  LayoutBuilder _buildOptionsContainer() {
    return LayoutBuilder(builder: (context, constraints) {
      var isCollapsed = constraints.maxHeight ==
          MediaQuery.of(context).padding.top + kToolbarHeight;
      return VideoOptionContainer(
          constraints: constraints, isCollapsed: isCollapsed);
    });
  }
}
