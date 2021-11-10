import 'dart:ui';
import 'dart:math' as math;

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
  int currentValue = 0;
  ValueNotifier<double> value = ValueNotifier(0);
  final _layoutBuilderKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: MediaQuery.of(context).size.height * .3,
              floating: true,
              pinned: true,
              flexibleSpace: CustomFlexibleSpaceBar(
                background: LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Image.asset(
                      grid6,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
                title: LayoutBuilder(builder: (context, constraints) {
                  var isCollapsed = constraints.maxHeight ==
                      MediaQuery.of(context).padding.top + kToolbarHeight;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight - 10,
                        width: constraints.maxWidth,
                        child: Stack(
                          children: [
                            isCollapsed ? const SizedBox() : _buildPlayButton(),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: SizedBox(
                                height: 70,
                                child: _buildHztButtons(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          overlayShape: SliderComponentShape.noOverlay,
                          minThumbSeparation: 0,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 0),
                        ),
                        child: SizedBox(
                          height: 5,
                          child: Slider(
                              inactiveColor: Colors.grey,
                              activeColor: kWhiteColor,
                              value: currentValue.toDouble(),
                              min: 0,
                              max: 100,
                              onChanged: (value) {
                                setState(() {
                                  currentValue = value.toInt();
                                });
                              }),
                        ),
                      ),
                    ],
                  );
                }),
                titlePadding: EdgeInsets.zero,
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

  Widget _buildHztButtons() {
    double iconSize = 28;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _iconButton(28, Icons.play_arrow, () {}),
        _iconButton(28, Icons.volume_up_outlined, () {}),
        SliderTheme(
          data: SliderThemeData(
            overlayShape: SliderComponentShape.noOverlay,
            minThumbSeparation: 0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
          ),
          child: SizedBox(
            width: 50,
            height: iconSize + 15,
            child: Slider(
                inactiveColor: Colors.grey,
                activeColor: kWhiteColor,
                value: currentValue.toDouble(),
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    currentValue = value.toInt();
                  });
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 12),
          child: Row(
            children: const [
              Text("0:13", style: TextStyle(fontSize: 12, color: kWhiteColor)),
              Text(" / ", style: TextStyle(fontSize: 12, color: kWhiteColor)),
              Text("4:00", style: TextStyle(fontSize: 12, color: kWhiteColor)),
            ],
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _iconButton(iconSize, Icons.hd_outlined, () {}),
            _iconButton(iconSize, Icons.fullscreen, () {}),
          ],
        ),
      ],
    );
  }

  Widget _iconButton(double iconSize, IconData icon, VoidCallback onTap) {
    return IconButton(
      color: kWhiteColor,
      icon: Icon(icon),
      onPressed: () {},
    );
  }

  Widget _buildPlayButton() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                    color: kWhiteColor,
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.play, size: 15)),
              )),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////
///
///
///
///Custom FLexible Space Bar
class CustomFlexibleSpaceBar extends StatefulWidget {
  const CustomFlexibleSpaceBar({
    Key? key,
    this.title,
    this.background,
    this.centerTitle,
    this.titlePadding,
    this.collapseMode = CollapseMode.parallax,
    this.stretchModes = const <StretchMode>[StretchMode.zoomBackground],
  })  : assert(collapseMode != null),
        super(key: key);

  final Widget? title;

  final Widget? background;

  final bool? centerTitle;

  final CollapseMode collapseMode;

  final List<StretchMode> stretchModes;

  final EdgeInsetsGeometry? titlePadding;

  static Widget createSettings({
    double? toolbarOpacity,
    double? minExtent,
    double? maxExtent,
    bool? isScrolledUnder,
    required double currentExtent,
    required Widget child,
  }) {
    //assert(currentExtent != null);
    return FlexibleSpaceBarSettings(
      toolbarOpacity: toolbarOpacity ?? 1.0,
      minExtent: minExtent ?? currentExtent,
      maxExtent: maxExtent ?? currentExtent,
      isScrolledUnder: isScrolledUnder,
      currentExtent: currentExtent,
      child: child,
    );
  }

  @override
  State<CustomFlexibleSpaceBar> createState() => _FlexibleSpaceBarState();
}

class _FlexibleSpaceBarState extends State<CustomFlexibleSpaceBar> {
  bool _getEffectiveCenterTitle(ThemeData theme) {
    if (widget.centerTitle != null) return widget.centerTitle!;
    //assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
    }
  }

  Alignment _getTitleAlignment(bool effectiveCenterTitle) {
    if (effectiveCenterTitle) return Alignment.bottomCenter;
    final TextDirection textDirection = Directionality.of(context);

    switch (textDirection) {
      case TextDirection.rtl:
        return Alignment.bottomRight;
      case TextDirection.ltr:
        return Alignment.bottomLeft;
    }
  }

  double _getCollapsePadding(double t, FlexibleSpaceBarSettings settings) {
    switch (widget.collapseMode) {
      case CollapseMode.pin:
        return -(settings.maxExtent - settings.currentExtent);
      case CollapseMode.none:
        return 0.0;
      case CollapseMode.parallax:
        final double deltaExtent = settings.maxExtent - settings.minExtent;
        return -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final FlexibleSpaceBarSettings settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;

        final List<Widget> children = <Widget>[];

        final double deltaExtent = settings.maxExtent - settings.minExtent;

        // 0.0 -> Expanded
        // 1.0 -> Collapsed to toolbar
        final double t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);

        // background
        if (widget.background != null) {
          final double fadeStart =
              math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
          const double fadeEnd = 1.0;
          assert(fadeStart <= fadeEnd);
          // If the min and max extent are the same, the app bar cannot collapse
          // and the content should be visible, so opacity = 1.
          var interval = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
          final precisedInterval = double.parse(interval.toStringAsFixed(1));
          final customInterval = math.max(precisedInterval, 0.6);

          final double opacity =
              settings.maxExtent == settings.minExtent ? 1.0 : customInterval;
          double height = settings.maxExtent;

          // StretchMode.zoomBackground
          if (widget.stretchModes.contains(StretchMode.zoomBackground) &&
              constraints.maxHeight > height) {
            height = constraints.maxHeight;
          }
          children.add(Positioned(
            top: _getCollapsePadding(t, settings),
            left: 0.0,
            right: 0.0,
            height: height,
            child: Opacity(
              // IOS is relying on this semantics node to correctly traverse
              // through the app bar when it is collapsed.
              alwaysIncludeSemantics: true,
              opacity: opacity,
              child: widget.background,
            ),
          ));

          // StretchMode.blurBackground
          if (widget.stretchModes.contains(StretchMode.blurBackground) &&
              constraints.maxHeight > settings.maxExtent) {
            final double blurAmount =
                (constraints.maxHeight - settings.maxExtent) / 10;
            children.add(Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurAmount,
                  sigmaY: blurAmount,
                ),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ));
          }
        }

        // title
        if (widget.title != null) {
          final ThemeData theme = Theme.of(context);

          Widget? title;
          switch (theme.platform) {
            case TargetPlatform.iOS:
            case TargetPlatform.macOS:
              title = widget.title;
              break;
            case TargetPlatform.android:
            case TargetPlatform.fuchsia:
            case TargetPlatform.linux:
            case TargetPlatform.windows:
              title = Semantics(
                namesRoute: true,
                child: widget.title,
              );
              break;
          }

          // StretchMode.fadeTitle
          if (widget.stretchModes.contains(StretchMode.fadeTitle) &&
              constraints.maxHeight > settings.maxExtent) {
            final double stretchOpacity = 1 -
                (((constraints.maxHeight - settings.maxExtent) / 100)
                    .clamp(0.0, 1.0));
            title = Opacity(
              opacity: stretchOpacity,
              child: title,
            );
          }

          final double opacity = settings.toolbarOpacity;
          if (opacity > 0.0) {
            TextStyle titleStyle = theme.primaryTextTheme.headline6!;
            titleStyle = titleStyle.copyWith(
              color: titleStyle.color!.withOpacity(opacity),
            );
            final bool effectiveCenterTitle = _getEffectiveCenterTitle(theme);
            final EdgeInsetsGeometry padding = widget.titlePadding ??
                EdgeInsetsDirectional.only(
                  start: effectiveCenterTitle ? 0.0 : 72.0,
                  bottom: 16.0,
                );
            final double scaleValue =
                Tween<double>(begin: 1, end: 1.0).transform(t);
            final Matrix4 scaleTransform = Matrix4.identity()
              ..scale(scaleValue, scaleValue, 1.0);
            final Alignment titleAlignment =
                _getTitleAlignment(effectiveCenterTitle);
            children.add(Container(
              padding: padding,
              child: Transform(
                alignment: titleAlignment,
                transform: scaleTransform,
                child: Align(
                  alignment: titleAlignment,
                  child: DefaultTextStyle(
                    style: titleStyle,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth / scaleValue,
                          alignment: titleAlignment,
                          child: title,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ));
          }
        }

        return ClipRect(child: Stack(children: children));
      },
    );
  }
}
