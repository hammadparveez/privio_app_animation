import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privio/src/screens/app_animations/app_animations.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class StackedPositionedAnimated extends StatefulWidget {
  final ScrollController scrollController;
  const StackedPositionedAnimated({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<StackedPositionedAnimated> createState() =>
      StackedPositionedAnimatedState();
}

class StackedPositionedAnimatedState extends State<StackedPositionedAnimated>
    with AnimationMixin {
  CustomAnimationControl customAnimationControl = CustomAnimationControl.stop;
  CustomAnimationControl customAnimationScaleControl =
      CustomAnimationControl.stop;

  CrossFadeState _currentFadeState = CrossFadeState.showFirst;
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
    //Show Arrow after 5 seconds
    _updateCrossFadeState(5500.milliseconds, CrossFadeState.showSecond);
  }

  void bringUpButton() {
    setState(() => customAnimationControl = CustomAnimationControl.play);

    _updateCrossFadeState(3500.milliseconds, CrossFadeState.showSecond);
  }

  takeDownButton() {
    setState(() => customAnimationControl = CustomAnimationControl.playReverse);
    _updateCrossFadeState(700.milliseconds, CrossFadeState.showFirst);
  }

  _updateCrossFadeState(Duration duration, CrossFadeState state) {
    Future.delayed(
      duration,
      () => setState(() {
        _currentFadeState = state;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimation<TimelineValue<Prop>>(
        duration: createScrollButtonTween().duration,
        tween: createScrollButtonTween(),
        control: customAnimationControl,
        builder: (context, child, prop) {
          return Positioned(
            left: 20,
            right: 20,
            bottom: prop.get(Prop.y),
            height: 40,
            child: LayoutBuilder(builder: (context, constraints) {
              return Align(
                alignment: prop.get(Prop.x),
                child: Material(
                  shape: const CircleBorder(),
                  child: _neonAnimatedEffect(prop, _scalingAnimatedBtn(prop)),
                ),
              );
            }),
          );
        });
  }

  Widget _neonAnimatedEffect(TimelineValue<Prop> prop, Widget child) {
    return Container(
      decoration: (prop.get(Prop.i) as BoxDecoration).copyWith(
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 15,
              spreadRadius: 10,
              color: kButtonColor.withOpacity(.3)),
        ],
      ),
      child: child,
    );
  }

  Widget _scalingAnimatedBtn(TimelineValue<Prop> prop) {
    return CustomAnimation<double>(
      duration: 800.milliseconds,
      curve: Curves.easeInOutBack,
      control: customAnimationScaleControl,
      tween: _scalingTween,
      animationStatusListener: (status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            customAnimationScaleControl = CustomAnimationControl.playReverse;
          });
        }
      },
      builder: (context, child, value) {
        return Transform.scale(
          scale: value,
          child: AnimatedSizeAndFade(
            child: _currentFadeState == CrossFadeState.showSecond
                ? _buildScrollIconButton()
                : FractionallySizedBox(
                    widthFactor: 1,
                    child: ElevatedButton(
                      child: Text(
                        "Scroll More".toUpperCase(),
                        style: TextStyle(fontSize: prop.get(Prop.size)),
                      ),
                      onPressed: _onScrollTap,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(prop.get(Prop.radius)),
                      ),
                    ),
                  ),
          ),
        );
      },
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

    final currentPositioned = widget.scrollController.position.pixels;
    final maxPositioned = widget.scrollController.position.maxScrollExtent;
    final screenHeight = MediaQuery.of(context).size.height;
    final double offset =
        (currentPositioned < (maxPositioned - screenHeight * .5))
            ? 500
            : maxPositioned - currentPositioned;
    widget.scrollController.animateTo(offset + currentPositioned,
        duration: 1500.milliseconds, curve: Curves.decelerate);
  }
}
