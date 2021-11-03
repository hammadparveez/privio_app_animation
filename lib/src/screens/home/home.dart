import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/helper.dart';
import 'package:privio/src/shared/images.dart';
import 'package:privio/src/shared/strings.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart' as charge;

enum AniProps { width, height, color }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AnimationMixin {
  final _positionedKey = GlobalKey<_StackedPositionedAnimatedState>();

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Build");
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Image.asset(
          logo,
          width: 150,
        ),
        leading: const Icon(Icons.menu),
      ),
      body: Padding(
        padding: kPaddingXlHzt,
        child: Stack(
          children: [
            Column(
              children: [
                AnimationLimiter(child: _buildAnimatedTopBar(context)),
                NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      print(
                          "ScrollNotificaiton ${notification.metrics.pixels} and ${notification.metrics.maxScrollExtent}");
                      // if (notification.metrics.pixels ==
                      //     notification.metrics.maxScrollExtent) {
                      //   _positionedKey.currentState?.takeDownButton();
                      // }

                      if (notification.direction == ScrollDirection.forward) {
                        if (notification.metrics.pixels != 0.0) {
                          _positionedKey.currentState?.bringUpButton();
                        }
                      } else if (notification.direction ==
                          ScrollDirection.reverse) {
                        _positionedKey.currentState?.takeDownButton();
                      }
                      return true;
                    },
                    child: _buildStaggeredGridView(context)),
              ],
            ),
            StackedPositionedAnimated(
              key: _positionedKey,
              scrollController: _scrollController,
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildStaggeredGridView(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: kPaddingXXlVrt,
        child: GridView.builder(
            controller: _scrollController,
            itemCount: 50,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisExtent: 220,
                mainAxisSpacing: 20),
            itemBuilder: (_, index) {
              return AnimationLimiter(
                child: AnimationConfiguration.staggeredGrid(
                  delay: const Duration(milliseconds: 300),
                  columnCount: 2,
                  position: index % 2 == 0 ? 0 : 1,
                  child: SlideAnimation(
                    duration: Duration(milliseconds: 1000),
                    verticalOffset: -MediaQuery.of(context).size.height * .05,
                    horizontalOffset: -50,
                    child: FadeInAnimation(
                      duration: Duration(milliseconds: 1500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              final diagonal = getDiagonal(
                                  constraints.maxHeight, constraints.maxWidth);
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      grid2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 3, color: kWhiteColor)),
                                    ),
                                  ),
                                  Positioned(
                                    left: -diagonal * .25,
                                    top: diagonal * .45,
                                    width: diagonal,
                                    child: Container(
                                      color: kGreenColor,
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()
                                        ..rotateZ(-45 * (pi / 180)),
                                      child: Text(
                                        'trailer'.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                fontSize: 12,
                                                color: kWhiteColor),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                          const SizedBox(height: 10),
                          Text("Avengers: Age Of Ultrion",
                              style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Column _buildAnimatedTopBar(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
            childAnimationBuilder: (widget) {
              return SlideAnimation(
                  delay: Duration(milliseconds: 200),
                  duration: Duration(milliseconds: 500),
                  verticalOffset: -30,
                  curve: Curves.easeInQuad,
                  child: FadeInAnimation(
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeInQuad,
                    child: widget,
                  ));
            },
            children: [
              ..._listOfChildren(context),
            ]));
  }

  List<Widget> _listOfChildren(BuildContext context) {
    return [
      Text(AppStrings.dashBoard, style: Theme.of(context).textTheme.headline2),
      Row(
        children: [
          Flexible(
              child: TextFormField(
            decoration: InputDecoration(
              hintText: AppStrings.search,
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 48, minWidth: 0),
              prefixIcon: Padding(
                padding: kPaddingDefaultRight,
                child: Image.asset(searchIcon,
                    color: kLightThemeColor,
                    height: 24,
                    width: 24), //Icon(Icons.search, color: kLightThemeColor),
              ),
            ),
          )),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(FontAwesomeIcons.sortAlphaDown),
            onPressed: () {
              controller.play();
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(FontAwesomeIcons.calendarAlt),
            onPressed: () {},
          ),
        ],
      ),
    ];
  }
}

class StackedPositionedAnimated extends StatefulWidget {
  final ScrollController scrollController;
  const StackedPositionedAnimated({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<StackedPositionedAnimated> createState() =>
      _StackedPositionedAnimatedState();
}

class _StackedPositionedAnimatedState extends State<StackedPositionedAnimated>
    with AnimationMixin {
  CustomAnimationControl customAnimationControl = CustomAnimationControl.stop;
  CustomAnimationControl customAnimationScaleControl =
      CustomAnimationControl.stop;

  static final _positioningTween = Tween<double>(begin: -50, end: 40);
  static final _scalingTween = Tween<double>(begin: 1, end: 1.2);
  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        takeDownButton();
      }
    });

    //Initially show Button
    Future.delayed(
        2000.milliseconds,
        () => setState(
            () => customAnimationControl = CustomAnimationControl.play));
  }

  void bringUpButton() {
    if (customAnimationControl != CustomAnimationControl.play) {
      setState(() {
        customAnimationControl = CustomAnimationControl.play;
      });
    }
  }

  takeDownButton() {
    if (customAnimationControl != CustomAnimationControl.playReverse) {
      setState(() {
        customAnimationControl = CustomAnimationControl.playReverse;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Build->StackPositioned");
    return CustomAnimation<double>(
        duration: 1000.milliseconds,
        curve: Curves.easeInOutBack,
        tween: _positioningTween,
        control: customAnimationControl,
        builder: (context, child, value) {
          return Positioned(
            left: 20,
            right: 20,
            bottom: value,
            height: 40,
            child: FractionallySizedBox(
              child: CustomAnimation<double>(
                  duration: 1000.milliseconds,
                  curve: Curves.easeInOutBack,
                  control: customAnimationScaleControl,
                  tween: _scalingTween,
                  animationStatusListener: (status) {
                    if (status == AnimationStatus.completed) {
                      setState(() {
                        customAnimationScaleControl =
                            CustomAnimationControl.playReverse;
                      });
                    }
                  },
                  builder: (context, child, value) {
                    return Transform.scale(
                      scale: value,
                      child: ElevatedButton(
                        child: const Text("SCROLL MORE"),
                        onPressed: () {
                          setState(() {
                            customAnimationScaleControl =
                                CustomAnimationControl.play;
                          });
                          Future.delayed(1.seconds, () {
                            final currentPositioned =
                                widget.scrollController.position.pixels;
                            final maxPositioned = widget
                                .scrollController.position.maxScrollExtent;
                            final screenHeight =
                                MediaQuery.of(context).size.height;
                            final double offset = (currentPositioned <
                                    (maxPositioned - screenHeight * .5))
                                ? 500
                                : maxPositioned - currentPositioned;
                            widget.scrollController.animateTo(
                                currentPositioned + offset,
                                duration: 1500.milliseconds,
                                curve: Curves.easeInOutBack);
                            widget.scrollController.addListener(() {
                              if (maxPositioned == currentPositioned) {
                                setState(() {
                                  customAnimationControl =
                                      CustomAnimationControl.playReverse;
                                });
                              }
                            });
                          });
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(40),
                          shadowColor: MaterialStateProperty.all(kGreenColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          backgroundColor:
                              MaterialStateProperty.all(kButtonColor),
                          foregroundColor:
                              MaterialStateProperty.all(kWhiteColor),
                          textStyle: MaterialStateProperty.all(Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontWeight: FontWeight.w500)),
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
