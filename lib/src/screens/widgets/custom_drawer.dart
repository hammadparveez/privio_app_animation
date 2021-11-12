import 'package:flutter/material.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/images.dart';
import 'package:simple_animations/anicoto/animation_mixin.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ColoredBox(
        color: kThemeColor,
        child: ListView(
          children: [
            Row(
              children: [
                AnimatedIconButton(
                    showCloseFirst: true,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                Image.asset(logo, width: 150),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///Animated Icon Button
class AnimatedIconButton extends StatefulWidget {
  const AnimatedIconButton({
    Key? key,
    required this.onTap,
    this.showCloseFirst = false,
  }) : super(key: key);
  final VoidCallback onTap;
  final bool showCloseFirst;
  @override
  State<AnimatedIconButton> createState() => AnimatedIconButtonState();
}

class AnimatedIconButtonState extends State<AnimatedIconButton>
    with AnimationMixin {
  bool hasTapped = true;
  late Animation<double> _iconAnimation;
  @override
  void initState() {
    super.initState();
    _iconAnimation = Tween<double>(
            begin: widget.showCloseFirst ? 1 : 0.0,
            end: widget.showCloseFirst ? 0 : 1)
        .animate(controller);
  }

  void openOrCloseAnimatedDrawer() {
    controller.play(duration: 300.milliseconds);

    setState(() {
      hasTapped = !hasTapped;
    });

    Future.delayed(500.milliseconds, () {
      controller.playReverse(duration: 300.milliseconds);
      widget.onTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: openOrCloseAnimatedDrawer,
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _iconAnimation,
      ),
    );
  }
}
