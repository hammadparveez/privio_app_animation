import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:privio/src/domain/state_management/pods.dart';
import 'package:privio/src/shared/constants.dart';

class CustomSlider extends StatelessWidget {
 
  final double thumbRadius;
  final Size? sliderSize;
  final double value;
  final double min;
  final double max;
  final Function(double) onChanged;
  
  const CustomSlider({
    Key? key,
    this.thumbRadius = 5,
    this.sliderSize,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: thumbRadius),
      ),
      child: SizedBox(
        width: sliderSize != null ? sliderSize!.width : null,
        height:sliderSize != null ? sliderSize!.height : null,
        child:  Slider(
              inactiveColor: Colors.grey,
              activeColor: kWhiteColor,
              value:value,
              min: min,
              max: max,
              onChanged: onChanged),
        
      ),
    );
  }
}
