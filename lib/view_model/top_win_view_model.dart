import 'package:balloon/model/bet_history_model.dart';
import 'package:balloon/model/top_win_model.dart';
import 'package:balloon/repo/bet_history_repo.dart';
import 'package:balloon/repo/top_win_repo.dart';
import 'package:balloon/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TopWinViewModel with ChangeNotifier {
  final _topWinRepo =  TopWinRepo();

  TopWinModel? _topWinData;
  TopWinModel? get topWinData => _topWinData;

  setTopWin(TopWinModel value) {
    _topWinData = value;
    notifyListeners();
  }

  Future<void> topWinApi(context) async {

    _topWinRepo.topWinApi().then((value) {
      if (value.status == true) {
        print("jjjjj");
        setTopWin(value);
      } else {
        setTopWin(value);
        if (kDebugMode) {
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('topWinApi: $error');
      }
    });
  }
}

