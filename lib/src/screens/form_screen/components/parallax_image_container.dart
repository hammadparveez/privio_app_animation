
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:privio/src/domain/state_management/pods.dart';

class RoundedImageContainer extends StatelessWidget {
  const RoundedImageContainer(
      {Key? key, required this.image})
      : super(key: key);
  final String image;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Consumer(builder: (context, watch, child) {
          return Image.asset(
            image,
            height: 80,
            alignment:
                watch(parallaxImageService).imageAlignment ?? Alignment.center,
            width: 100,
            fit: BoxFit.cover,
          );
        }),
      ),
    );
  }
}
