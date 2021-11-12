import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:privio/src/screens/movies/components/video_player_options.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:supercharged/supercharged.dart';
import 'package:privio/src/domain/state_management/pods.dart';
import 'package:privio/src/screens/widgets/custom_slider.dart';

class VideoOptionContainer extends StatelessWidget {
  final BoxConstraints constraints;
  bool isCollapsed;
  VideoOptionContainer({
    Key? key,
    required this.constraints,
    required this.isCollapsed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: constraints.maxHeight - 10,
          width: constraints.maxWidth,
          child: Stack(
            children: [
              _buildLargePlayButton(context, isCollapsed),
              _videoOptions(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Consumer(builder: (context, watch, child) {
            var service = watch(videoDurationService);

            var currentDuration = service.state.inMicroseconds.toDouble();
            var maxDuraiton = watch(videoPlayService)
                .videoPlayerController
                .value
                .duration
                .inMicroseconds
                .toDouble();
            if (!watch(videoPlayService).isInitialized) {
              return const SizedBox();
            }
            return CustomSlider(
              min: 0,
              max: maxDuraiton,
              thumbRadius: 0,
              sliderSize: const Size.fromHeight(5),
              value: currentDuration,
              onChanged: (value) => context
                  .read(videoPlayService)
                  .move(value.toInt().microseconds),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildLargePlayButton(BuildContext context, bool isCollapsed) {
    return Consumer(builder: (context, watch, child) {
      return AnimatedCrossFade(
          crossFadeState: watch(videoPlayService).isPlaying || isCollapsed
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: 500.milliseconds,
          firstChild: const SizedBox(),
          secondChild:
              _buildPlayButton(context, watch(videoPlayService).isPlaying));
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

  Widget _buildPlayButton(BuildContext context, bool isPlaying) {
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
