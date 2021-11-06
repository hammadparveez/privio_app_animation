import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privio/src/domain/state_management/pods.dart';
import 'package:privio/src/screens/form_screen/components/parallax_image_container.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privio/src/shared/images.dart';



var _item = [
  grid2,
  grid4,
  grid6,
  grid5,
  grid4,
  grid6,
  grid2,
  grid5,
];

class ScollableImages extends StatelessWidget {
  const ScollableImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notify) {
        context
            .read(parallaxImageService)
            .setParallaxHzt(notify.metrics.pixels);
        return true;
      },
      child: Container(
        height: 100,
        color: kLightThemeColor.withOpacity(.5),
        padding: kPaddingXlVrt,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _item.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: RoundedImageContainer(image: _item[index]),
                );
              } else if (index == _item.length) {
                return _buildDotterBorder();
              } else {
                return RoundedImageContainer(image: _item[index]);
              }
            }),
      ),
    );
  }

  Padding _buildDotterBorder() {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        color: kWhiteColor,
        dashPattern: const [8, 8],
        child: SizedBox(
            height: 80,
            width: 100,
            child: InkWell(
                onTap: () {},
                child: const Icon(
                  FontAwesomeIcons.images,
                  size: 40,
                ))),
      ),
    );
  }
}
