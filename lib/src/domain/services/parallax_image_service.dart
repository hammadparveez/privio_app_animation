import 'dart:math';

import 'package:flutter/cupertino.dart';

class ParallaxImageService extends ChangeNotifier {
  Alignment? _imageAlignment;


 Alignment? get imageAlignment => _imageAlignment;



  void setParallaxHzt(double value) {
    _imageAlignment = Alignment(cos(value * pi / 180), 0);
    notifyListeners();
  }
  void setParallaxVrt(double value) {
    _imageAlignment = Alignment(0, sin(value * pi / 180));
    notifyListeners();
  }
}
