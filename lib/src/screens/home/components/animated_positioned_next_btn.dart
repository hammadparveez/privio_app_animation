import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:privio/src/domain/state_management/pods.dart';
import 'package:privio/src/screens/home/components/stacked_positioned_animation.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class AnimatedPositionedNextStepButton extends StatefulWidget {
  const AnimatedPositionedNextStepButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;

  @override
  State<AnimatedPositionedNextStepButton> createState() =>
      _AnimatedPositionedNextStepButtonState();
}

class _AnimatedPositionedNextStepButtonState
    extends State<AnimatedPositionedNextStepButton> {
  final _scalingKey = GlobalKey<CustomScalingAnimationState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, watch, child) {
        return CustomAnimation<double>(
          duration: 1000.milliseconds,
          control: watch(cardService).selectedItems.isEmpty
              ? CustomAnimationControl.playReverse
              : CustomAnimationControl.play,
          curve: Curves.easeInOutBack,
          tween: Tween(begin: -50, end: 40),
          builder: (context, child, value) {
            return Positioned(
                bottom: value, right: 10, left: 10, child: child!);
          },
          child: CustomScalingAnimation(
            key: _scalingKey,
            child: FractionallySizedBox(
              widthFactor: .9,
              child: ElevatedButton(
                onPressed: () {
                  _scalingKey.currentState?.playScalingAnimation();
                  Future.delayed(1000.milliseconds, widget.onTap);
                },
                child: Text("Next Step".toUpperCase()),
              ),
            ),
          ),
        );
      },
    );
  }
}
