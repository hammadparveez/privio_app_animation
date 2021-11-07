import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:privio/src/domain/models/movie_brief_model.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/images.dart';

var _moviesList = [
  MovieBriefModel(
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      time: DateFormat('HH:mm').format(DateTime.now()),
      image: grid2,
      title: "Avengers of Ultra Union",
      lang: "EN"),
  MovieBriefModel(
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      time: DateFormat('HH:mm').format(DateTime.now()),
      image: grid4,
      title: "Avengers of Ultra Union",
      lang: "EN"),
  MovieBriefModel(
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      time: DateFormat('HH:mm').format(DateTime.now()),
      image: grid5,
      title: "Avengers of Ultra Union",
      lang: "EN"),
  MovieBriefModel(
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      time: DateFormat('HH:mm').format(DateTime.now()),
      image: grid6,
      title: "Avengers of Ultra Union",
      lang: "EN"),
];

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: kPaddingXlHzt,
            child: Text("Movies List",
                style: Theme.of(context).textTheme.headline2),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _moviesList.length,
              itemBuilder: (_, index) {
                return Container(
                  padding: kPaddingXLall,
                  margin: const EdgeInsets.only(bottom: 2),
                  color: kLightThemeColor,
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_moviesList[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Material(
                            type: MaterialType.transparency,
                            shape: const CircleBorder(),
                            child: InkResponse(
                                customBorder: const CircleBorder(),
                                onTap: () {},
                                child: Icon(FontAwesomeIcons.play,
                                    size: 15, color: kWhiteColor)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.bars)),
      title: Image.asset(
        logo,
        width: 150,
      ),
      actions: [
        _buildNotificationIconButton(context),
        IconButton(
            onPressed: () {},
            icon: Image.asset(
              searchIcon,
              color: kWhiteColor,
            )),
      ],
    );
  }

  Widget _buildNotificationIconButton(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.bell)),
        Positioned(
          top: 3,
          right: 2,
          child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: kLightThemeColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                "9",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 12,
                      color: kWhiteColor,
                    ),
              )),
        ),
      ],
    );
  }
}
