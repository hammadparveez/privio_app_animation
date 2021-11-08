import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privio/src/domain/models/movie_brief_model.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/images.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key, required this.model}) : super(key: key);
  final MovieBriefModel model;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: kButtonColor,
              expandedHeight: 100,
              stretch: true,
              floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: FlexibleSpaceBar(
                    background: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("WhatsApp",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: kWhiteColor)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Row(
                            children: [
                              IconButton(
                                  color: kWhiteColor,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  constraints:
                                      const BoxConstraints(maxHeight: 24),
                                  onPressed: () {},
                                  icon: const Icon(Icons.search)),
                              IconButton(
                                  color: kWhiteColor,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  constraints:
                                      const BoxConstraints(maxHeight: 24),
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_vert)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    titlePadding: EdgeInsets.zero,
                  ),
                ),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Chats',
                  ),
                  Tab(text: 'Status'),
                  Tab(text: 'Calls'),
                ],
              ),
            ),
            SliverList(delegate: SliverChildBuilderDelegate((_, index) {
              return ListTile(
                title: Text("Hello World"),
              );
            }))
          ],
        ),
      ),
    );
  }
}
