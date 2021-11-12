import 'package:flutter/material.dart';
import 'package:privio/src/domain/state_management/pods.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoContainer extends StatelessWidget {
  const VideoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, child) {
      var service = watch(videoPlayService);
      return GestureDetector(
        onTap: () => service.hideOptions(),
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: service
                  .videoPlayerController
                  .value
                  .isInitialized
              ? VideoPlayer(service.videoPlayerController)
              : const SizedBox(),
        ),
      );
    });
  }
}
