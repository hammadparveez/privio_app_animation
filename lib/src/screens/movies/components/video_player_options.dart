import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privio/src/domain/state_management/pods.dart';
import 'package:privio/src/screens/widgets/custom_slider.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/extensions.dart';

class VideoPlayOptionsWidets extends StatelessWidget {
  const VideoPlayOptionsWidets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ..._buildPlayAndVolButton(),
        _volumeSlider(),
        _buildVideoDuration(),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _iconButton(Icons.hd_outlined, () {}),
            _iconButton(Icons.fullscreen, () {
              context.read(videoPlayService).rotate();
            }),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildPlayAndVolButton() {
    return [
      Consumer(builder: (context, watch, child) {
        print("Video Play");
        return _iconButton(
            watch(videoPlayService).isPlaying ? Icons.pause : Icons.play_arrow,
            () {
          context.read(videoPlayService).playOrPause();
        });
      }),
      Consumer(builder: (_, watch, child) {
        print("Video Volume");
        var volume = watch(videoPlayService);
        return _iconButton(
            volume.isMute
                ? Icons.volume_off_outlined
                : volume.isNormal
                    ? Icons.volume_down_outlined
                    : Icons.volume_up_outlined, () {
          watch(videoPlayService).mute();
        });
      }),
    ];
  }

  Padding _buildVideoDuration() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 12),
      child: DefaultTextStyle(
        style: const TextStyle(
            fontSize: 12.5, fontWeight: FontWeight.w500, color: kWhiteColor),
        child: Consumer(
            child: Text(" / "),
            builder: (_, watch, child) {
              var service = watch(videoDurationService);
              return Row(
                children: [
                  Text(service.state.toPlayBackDuration),
                  child!,
                  Consumer(builder: (context, watch, child) {
                    return Text(watch(videoPlayService).totalDuration);
                  }),
                ],
              );
            }),
      ),
    );
  }

  Widget _volumeSlider() {
    return Consumer(builder: (context, watch, child) {
      return CustomSlider(
        min: 0,
        max: 1,
        thumbRadius: 4,
        sliderSize: const Size(50, 40),
        value: watch(videoPlayService).videoPlayerController.value.volume,
        onChanged: (volume) => context.read(videoPlayService).setVolume(volume),
      );
    });
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      constraints:
          const BoxConstraints(maxWidth: kMinInteractiveDimension - 10),
      color: kWhiteColor,
      icon: Icon(icon),
      onPressed: onTap,
    );
  }
}
