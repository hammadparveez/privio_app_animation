import 'dart:ui';
import 'dart:math' as math;

import 'package:privio/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privio/src/domain/models/movie_brief_model.dart';
import 'package:privio/src/screens/movies/components/custom_flexible_spacerbar.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/images.dart';
import 'package:video_player/video_player.dart';
import 'package:supercharged/supercharged.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key, required this.model}) : super(key: key);
  final MovieBriefModel model;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool _isScreenTapped = false;
  bool isFullScreen = false;
  final videoUri =
      "https://imdb-video.media-imdb.com/vi2554576921/1434659607842-pgv4ql-1629824548744.mp4?Expires=1636674616&Signature=ZqmoVl5zQhlMUA4BrGAiYbmWPUSRCUJHC~EpuAvgGRhWezvhADjc1~espRa1q2auuihhSK8oKlRzJgZ4rWqouOWyLGc72vE6gEvMmYqh19RKLreOpua3qumKRWMR6Z~pVi5FUmJCIufZXc7~O3xMUVZSuxRbJTuIoTo4OIuuZBFJkSLypTgTdKDv56fyPnfWPTWMhi4AX~AnKwzJt6tt-jgCGeiI22q7EEdZj0QBBQ36PcKcFAbdenije62RvDcgEwkbLnWItVPF2QmJxWi6PHodyW7It~QDgDnBQGqxGIDbtnuu~KQPaLtzWCpOKvCnsHMbq3hGg32LfCknE19Pxg__&Key-Pair-Id=APKAIFLZBVQZ24NQH3KA";
  ValueNotifier<double> value = ValueNotifier(0);
  bool isPlayer = false;
  late VideoPlayerController _videoPlayerController;
  Duration _videoPlayedDuration = Duration.zero;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(videoUri)
      ..initialize().then((value) => setState(() {}));
    _videoPlayerController.addListener(() {
      setState(() {
        _videoPlayedDuration = Duration(
            minutes: _videoPlayerController.value.position.inMinutes,
            seconds: _videoPlayerController.value.position.inSeconds);
        //_videoPlayerController.value.position;
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  _getVideoRemainingDuraiton() {
    var _d = _videoPlayerController.value.position;

    // String twoDigits(int n) {
    //   if (n >= 10) return "$n";
    //   return "0$n";
    // }

    // String twoDigitHours =
    //     twoDigits(_d.inHours.remainder(Duration.hoursPerDay));
    // String twoDigitMinutes =
    //     twoDigits(_d.inMinutes.remainder(Duration.minutesPerHour));
    // String twoDigitSeconds =
    //     twoDigits(_d.inSeconds.remainder(Duration.secondsPerMinute));
    // return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
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
                background: LayoutBuilder(builder: (context, constraints) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      print("Is Tapped $_isScreenTapped");
                      _isScreenTapped = !_isScreenTapped;
                    }),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: _videoPlayerController.value.isInitialized
                          ? VideoPlayer(_videoPlayerController)
                          : SizedBox(),
                      // Image.asset(
                      //   grid6,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                }),
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
                            isCollapsed ||
                                    _videoPlayerController.value.isPlaying
                                ? const SizedBox()
                                : _buildPlayButton(),
                            AnimatedPositioned(
                              duration: 500.milliseconds,
                              bottom: _isScreenTapped ? -100 : 0,
                              left: 0,
                              right: 0,
                              child: SizedBox(
                                height: 70,
                                child: _buildHztButtons(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 4,
                          overlayShape: SliderComponentShape.noOverlay,
                          minThumbSeparation: 0,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 0),
                        ),
                        child: SizedBox(
                          height: 5,
                          child: Slider(
                              inactiveColor: Colors.grey,
                              activeColor: kWhiteColor,
                              value: _videoPlayerController
                                  .value.position.inMilliseconds
                                  .toDouble(),
                              min: 0,
                              max: _videoPlayerController
                                  .value.duration.inMilliseconds
                                  .toDouble(),
                              onChanged: (value) {
                                setState(() {
                                  _videoPlayerController.seekTo(
                                      Duration(milliseconds: value.toInt()));
                                });
                              }),
                        ),
                      ),
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

  Widget _buildHztButtons() {
    double iconSize = 28;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _iconButton(
            28,
            _videoPlayerController.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow, () {
          setState(() {
            _videoPlayerController.value.isPlaying
                ? _videoPlayerController.pause()
                : _videoPlayerController.play();
          });
        }),
        _iconButton(
            28,
            _videoPlayerController.value.volume == 0.0
                ? Icons.volume_off_outlined
                : _videoPlayerController.value.volume <= 0.5
                    ? Icons.volume_down_outlined
                    : Icons.volume_up_outlined,
            () {}),
        SliderTheme(
          data: SliderThemeData(
            overlayShape: SliderComponentShape.noOverlay,
            minThumbSeparation: 0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
          ),
          child: SizedBox(
            width: 50,
            height: 40,
            child: Slider(
                inactiveColor: Colors.grey,
                activeColor: kWhiteColor,
                value: _videoPlayerController.value.volume,
                min: 0,
                max: 1,
                onChanged: (value) {
                  setState(() {
                    print("Value $value");
                    _videoPlayerController.setVolume(value);
                  });
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 12),
          child: Row(
            children: [
              Text(
                  "${_videoPlayerController.value.position.toPlayBackDuration}",
                  style: TextStyle(fontSize: 12, color: kWhiteColor)),
              Text(" / ", style: TextStyle(fontSize: 12, color: kWhiteColor)),
              Text(
                  "${_videoPlayerController.value.duration.toPlayBackDuration}",
                  style: TextStyle(fontSize: 12, color: kWhiteColor)),
            ],
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _iconButton(iconSize, Icons.hd_outlined, () {}),
            _iconButton(iconSize, Icons.fullscreen, () {
              setState(() {
                isFullScreen = !isFullScreen;
              });
              if (isFullScreen) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitDown,
                  DeviceOrientation.portraitUp
                ]);
              } else {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight
                ]);
              }
            }),
          ],
        ),
      ],
    );
  }

  Widget _iconButton(double iconSize, IconData icon, VoidCallback onTap) {
    return IconButton(
      constraints: BoxConstraints(maxWidth: kMinInteractiveDimension - 10),
      color: kWhiteColor,
      icon: Icon(icon),
      onPressed: onTap,
    );
  }

  Widget _buildPlayButton() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedOpacity(
        duration: 1.seconds,
        opacity: _isScreenTapped ? 0 : 1,
        child: Center(
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
                      color: kWhiteColor,
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.play, size: 15)),
                )),
          ),
        ),
      ),
    );
  }
}
