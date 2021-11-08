import 'dart:math';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privio/src/config/routes.dart';
import 'package:privio/src/domain/models/card_model.dart';
import 'package:privio/src/domain/state_management/pods.dart';
import 'package:privio/src/screens/app_animations/app_animations.dart';
import 'package:privio/src/screens/home/components/animated_positioned_next_btn.dart';
import 'package:privio/src/screens/home/components/stacked_positioned_animation.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/helper.dart';
import 'package:privio/src/shared/images.dart';
import 'package:privio/src/shared/strings.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart' as charge;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _models = [
  CardModel(
      id: 1,
      title: 'Avenger Age of Ultrion',
      cardImage: grid2,
      isTrailer: true),
  CardModel(
      id: 1,
      title: 'The Amazing Spider Man',
      cardImage: grid4,
      isTrailer: false),
  CardModel(id: 1, title: 'The Thor', cardImage: grid5, isTrailer: false),
  CardModel(id: 1, title: 'Ultra Superman', cardImage: grid6, isTrailer: true),
  CardModel(
      id: 1,
      title: 'Avenger Age of Ultrion',
      cardImage: grid2,
      isTrailer: true),
  CardModel(
      id: 1,
      title: 'The Amazing Spider Man',
      cardImage: grid4,
      isTrailer: false),
  CardModel(id: 1, title: 'The Thor', cardImage: grid5, isTrailer: false),
  CardModel(id: 1, title: 'Ultra Superman', cardImage: grid6, isTrailer: true),
  CardModel(
      id: 1,
      title: 'Avenger Age of Ultrion',
      cardImage: grid2,
      isTrailer: true),
  CardModel(
      id: 1,
      title: 'The Amazing Spider Man',
      cardImage: grid4,
      isTrailer: false),
  CardModel(id: 1, title: 'The Thor', cardImage: grid5, isTrailer: false),
  CardModel(id: 1, title: 'Ultra Superman', cardImage: grid6, isTrailer: true),
  CardModel(
      id: 1,
      title: 'Avenger Age of Ultrion',
      cardImage: grid2,
      isTrailer: true),
  CardModel(
      id: 1,
      title: 'The Amazing Spider Man',
      cardImage: grid4,
      isTrailer: false),
  CardModel(id: 1, title: 'The Thor', cardImage: grid5, isTrailer: false),
  CardModel(id: 1, title: 'Ultra Superman', cardImage: grid6, isTrailer: true),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AnimationMixin {
  final _positionedKey = GlobalKey<StackedPositionedAnimatedState>();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _onScrollNotification(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.forward) {
      if (notification.metrics.pixels != 0.0) {
        _positionedKey.currentState?.bringUpButton();
      }
    } else if (notification.direction == ScrollDirection.reverse) {
      _positionedKey.currentState?.takeDownButton();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: kPaddingXlHzt,
        child: Stack(
          children: [
            Column(
              children: [
                _buildAnimatedTopBar(),
                NotificationListener(
                    onNotification: _onScrollNotification,
                    child: _buildStaggeredGridView(context)),
              ],
            ),
            //Scroll More Button above content
            StackedPositionedAnimated(
              key:
                  _positionedKey, //Accessing Item State in order to animate on Scroll Changes
              scrollController: _scrollController,
            ),
            AnimatedPositionedNextStepButton(onTap: () {
              Navigator.pushNamed(context, Routes.formView);
            }),
          ],
        ),
      ),
    );
  }

  Expanded _buildStaggeredGridView(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: kPaddingXXlVrt,
        child: GridView.builder(
            controller: _scrollController,
            itemCount: _models.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisExtent: 220,
                mainAxisSpacing: 20),
            itemBuilder: (_, index) {
              final card = _models[index];
              return _animatedCardTile(index, card);
            }),
      ),
    );
  }

  AnimationLimiter _animatedCardTile(int index, CardModel card) {
    return AnimationLimiter(
      child: AnimationConfiguration.staggeredGrid(
        delay: 300.milliseconds,
        columnCount: 2,
        position: index % 2 == 0 ? 0 : 1,
        child: SlideAnimation(
          duration: 1000.milliseconds,
          verticalOffset: -MediaQuery.of(context).size.height * .05,
          horizontalOffset: -50,
          child: FadeInAnimation(
            duration: 1500.milliseconds,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    final diagonal = getDiagonal(
                        constraints.maxHeight, constraints.maxWidth);
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        _buildRoundedImage(card),
                        Positioned(
                          left: -diagonal * .25,
                          top: diagonal * .45,
                          width: diagonal,
                          child: _buildRotatedBanner(card),
                        ),
                        _buildShadowSelector(constraints, card),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: _buildSelectorButton(card),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Text(card.title, style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildSelectorButton(CardModel card) {
    return GestureDetector(
      onTap: () {
        var provider = context.read(cardService);
        if (provider.find(card)) {
          provider.removeItem(card);
        } else {
          provider.addItem(card);
        }
      },
      child: Container(
        width: 25,
        height: 25,
        padding: const EdgeInsets.all(3),
        child: const Material(
          color: kWhiteColor,
          shape: CircleBorder(),
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 3, color: kWhiteColor)),
      ),
    );
  }

  ClipRRect _buildRoundedImage(CardModel card) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        card.cardImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Consumer _buildShadowSelector(BoxConstraints constraints, CardModel card) {
    return Consumer(
      builder: (context, watch, child) {
        return AnimatedCrossFade(
            reverseDuration: 250.milliseconds,
            firstChild: SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: PlayAnimation<double>(
                tween: Tween(begin: .8, end: .5),
                builder: (_, child, value) {
                  return DecoratedBox(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: kBlackColor.withOpacity(value),
                          spreadRadius: 5,
                          blurRadius: 30),
                    ]),
                  );
                },
              ),
            ),
            secondChild: const SizedBox(),
            crossFadeState: watch(cardService).find(card)
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: 250.milliseconds);
      },
    );
  }

  Widget _buildRotatedBanner(CardModel card) {
    return Container(
      color: card.isTrailer ? kGreenColor : kButtonColor,
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateZ(-45 * (pi / 180)),
      child: Text(
        '${card.isTrailer ? 'trailer' : 'film'}'.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(height: 1.4, fontSize: 12, color: kWhiteColor),
      ),
    );
  }

  Widget _buildAnimatedTopBar() {
    return AnimationLimiter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
            childAnimationBuilder: (widget) {
              return SlideAnimation(
                  delay: 500.milliseconds,
                  duration: 500.milliseconds,
                  verticalOffset: -30,
                  curve: Curves.easeInQuad,
                  child: FadeInAnimation(
                    duration: 1000.milliseconds,
                    curve: Curves.easeInQuad,
                    child: widget,
                  ));
            },
            children: _listOfChildren),
      ),
    );
  }

  List<Widget> get _listOfChildren {
    return [
      Text(AppStrings.dashBoard, style: Theme.of(context).textTheme.headline2),
      Row(
        children: [
          Flexible(child: _searchFormField()),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(FontAwesomeIcons.sortAlphaDown),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(FontAwesomeIcons.calendarAlt),
            onPressed: () {},
          ),
        ],
      ),
    ];
  }

  Widget _searchFormField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppStrings.search,
        prefixIconConstraints: const BoxConstraints(minHeight: 48, minWidth: 0),
        prefixIcon: Padding(
          padding: kPaddingDefaultRight,
          child: Image.asset(searchIcon,
              color: kLightThemeColor,
              height: 24,
              width: 24), //Icon(Icons.search, color: kLightThemeColor),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: Image.asset(
        logo,
        width: 150,
      ),
      leading: const Icon(Icons.menu),
    );
  }
}
