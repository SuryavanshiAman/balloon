import 'package:balloon/repo/deposit_repo.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/utils/routes/routes_name.dart';
import 'package:balloon/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'user_view_model.dart';

class DepositViewModel with ChangeNotifier{
  final _depositRepo = DepositRepo();

  bool _loading = false;

  bool get loading => _loading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> depositApi(dynamic amount, context) async {
    UserViewModel userViewModal = UserViewModel();
    String? userId = await userViewModal.getUser();
    setLoading(true);
    Map data={
      "userid":userId,
      "amount":amount,
      "type":"0"
    };
    print(data);
    _depositRepo.depositApi(data).then((value) {
      if (value['status'] == "SUCCESS") {
        setLoading(false);

        launchURL(value['payment_link'].toString());
      }
      else {
        setLoading(false);
        Utils.setSnackBar(value['message'], AppColor.red, context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('depositApi: $error');
      }
    });
  }
  static Future<void> launchURL(String url) async {
    try {
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Could not launch: $uri");
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }
}
