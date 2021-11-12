import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:privio/src/domain/state_management/pods.dart';
import 'package:privio/src/screens/movies/components/video_container.dart';
import 'package:privio/src/screens/movies/components/video_option_container.dart';
import 'package:privio/src/shared/extensions.dart';

import 'package:flutter/material.dart';

import 'package:privio/src/domain/models/movie_brief_model.dart';
import 'package:privio/src/screens/movies/components/custom_flexible_spacerbar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/images.dart';
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
    return Scaffold(
      
      body: _controller == null
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: MediaQuery.of(context).orientation ==
                          Orientation.landscape
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
                _buildMovieDetail(context),
              ],
            ),
    );
  }

  


  SliverPadding _buildMovieDetail(BuildContext context) {
    return SliverPadding(
      padding: kPaddingXXlAll,
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            Text(widget.model.title,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: kWhiteColor, fontWeight: FontWeight.w500)),
            const SizedBox(height: 15),
            DefaultTextStyle(
              style: TextStyle(fontSize: 15),
              child: Row(
                children: [
                  Text(widget.model.date),
                  vrtSeprator(),
                  Text(widget.model.isTrailer ? 'Trailer' : 'Film'),
                  vrtSeprator(),
                  Text(_controller!.value.duration.playBackMintues + " min"),
                  vrtSeprator(),
                  Text(widget.model.lang),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(_loriumIpusm,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 15, height: 1.5)),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              child: Text('Leave a Comment'),
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  backgroundColor: MaterialStateProperty.all(kTransParent),
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(kPaddingXLall),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: kLightThemeColor, width: 2)))),
            ),
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

  Widget vrtSeprator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text("|"),
    );
  }
}

var _loriumIpusm =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ";
