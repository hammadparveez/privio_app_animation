import 'dart:io';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:privio/src/domain/state_management/pods.dart';
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
  final _scalingStateKey = GlobalKey<CustomScalingAnimationState>();
  CustomAnimationControl customAnimationControl = CustomAnimationControl.stop;
  CustomAnimationControl customAnimationScaleControl =
      CustomAnimationControl.stop;

  CrossFadeState _currentFadeState = CrossFadeState.showFirst;

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
    return Consumer(builder: (context, watch, child) {
      var hasItemSelected = watch(cardService).selectedItems.isNotEmpty;
      return CustomAnimation<TimelineValue<Prop>>(
          duration:
              hasItemSelected ? 1.seconds : createScrollButtonTween().duration,
          tween: createScrollButtonTween(),
          control: hasItemSelected
              ? CustomAnimationControl.playReverse
              : customAnimationControl,
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
                    type: MaterialType.transparency,
                    child: _neonAnimatedEffect(prop, _scalingAnimatedBtn(prop)),
                  ),
                );
              }),
            );
          });
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
    return CustomScalingAnimation(
      key: _scalingStateKey,
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
    _scalingStateKey.currentState?.playScalingAnimation();
    // setState(() {
    //   customAnimationScaleControl = CustomAnimationControl.play;
    // });

    final currentPositioned = widget.scrollController.position.pixels;
    final maxPositioned = widget.scrollController.position.maxScrollExtent;
    final screenHeight = MediaQuery.of(context).size.height;
    final double offset =
        (currentPositioned < (maxPositioned - screenHeight * .5))
            ? 500
            : maxPositioned - currentPositioned;
    // widget.scrollController.animateTo(offset + currentPositioned,
    //     duration: 1500.milliseconds, curve: Curves.decelerate);
  }
}

class CustomScalingAnimation extends StatefulWidget {
  const CustomScalingAnimation({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  CustomScalingAnimationState createState() => CustomScalingAnimationState();
}

class CustomScalingAnimationState extends State<CustomScalingAnimation> {
  CustomAnimationControl customAnimationScaleControl =
      CustomAnimationControl.stop;

  ///Duration of animation 800.milliseconds
  void playScalingAnimation([VoidCallback? afterAnimation]) {
    setState(() {
      customAnimationScaleControl = CustomAnimationControl.play;
    });
    Future.delayed(1500.milliseconds, afterAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimation<double>(
        duration: 800.milliseconds,
        curve: Curves.easeInOutBack,
        control: customAnimationScaleControl,
        animationStatusListener: (status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              customAnimationScaleControl = CustomAnimationControl.playReverse;
            });
          }
        },
        tween: scalingTween,
        child: widget.child,
        builder: (_, child, value) {
          return Transform.scale(scale: value, child: child!);
        });
  }
}
