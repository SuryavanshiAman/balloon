
import 'package:balloon/repo/bet_repo.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/utils/utils.dart';
import 'package:balloon/view_model/profile_view_model.dart';
import 'package:balloon/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BetViewModel with ChangeNotifier {
  final _betRepo = BetRepo();

  bool _loading = false;

  bool get loading => _loading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> betApi(dynamic amount,dynamic multiplayer, context) async {
    UserViewModel userViewModal = UserViewModel();
    String? userId = await userViewModal.getUser();
    setLoading(true);
    Map data={
      "user_id": userId,
      "bet_amount": amount.toString(),
      "winning_amount": multiplayer
    };
    print(data);
    print(userId);
    _betRepo.betApi(data).then((value) {
      if (value['status'] == true) {
        setLoading(false);
        Provider.of<ProfileViewModel>(context, listen: false).getProfileApi(context);
        Utils.setSnackBar(value['message'], AppColor.green, context);
      }
      else {
        setLoading(false);
        Utils.setSnackBar(value['message'], AppColor.red, context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('betApi: $error');
      }
    });
  }
}