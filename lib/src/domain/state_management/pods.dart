import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privio/src/domain/services/card_selection_service.dart';
import 'package:privio/src/domain/services/parallax_image_service.dart';

final cardService = ChangeNotifierProvider((ref) => CardSelectionService());
final parallaxImageService = ChangeNotifierProvider((ref) => ParallaxImageService());
