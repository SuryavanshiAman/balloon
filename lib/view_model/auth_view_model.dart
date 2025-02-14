import 'package:balloon/res/app_colors.dart';
import 'package:balloon/utils/routes/routes_name.dart';
import 'package:balloon/utils/utils.dart';
import 'package:balloon/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repo/auth_repo.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> authApi(dynamic data, context) async {
    final userPref = Provider.of<UserViewModel>(context, listen: false);
    setLoading(true);
    print(data);
    _authRepo.authApi(data).then((value) {
      if (value['status'] == true) {
        setLoading(false);
        print(value['id'].toString());
        print("value['id'].toString()");
        userPref.saveUser(value['id'].toString());
        Navigator.pushReplacementNamed(context, RoutesName.balloonScreen);
        Utils.setSnackBar(value['message'],AppColor.green, context);
      }
      else {
        setLoading(false);
        Navigator.pushNamed(context, RoutesName.registerScreen);
        Utils.setSnackBar(value['message'],AppColor.red, context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('loginApiError: $error');
      }
    });
  }

  Future<void> registerApi(dynamic data, context) async {
    final userPref = Provider.of<UserViewModel>(context, listen: false);
    setLoading(true);
    _authRepo.registerApi(data).then((value) {
      if (value['status'] == true) {
        setLoading(false);
        userPref.saveUser(value['user_id'].toString());
        Navigator.pushReplacementNamed(context, RoutesName.balloonScreen);
        Utils.setSnackBar(value['message'],AppColor.green ,context);
      }
      else {
        setLoading(false);
        Utils.setSnackBar(value['message'],AppColor.red, context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('registerApi: $error');
      }
    });
  }


}