import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privio/src/config/routes.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/images.dart';
import 'package:dotted_border/dotted_border.dart';

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
      Container(
        color: kLightThemeColor.withOpacity(.5),
        padding: kPaddingXlVrt,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: RoundedImageContainer(image: grid2),
              ),
              const RoundedImageContainer(image: grid4),
              const RoundedImageContainer(image: grid5),
              const RoundedImageContainer(image: grid6),
              const RoundedImageContainer(image: grid5),
              const RoundedImageContainer(image: grid4),
              const RoundedImageContainer(image: grid2),
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
      ),
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

class RoundedImageContainer extends StatelessWidget {
  const RoundedImageContainer({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          image,
          height: 80,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
