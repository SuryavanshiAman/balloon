import 'package:balloon/helper/network/base_api_services.dart';
import 'package:balloon/helper/network/network_api_services.dart';
import 'package:balloon/model/deposit_history_model.dart';
import 'package:balloon/repo/api_url.dart';
import 'package:flutter/foundation.dart';

class DepositHistoryRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<DepositHistoryModel> depositHistoryApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.depositApi,data);
      return DepositHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode){
        print('Error occurred during depositHistoryApi: $e');
      }
      rethrow;
    }
  }

}