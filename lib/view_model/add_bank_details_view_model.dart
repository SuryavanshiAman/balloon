import 'package:balloon/repo/add_bank_details_repo.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/utils/routes/routes_name.dart';
import 'package:balloon/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'user_view_model.dart';


class AddBankDetailsViewModel with ChangeNotifier {
  final _addBankDetailsRepo = AddBankDetailsRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addBankDetailsApi(
      dynamic name, dynamic accountNo, dynamic bankName,dynamic ifsc ,context) async {
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    Map data = {
      "userid":userId,
      "name": name,
      "account_number": accountNo,
      "bank_name": bankName,
      "ifsc_code": ifsc
    };
    print(data);
    _addBankDetailsRepo.addBankDetailsApi(data).then((value) {

      if (value['status'] == "200") {
        setLoading(false);
        Navigator.pushReplacementNamed(context, RoutesName.balloonScreen);
        Utils.setSnackBar(value['message'],AppColor.green,context,);
      } else {
        setLoading(false);

        Utils.setSnackBar(value['message'],AppColor.red,context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
