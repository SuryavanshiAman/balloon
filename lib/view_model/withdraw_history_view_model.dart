import 'package:balloon/model/withdraw_history_model.dart';
import 'package:balloon/repo/withdraw_history_repo.dart';
import 'package:balloon/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WithdrawHistoryViewModel with ChangeNotifier {
  final _withdrawHistoryRepo = WithdrawHistoryRepo();


  WithdrawHistoryModel? _withdrawHistoryData;
  WithdrawHistoryModel? get withdrawHistoryData => _withdrawHistoryData;

  setWithdrawHistory(WithdrawHistoryModel value) {
    _withdrawHistoryData = value;
    notifyListeners();
  }

  Future<void> withdrawHistoryApi(context) async {
    UserViewModel userViewModal = UserViewModel();
    String? userId = await userViewModal.getUser();
    Map data={
      "user_id":userId
    };
    print(data);
    _withdrawHistoryRepo.withdrawHistoryApi(data).then((value) {
      if (value.success == true) {
        setWithdrawHistory(value);
      } else {
        setWithdrawHistory(value);
        if (kDebugMode) {
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('withdrawHistoryApi: $error');
      }
    });
  }
}

