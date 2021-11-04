import 'dart:math';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _onScrollNotification(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.forward) {
      if (notification.metrics.pixels != 0.0) {
        _positionedKey.currentState?.bringUpButton();
      }
    } else if (notification.direction == ScrollDirection.reverse) {
      _positionedKey.currentState?.takeDownButton();
    }
    return true;
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
                _buildAnimatedTopBar(),
                NotificationListener(
                    onNotification: _onScrollNotification,
                    child: _buildStaggeredGridView(context)),
              ],
            ),
            //Scroll More Button above content
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
                  delay: 300.milliseconds,
                  columnCount: 2,
                  position: index % 2 == 0 ? 0 : 1,
                  child: SlideAnimation(
                    duration: 1000.milliseconds,
                    verticalOffset: -MediaQuery.of(context).size.height * .05,
                    horizontalOffset: -50,
                    child: FadeInAnimation(
                      duration: 1500.milliseconds,
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

  Widget _buildAnimatedTopBar() {
    return AnimationLimiter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
            childAnimationBuilder: (widget) {
              return SlideAnimation(
                  delay: 500.milliseconds,
                  duration: 500.milliseconds,
                  verticalOffset: -30,
                  curve: Curves.easeInQuad,
                  child: FadeInAnimation(
                    duration: 1000.milliseconds,
                    curve: Curves.easeInQuad,
                    child: widget,
                  ));
            },
            children: _listOfChildren),
      ),
    );
  }

  List<Widget> get _listOfChildren {
    return [
      Text(AppStrings.dashBoard, style: Theme.of(context).textTheme.headline2),
      Row(
        children: [
          Flexible(child: _searchFormField()),
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

  Widget _searchFormField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppStrings.search,
        prefixIconConstraints: const BoxConstraints(minHeight: 48, minWidth: 0),
        prefixIcon: Padding(
          padding: kPaddingDefaultRight,
          child: Image.asset(searchIcon,
              color: kLightThemeColor,
              height: 24,
              width: 24), //Icon(Icons.search, color: kLightThemeColor),
        ),
      ),
    );
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
  CustomAnimationControl customAnimationControl = CustomAnimationControl.stop,
      customAnimationScaleControl = CustomAnimationControl.stop;
  CrossFadeState _currentFadeState = CrossFadeState.showFirst;
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

    //Show Scroll Button after a 2sec Delay
    Future.delayed(
        2000.milliseconds,
        () => setState(() {
              customAnimationControl = CustomAnimationControl.play;
            }));
    //Initially show Button
    Future.delayed(5000.milliseconds, () {
      setState(() {
        _currentFadeState = CrossFadeState.showSecond;
      });
    });
  }

  //Create Tween
  TimelineTween<Prop> createTween() {
    //total Animation Duration 7 seconds; exluding startup 2 seconds
    // total duration 9 seconds
    var tween = TimelineTween<Prop>(curve: Curves.easeInOutBack);

    var _fristScene = tween
        .addScene(begin: 0.milliseconds, end: 2000.milliseconds)
        .animate(Prop.y, tween: _positioningTween);

    _fristScene
        .addSubsequentScene(
            delay: 500.milliseconds,
            duration: 2000.milliseconds,
            curve: Curves.easeInOutBack)
        //animate fontSize to 0
        .animate(Prop.size, tween: Tween<double>(begin: 14, end: 0))
        //to make border shape circle
        .animate(Prop.radius,
            tween: ShapeBorderTween(
                begin: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                end: const CircleBorder()))
        //align button to the right
        .animate(Prop.x,
            tween: AlignmentTween(
              begin: Alignment.center,
              end: Alignment.centerRight,
            ));
    return tween;
  }

  void bringUpButton() {
    if (customAnimationControl != CustomAnimationControl.play) {
      setState(() {
        customAnimationControl = CustomAnimationControl.play;
      });
    }
    Future.delayed(
        2500.milliseconds,
        () => setState(() {
              _currentFadeState = CrossFadeState.showSecond;
            }));
  }

  takeDownButton() {
    if (customAnimationControl != CustomAnimationControl.playReverse) {
      setState(() {
        customAnimationControl = CustomAnimationControl.playReverse;
      });
    }
    Future.delayed(
        2500.milliseconds,
        () => setState(() {
              _currentFadeState = CrossFadeState.showFirst;
            }));
  }

  @override
  Widget build(BuildContext context) {
    print("Build->StackPositioned");
    return CustomAnimation<TimelineValue<Prop>>(
        duration: createTween().duration, // 1000.milliseconds,
        curve: Curves.easeInOutBack,
        tween: createTween(),
        control: customAnimationControl,
        builder: (context, child, prop) {
          return Positioned(
            left: 20,
            right: 20,
            bottom: prop.get(Prop.y),
            height: 40,
            child: LayoutBuilder(builder: (context, constraints) {
              return AnimatedAlign(
                alignment: prop.get(Prop.x),
                duration: 1000.milliseconds,
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
                      child: AnimatedSizeAndFade(
                        sizeDuration: 500.milliseconds,
                        fadeDuration: 500.milliseconds,
                        child: _currentFadeState == CrossFadeState.showSecond
                            ? _buildScrollIconButton()
                            : FractionallySizedBox(
                                widthFactor: .8,
                                child: ElevatedButton(
                                  child: Text(
                                    "Scroll More".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: prop.get(Prop.size)),
                                  ),
                                  onPressed: _onScrollTap,
                                  style: _defaultButtonStyle(prop),
                                ),
                              ),
                      ),
                    );
                  },
                ),
              );
            }),
          );
        });
  }

  _defaultButtonStyle(TimelineValue<Prop> prop) {
    return ButtonStyle(
      elevation: MaterialStateProperty.all(40),
      shadowColor: MaterialStateProperty.all(kGreenColor),
      shape: MaterialStateProperty.all(
        prop.get(Prop.radius),
        //RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
      ),
      backgroundColor: MaterialStateProperty.all(kButtonColor),
      foregroundColor: MaterialStateProperty.all(kWhiteColor),
      textStyle: MaterialStateProperty.all(Theme.of(context)
          .textTheme
          .bodyText1
          ?.copyWith(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildScrollIconButton() {
    return Material(
      type: MaterialType.canvas,
      shape: const CircleBorder(),
      elevation: 8,
      shadowColor: kThemeColor,
      color: kButtonColor,
      clipBehavior: Clip.antiAlias,
      child: IconButton(
          color: kWhiteColor,
          iconSize: 20,
          icon: const Icon(
            FontAwesomeIcons.arrowDown,
          ),
          onPressed: _onScrollTap),
    );
  }

  _onScrollTap() {
    setState(() {
      customAnimationScaleControl = CustomAnimationControl.play;
    });
    Future.delayed(1.seconds, () {
      final currentPositioned = widget.scrollController.position.pixels;
      final maxPositioned = widget.scrollController.position.maxScrollExtent;
      final screenHeight = MediaQuery.of(context).size.height;
      final double offset =
          (currentPositioned < (maxPositioned - screenHeight * .5))
              ? 500
              : maxPositioned - currentPositioned;
      widget.scrollController.animateTo(768,
          duration: 1500.milliseconds, curve: Curves.easeInOutBack);

      widget.scrollController.addListener(() {
        if (maxPositioned == currentPositioned) {
          setState(() {
            customAnimationControl = CustomAnimationControl.playReverse;
          });
        }
      });
    });
  }
}
