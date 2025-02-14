import 'package:balloon/model/bet_history_model.dart';
import 'package:balloon/repo/bet_history_repo.dart';
import 'package:balloon/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BetHistoryViewModel with ChangeNotifier {
  final _betHistoryRepo =  BetHistoryRepo();

  BetHistoryModel? _giftHistoryData;
  BetHistoryModel? get giftHistoryData => _giftHistoryData;

  setBetHistory(BetHistoryModel value) {
    _giftHistoryData = value;
    notifyListeners();
  }

  Future<void> betHistoryApi(context) async {
    UserViewModel userViewModal = UserViewModel();
    String? userId = await userViewModal.getUser();
    Map data={
      "user_id":userId
    };
    print(data);
    _betHistoryRepo.betHistoryApi(data).then((value) {
      if (value.status == true) {
        setBetHistory(value);
      } else {
        setBetHistory(value);
        if (kDebugMode) {
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('betHistoryApi: $error');
      }
    });
  }
}

