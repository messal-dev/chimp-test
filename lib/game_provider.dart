import 'package:flutter/material.dart';

class GameModel {
  final int value;
  bool isShow;
  bool? isCorrect;

  GameModel(this.value, this.isShow, this.isCorrect);
}

class GameProvider extends ChangeNotifier {
  final int _totalItems = 24;
  int get totalItems => _totalItems;

  final List<GameModel> _items = [];
  List<GameModel> get items => _items;

  final int _amount = 3;
  int get amount => _amount;

  int _level = 1;
  int get level => _level;

  int _highLevel = 0;
  int get highLevel => _highLevel;

  bool? _isWin;
  bool? get isWin => _isWin;

  bool? _isPlay;
  bool? get isPlay => _isPlay;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  void start() {
    // Start with clear list first
    _items.clear();
    _isPlay = true;

    if (_isWin == true) {
      if (_level > _highLevel) {
        _highLevel = _level;
      }

      if (_isSuccess == true) {
        _level = 1;
      } else {
        _level++;
      }
    } else {
      _level = 1;
    }

    final int totalAmount = _amount + _level;

    for (int i = 0; i < _totalItems; i++) {
      final int value = i > totalAmount ? 0 : i + 1;

      _items.add(GameModel(value, true, null));
    }

    // Random placement in list
    _items.shuffle();

    // Reset value
    _currentCheckIndex = 0;
    _isWin = null;

    notifyListeners();
  }

  int _currentCheckIndex = 0;

  void checkAnswer(GameModel game) {
    // Start to hide other box
    for (var item in _items) {
      item.isShow = false;
    }

    // Get new list
    final newList = _items.where((item) => item.value > 0).toList();
    // Sort to 1,2,3....
    newList.sort((a, b) => a.value.compareTo(b.value));

    // Get index from items
    final itemIndex = _items.indexOf(game);

    // Check
    if (newList[_currentCheckIndex].value == game.value) {
      // Is Correct
      _items[itemIndex].isCorrect = true;

      // Check Is Still Not Correct All
      bool isNotCorrect = newList
          .any((item) => (item.isCorrect == false || item.isCorrect == null));

      if (!isNotCorrect) {
        _isWin = true;
        _isPlay = false;

        if (_level >= 20) {
          _isSuccess = true;
        }
      }
    } else {
      // Is not correct
      _isWin = false;
      _isPlay = false;
      _isSuccess = false;

      _items[itemIndex].isCorrect = false;
      _items[itemIndex].isShow = true;
    }

    // Increase check index
    _currentCheckIndex++;

    notifyListeners();
  }
}
