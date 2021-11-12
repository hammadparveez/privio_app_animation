import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:privio/src/domain/services/card_selection_service.dart';
import 'package:privio/src/domain/services/parallax_image_service.dart';
import 'package:privio/src/domain/services/video_play_service.dart';
import 'package:privio/src/shared/extensions.dart';

final cardService = ChangeNotifierProvider((ref) => CardSelectionService());
final parallaxImageService =
    ChangeNotifierProvider((ref) => ParallaxImageService());
final videoPlayService = ChangeNotifierProvider((ref) => VideoPlayService());
final videoDurationService = StateProvider(
    (ref) => ref.watch(videoPlayService).videoPlayerController.value.position);
