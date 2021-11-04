import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privio/src/domain/services/card_selection_service.dart';

final cardService = ChangeNotifierProvider((ref) => CardSelectionService());
