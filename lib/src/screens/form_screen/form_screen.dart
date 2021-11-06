import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:privio/src/config/routes.dart';
import 'package:privio/src/screens/app_animations/app_animations.dart';
import 'package:privio/src/screens/form_screen/components/scrollable_images_list.dart';
import 'package:privio/src/screens/home/components/stacked_positioned_animation.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:privio/src/shared/images.dart';

class FormScreen extends StatelessWidget {
  FormScreen({Key? key}) : super(key: key);
  final _titleTween = createTitleTween();
  final _imageSlideTween = createImageSlideTween();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).orientation == Orientation.portrait
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.width;
    var safeAreaTop = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height - (safeAreaTop + kToolbarHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...items,
              _buildAnimatedForm(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildAnimatedForm() {
    return Expanded(
      child: Padding(
        padding: kPaddingXlHzt,
        child: Form(
          child: AnimationLimiter(
            //key: UniqueKey(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                delay: 200.milliseconds,
                duration: 1000.milliseconds,
                children: formFields,
                childAnimationBuilder: (child) {
                  return SlideAnimation(
                    verticalOffset: -10,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: child,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get items {
    return [
      PlayAnimation<TimelineValue<Prop>>(
        // key: UniqueKey(),
        delay: 200.milliseconds,
        duration: _titleTween.duration,
        curve: Curves.ease,
        tween: _titleTween,
        builder: (context, child, value) {
          return Transform.translate(
              offset: Offset(0, value.get(Prop.translateY)),
              child: Opacity(opacity: value.get(Prop.opacity), child: child!));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text("Send To",
              style:
                  Theme.of(navigatorKey.currentContext!).textTheme.headline2),
        ),
      ),
      PlayAnimation<TimelineValue<Prop>>(
        //key: UniqueKey(),
        tween: _imageSlideTween,
        duration: _imageSlideTween.duration,
        delay: 1500.milliseconds,
        builder: (context, child, value) {
          return Transform.translate(
              offset: Offset(value.get(Prop.translateX), 0),
              child: Opacity(opacity: value.get(Prop.opacity), child: child!));
        },
        child: const ScollableImages(),
      ),
    ];
  }

  List<Widget> get formFields {
    return [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: .5,
          color: kLightThemeColor,
        ))),
        child: Text(
          "Information Represent with Watermark",
          style: Theme.of(navigatorKey.currentContext!)
              .textTheme
              .bodyText1
              ?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
      TextFormField(
        decoration: const InputDecoration(hintText: 'Company *'),
      ),
      TextFormField(
        decoration: const InputDecoration(hintText: 'First Name *'),
      ),
      TextFormField(
        decoration: const InputDecoration(hintText: 'Last Name *'),
      ),
      TextFormField(
        decoration: const InputDecoration(hintText: 'Email Address *'),
      ),
      PlayAnimation<double>(
        key: UniqueKey(),
        delay: 2000.milliseconds,
        curve: Curves.easeInOutBack,
        tween: Tween(begin: 150, end: 0),
        builder: (context, child, value) {
          return Transform.translate(offset: Offset(0, value), child: child!);
        },
        child: Center(
          child: CustomScalingAnimation(
            child: Builder(builder: (context) {
              return FractionallySizedBox(
                  widthFactor: .9,
                  child: ElevatedButton(
                      onPressed: () {
                        context
                            .findAncestorStateOfType<
                                CustomScalingAnimationState>()
                            ?.playScalingAnimation();
                      },
                      child: Text("Submit")));
            }),
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
