import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/helper.dart';
import 'package:privio/src/shared/images.dart';
import 'package:privio/src/shared/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<Widget> _listOfChildren(BuildContext context) {
      return [
        Text(AppStrings.dashBoard,
            style: Theme.of(context).textTheme.headline2),
        Row(
          children: [
            Flexible(
                child: TextFormField(
              decoration: const InputDecoration(
                hintText: AppStrings.search,
                prefixIconConstraints:
                    BoxConstraints(minHeight: 48, minWidth: 0),
                prefixIcon: Padding(
                  padding: kPaddingDefaultRight,
                  child: Icon(Icons.search, color: kLightThemeColor),
                ),
              ),
            )),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.sort_by_alpha_outlined),
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: () {},
            ),
          ],
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Image.asset(
          logo,
          width: 150,
        ),
        leading: const Icon(Icons.menu),
      ),
      body: Padding(
        padding: kPaddingXlHzt,
        child: AnimationLimiter(
          //key: UniqueKey(),
          child: Column(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                      childAnimationBuilder: (widget) {
                        return SlideAnimation(
                            delay: Duration(milliseconds: 300),
                            duration: Duration(milliseconds: 500),
                            verticalOffset: -2,
                            curve: Curves.easeInQuad,
                            child: FadeInAnimation(
                              duration: Duration(milliseconds: 800),
                              curve: Curves.easeInQuad,
                              child: widget,
                            ));
                      },
                      children: [
                        ..._listOfChildren(context),
                      ])),
              Expanded(
                child: Padding(
                  padding: kPaddingXXlVrt,
                  child: GridView.builder(
                      itemCount: 300,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 25,
                              mainAxisExtent: 220,
                              mainAxisSpacing: 20),
                      itemBuilder: (_, index) {
                        debugPrint(
                            "========== Fetching $index=================");
                        return AnimationLimiter(
                          child: AnimationConfiguration.staggeredGrid(
                            delay: const Duration(milliseconds: 500),
                            columnCount: 2,
                            position: index % 2 == 0 ? 0 : 1,
                            child: SlideAnimation(
                              duration: Duration(milliseconds: 1000),
                              verticalOffset:
                                  -MediaQuery.of(context).size.height / 2,
                              child: FadeInAnimation(
                                duration: Duration(milliseconds: 1500),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        final diagonal = getDiagonal(
                                            constraints.maxHeight,
                                            constraints.maxWidth);
                                        return Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                grid2,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              right: 10,
                                              child: Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 3,
                                                        color: kWhiteColor)),
                                              ),
                                            ),
                                            Positioned(
                                              left: -diagonal * .25,
                                              top: diagonal * .45,
                                              width: diagonal,
                                              child: Container(
                                                color: kGreenColor,
                                                alignment: Alignment.center,
                                                transform: Matrix4.identity()
                                                  ..rotateZ(-45 * (pi / 180)),
                                                child: Text(
                                                  "trailer".toUpperCase(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      ?.copyWith(
                                                          fontSize: 12,
                                                          color: kWhiteColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("Avengers: Age Of $index",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
