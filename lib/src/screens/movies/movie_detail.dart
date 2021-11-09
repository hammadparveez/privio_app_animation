import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privio/src/domain/models/movie_brief_model.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/images.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key, required this.model}) : super(key: key);
  final MovieBriefModel model;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  int currentValue = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: kButtonColor,
              expandedHeight: MediaQuery.of(context).size.height * .3,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      grid2,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
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
                                    icon: const Icon(FontAwesomeIcons.play,
                                        size: 15)),
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            color: kWhiteColor,
                            icon: Icon(Icons.play_arrow),
                            onPressed: () {},
                          ),
                          Column(
                            children: [
                              RotatedBox(
                                quarterTurns: 3,
                                child: SizedBox(
                                  width: 80,
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                      rangeTrackShape:
                                          RectangularRangeSliderTrackShape(),
                                      //trackHeight: 5,
                                      overlayShape:
                                          SliderComponentShape.noOverlay,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 6),
                                      // SliderComponentShape.noThumb,
                                      overlappingShapeStrokeColor: Colors.pink,
                                    ),
                                    child: Slider(
                                        inactiveColor: Colors.grey,
                                        activeColor: kWhiteColor,
                                        value: currentValue.toDouble(),
                                        min: 0,
                                        label: "Value $currentValue",
                                        max: 100,
                                        onChanged: (value) {
                                          setState(() {
                                            currentValue = value.toInt();
                                          });
                                        }),
                                  ),
                                ),
                              ),
                              IconButton(
                                color: kWhiteColor,
                                icon: Icon(Icons.volume_up_outlined),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              children: [
                                Text("0:13",
                                    style: TextStyle(color: kWhiteColor)),
                                Text(" / ",
                                    style: TextStyle(color: kWhiteColor)),
                                Text("4:00",
                                    style: TextStyle(color: kWhiteColor)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  color: kWhiteColor,
                                  icon: Icon(Icons.hd_outlined),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  color: kWhiteColor,
                                  icon: Icon(Icons.fullscreen),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(delegate: SliverChildBuilderDelegate((_, index) {
              return ListTile(
                title: Text("Hello World"),
              );
            }))
          ],
        ),
      ),
    );
  }
}
