import 'package:balloon/model/view_bank_model.dart';
import 'package:balloon/repo/view_bank_repo.dart';
import 'package:balloon/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class ViewBankViewModel with ChangeNotifier {
  final _viewBankRepo = ViewBankRepo();


  BankViewModel? _bankData;
  BankViewModel? get bankData => _bankData;

  setBankData(BankViewModel value) {
    _bankData = value;
    notifyListeners();
  }

  Future<void> viewBankApi(context) async {
    UserViewModel userViewModal = UserViewModel();
    String? userId = await userViewModal.getUser();
    Map data={
      "userid": userId,
    };
    print(data);
    _viewBankRepo.viewBankApi(data).then((value) {
      if (value.status == "200") {
        setBankData(value);
      } else {
        setBankData(value);
        if (kDebugMode) {
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('viewBankApi: $error');
      }
    });
  }
}

