import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: kTransParent),
      child: Drawer(
        child: Container(
          padding: kPaddingDefaultVrt,
          color: kThemeColor,
          child: Theme(
            data: ThemeData(
              textTheme: TextTheme(
                bodyText2: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w100),
                bodyText1: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            child: Material(
              type: MaterialType.transparency,
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
                  ListTile(
                    onTap: () {},
                    horizontalTitleGap: 0,
                    leading: Icon(Icons.person, color: kWhiteColor),
                    title: Text("demo.privio.eu"),
                  ),
                  const Divider(
                    color: kLightThemeColor,
                    height: 16,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    horizontalTitleGap: 0,
                    leading: Icon(Icons.person, color: kWhiteColor),
                    title: Text("demo.privio.eu"),
                  ),
                ],
              ),
            ),
          ),
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
