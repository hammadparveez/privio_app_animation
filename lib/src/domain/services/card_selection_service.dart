import 'package:flutter/cupertino.dart';
import 'package:privio/src/domain/models/card_model.dart';

class CardSelectionService extends ChangeNotifier {
  final List<CardModel> _selectedItems = [];

  List<CardModel> get selectedItems => _selectedItems;

  void addItem(CardModel model) {
    _selectedItems.add(model);
    notifyListeners();
  }

  void removeItem(CardModel model) {
    _selectedItems.remove(model);
    notifyListeners();
  }

  void addAll(List<CardModel> models) {
    _selectedItems.addAll(models);
    notifyListeners();
  }

  find(CardModel model) {
    return _selectedItems.contains(model);
  }
}
