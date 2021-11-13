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
    var listTiles = [
      ListTile(
        onTap: () {},
        leading: Icon(Icons.dashboard_outlined),
        title: Text("Dashboard"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.video_call_outlined),
        title: Text("Projects"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.photo),
        title: Text("Media"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.settings),
        title: Text("Settings"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.notifications),
        title: Text("Notifications"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.info),
        title: Text("Help & Feedback"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.login),
        title: Text("Sign into Account"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.person_add),
        title: Text("Create an Account"),
      ),
    ];
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: kTransParent),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          color: kThemeColor,
          child: Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                bodyText1: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: kButtonColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            child: ListTileTheme(
              horizontalTitleGap: 0,
              iconColor: kWhiteColor,
              textColor: kUltraLightThemeColor,
              style: ListTileStyle.drawer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Material(
                type: MaterialType.transparency,
                borderRadius: BorderRadius.circular(8),
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
                      leading: Icon(Icons.person),
                      title: Text(
                        "demo.privio.eu",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(
                      color: kLightThemeColor,
                      height: 16,
                      thickness: 2,
                    ),
                    ...listTiles.getRange(0, 3),
                    ElevatedButton.icon(
                      label: Text("Previews"),
                      icon: Icon(Icons.send_and_archive),
                      onPressed: () {},
                    ),
                    const Divider(
                      color: kLightThemeColor,
                      height: 16,
                      thickness: 2,
                    ),
                    ...listTiles.getRange(3, 6),
                    const Divider(
                      color: kLightThemeColor,
                      height: 16,
                      thickness: 2,
                    ),
                    ...listTiles.getRange(6, 8),
                  ],
                ),
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
