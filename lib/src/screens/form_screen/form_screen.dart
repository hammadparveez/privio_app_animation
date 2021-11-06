import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privio/src/config/routes.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/images.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'dart:math' as math;

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: AnimationLimiter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...AnimationConfiguration.toStaggeredList(
              childAnimationBuilder: (child) {
                return child;
              },
              children: items,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get items {
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
        child: Text("Send To",
            style: Theme.of(navigatorKey.currentContext!).textTheme.headline2),
      ),
      ScollableImages(),
    ];
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      leading: IconButton(icon: Icon(FontAwesomeIcons.bars), onPressed: () {}),
      title: Image.asset(
        logo,
        width: 150,
      ),
    );
  }
}

////////////////////////
class ScollableImages extends StatefulWidget {
  const ScollableImages({
    Key? key,
  }) : super(key: key);

  @override
  State<ScollableImages> createState() => _ScollableImagesState();
}

class _ScollableImagesState extends State<ScollableImages> with AnimationMixin {
  late ScrollController _controller;

  final tween =
      AlignmentTween(begin: const Alignment(-1, 0), end: const Alignment(1, 0));
  late Animation<Alignment> _animationAlignment;
  double alignment = 0;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _animationAlignment = tween.animate(controller);
    _controller.addListener(() {
      print(_controller.position.userScrollDirection);
      var pos = _controller.position;
      var direction = _controller.position.userScrollDirection;
      if (direction == ScrollDirection.forward) {
        setState(() {
          alignment = math.sin(pos.pixels * math.pi / 180);
        });
      } else {
        setState(() {
          alignment = math.sin(pos.pixels * math.pi / 180);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightThemeColor.withOpacity(.5),
      padding: kPaddingXlVrt,
      child: SingleChildScrollView(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: RoundedImageContainer(image: grid2),
            ),
            RoundedImageContainer(
              image: grid4,
              imageAlignment: Alignment(alignment, 0),
            ),
            RoundedImageContainer(
              image: grid5,
              imageAlignment: Alignment(alignment, 0),
            ),
            RoundedImageContainer(
              image: grid6,
              imageAlignment: Alignment(alignment, 0),
            ),
            RoundedImageContainer(
              image: grid5,
              imageAlignment: Alignment(alignment, 0),
            ),
            RoundedImageContainer(
              image: grid4,
              imageAlignment: Alignment(alignment, 0),
            ),
            RoundedImageContainer(
              image: grid2,
              imageAlignment: Alignment(alignment, 0),
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              color: kWhiteColor,
              dashPattern: [8, 8],
              child: SizedBox(
                  height: 80,
                  width: 100,
                  child: InkWell(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.images,
                        size: 40,
                      ))),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

class RoundedImageContainer extends StatelessWidget {
  const RoundedImageContainer(
      {Key? key, required this.image, this.imageAlignment})
      : super(key: key);
  final String image;
  final Alignment? imageAlignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          image,
          height: 80,
          alignment: imageAlignment ?? Alignment.center,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
