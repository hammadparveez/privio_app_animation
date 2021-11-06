//Create Tween
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:privio/src/config/routes.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

//Tweens
final positioningTween = Tween<double>(begin: -50, end: 30);
final scalingTween = Tween<double>(begin: 1, end: 1.1);
TimelineTween<Prop> createScrollButtonTween() {
  var tween = TimelineTween<Prop>(curve: Curves.easeInOutBack);

  var _fristScene = tween
      .addScene(begin: 0.milliseconds, end: 1500.milliseconds)
      .animate(Prop.y, tween: positioningTween);

  _fristScene
      .addSubsequentScene(delay: 500.milliseconds, duration: 2000.milliseconds)
      .animate(
        Prop.i,
        tween: DecorationTween(
            begin: const BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            end: const BoxDecoration(shape: BoxShape.circle)),
      )
      .animate(Prop.color,
          tween: ColorTween(begin: Colors.green, end: Colors.yellow))
      .animate(Prop.x,
          tween: AlignmentTween(
            begin: Alignment.center,
            end: Alignment.centerRight,
          ))
      //animate fontSize to 0
      .animate(Prop.size, tween: Tween<double>(begin: 14, end: 0))
      //to make border shape circle
      .animate(Prop.radius,
          tween: ShapeBorderTween(
              begin: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              end: const CircleBorder()));

  return tween;
}

TimelineTween<Prop> createTitleTween() {
  var tween = TimelineTween<Prop>();
  var firstScene = tween.addScene(begin: 0.seconds, end: 1000.milliseconds);
  firstScene
      .animate(Prop.translateY, tween: Tween<double>(begin: -54, end: 0))
      .animate(Prop.opacity, tween: Tween<double>(begin: 0, end: 1));
  return tween;
}

TimelineTween<Prop> createImageSlideTween() {
  var tween = TimelineTween<Prop>();
  var firstScene = tween.addScene(begin: 0.seconds, end: 1000.milliseconds);
  firstScene
      .animate(Prop.translateX,
          tween:
              Tween<double>(begin:100, end: 0))
      .animate(Prop.opacity, tween: Tween<double>(begin: 0, end: 1));
  return tween;
}
