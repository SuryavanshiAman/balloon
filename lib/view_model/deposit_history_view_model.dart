import 'package:balloon/model/deposit_history_model.dart';
import 'package:balloon/repo/deposit_history_repo.dart';
import 'package:balloon/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class DepositHistoryViewModel with ChangeNotifier {
  final _depositHistoryRepo = DepositHistoryRepo();


  DepositHistoryModel? _depositHistoryData;
  DepositHistoryModel? get depositHistoryData => _depositHistoryData;

  setDepositHistory(DepositHistoryModel value) {
    _depositHistoryData = value;
    notifyListeners();
  }

  Future<void> depositHistoryApi(context) async {
    UserViewModel userViewModal = UserViewModel();
    String? userId = await userViewModal.getUser();
    Map data={
      "userid": userId,
    };
    print(data);
    _depositHistoryRepo.depositHistoryApi(data).then((value) {
      if (value.success == true) {
        setDepositHistory(value);
      } else {
        setDepositHistory(value);
        if (kDebugMode) {
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('depositHistoryApi: $error');
      }
    });
  }
}

