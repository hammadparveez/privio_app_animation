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
    lang: "EN",
    hasViewd: false,
    isNew: true,
    isTrailer: false,
  ),
  MovieBriefModel(
    date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    time: DateFormat('HH:mm').format(DateTime.now()),
    image: grid4,
    title: "Avengers of Ultra Union",
    lang: "EN",
    hasViewd: true,
  ),
  MovieBriefModel(
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      time: DateFormat('HH:mm').format(DateTime.now()),
      image: grid5,
      title: "Avengers of Ultra Union",
      hasViewd: false,
      isNew: true,
      isTrailer: false,
      lang: "EN"),
  MovieBriefModel(
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      time: DateFormat('HH:mm').format(DateTime.now()),
      image: grid6,
      title: "Avengers of Ultra Union",
      hasViewd: true,
      lang: "EN"),
];

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text("Movies List",
                style: Theme.of(context).textTheme.headline2),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _moviesList.length,
              itemBuilder: (_, index) {
                var movie = _moviesList[index];
                return Container(
                  padding: kPaddingXLall,
                  margin: const EdgeInsets.only(bottom: 2),
                  color: kLightThemeColor.withAlpha(50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BannerImageContainer(
                          image: _moviesList[index].image, onTap: () {}),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SizedBox(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: movie.hasViewd
                                              ? Colors.grey
                                              : movie.isNew
                                                  ? kGreenColor
                                                  : kLightThemeColor),
                                      child: Text(
                                          movie.hasViewd
                                              ? 'Viewed'
                                              : movie.isNew
                                                  ? 'New'
                                                  : 'Expired',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                color: kWhiteColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              )),
                                    ),
                                    Text(_moviesList[index].date),
                                    Text(" ${_moviesList[index].time}"),
                                  ],
                                ),
                                Text(_moviesList[index].title,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                Row(
                                  children: [
                                    Text(_moviesList[index].isTrailer
                                        ? 'Trailer'
                                        : 'Film'),
                                    Container(
                                      height: 15,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: VerticalDivider(
                                        width: 5,
                                        color: kWhiteColor,
                                      ),
                                    ),
                                    Text(_moviesList[index].lang),
                                  ],
                                ),
                              ],
                            ),
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
      leading:
          IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.bars)),
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

class BannerImageContainer extends StatelessWidget {
  const BannerImageContainer({
    Key? key,
    required this.image,
    this.onTap,
  }) : super(key: key);
  final VoidCallback? onTap;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
      alignment: Alignment.bottomRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        elevation: 8,
        shadowColor: kBlackColor.withOpacity(.5),
        color: kButtonColor,
        child: InkResponse(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(6),
            child:
                const Icon(FontAwesomeIcons.play, size: 10, color: kWhiteColor),
          ),
        ),
      ),
    );
  }
}
