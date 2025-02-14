// ignore_for_file: use_build_context_synchronously

import 'package:balloon/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../user_view_model.dart';

class SplashServices with ChangeNotifier  {
  Future<String?> getUserData() => UserViewModel().getUser();
  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (kDebugMode) {
        print(value.toString());
        print('valueId');
      }
      if (value.toString() == 'null' || value.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.balloonScreen);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  double _loading = 0.0;
  double get loading => _loading;

  void setIndicator(double value) {
    _loading = value;
    print(_loading);
    print("hellow");
    notifyListeners();
  }


  // final _updateApk = UpdateApkRepository();
  // Future<void> updateApkApi(context) async {
  //   _updateApk.updateApkApi().then((value) {
  //
  //     if (value['status'] == 200) {
  //       if(value['data']['version']!=AppConstants.appVersion){
  //         _downloadAndInstall(context, value['data']['app_url']);
  //       }else{ checkAuthentication(context);}
  //     } else {
  //       checkAuthentication(context);
  //     }
  //   }).onError((error, stackTrace) {
  //     if (kDebugMode) {
  //       print('error: $error');
  //     }
  //   });
  // }
  //
  // void _downloadAndInstall(context, String downloadUrl) async {
  //   Dio dio = Dio();
  //   var dir = await getExternalStorageDirectory();
  //   String filePath = "${dir?.path}/FutureTrade.apk";
  //
  //   await dio.download(
  //     downloadUrl,
  //     filePath,
  //     onReceiveProgress: (received, total) {
  //       if (total != -1) {
  //         double progress = (received / total);
  //         print(progress);
  //         print("hiii");
  //         setIndicator(progress);
  //       }
  //     },
  //   );
  //
  //   InstallPlugin.installApk(filePath, appId: 'com.future_trade.com.future_trade')
  //       .then((result) {
  //     checkAuthentication(context);
  //     if (kDebugMode) {
  //       print('Install result: $result');
  //     }
  //   }).catchError((error) {
  //     if (kDebugMode) {
  //       print('Install error: $error');
  //     }
  //   });
  // }
}
