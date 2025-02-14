import 'package:balloon/repo/withdraw_repo.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/utils/routes/routes_name.dart';
import 'package:balloon/utils/utils.dart';
import 'package:balloon/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WithdrawViewModel with ChangeNotifier {
  final _withdrawRepo = WithdrawRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // ProfileViewModel profileViewModel = ProfileViewModel();

  Future<void> withdrawApi(dynamic amount,context) async {
    setLoading(true);

    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    Map data={
      "user_id":userId,
      "account_id":"1",
      "amount":amount
    };
    _withdrawRepo.withdrawApi(data).then((value) {
      if (value['status'] ==200) {
        setLoading(false);
        // profileViewModel.getProfileApi(context);
        Navigator.pushReplacementNamed(context, RoutesName.balloonScreen);
        Utils.setSnackBar(value['msg'],AppColor.green, context);
      }
      else{
        setLoading(false);
        Utils.setSnackBar(value['msg'],AppColor.red,  context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

}