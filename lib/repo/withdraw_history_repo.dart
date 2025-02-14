import 'package:balloon/helper/network/base_api_services.dart';
import 'package:balloon/helper/network/network_api_services.dart';
import 'package:balloon/model/profile_model.dart';
import 'package:balloon/model/withdraw_history_model.dart';
import 'package:balloon/repo/api_url.dart';
import 'package:flutter/foundation.dart';

class WithdrawHistoryRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<WithdrawHistoryModel> withdrawHistoryApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.withdrawHistoryApi,data);
      return WithdrawHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode){
        print('Error occurred during withdrawHistoryApi: $e');
      }
      rethrow;
    }
  }

}