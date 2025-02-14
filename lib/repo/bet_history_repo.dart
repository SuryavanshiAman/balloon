import 'package:balloon/helper/network/base_api_services.dart';
import 'package:balloon/helper/network/network_api_services.dart';
import 'package:balloon/model/bet_history_model.dart';
import 'package:balloon/repo/api_url.dart';
import 'package:flutter/foundation.dart';

class BetHistoryRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<BetHistoryModel> betHistoryApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.betHistoryApi,data);
      return BetHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode){
        print('Error occurred during betHistoryApi: $e');
      }
      rethrow;
    }
  }

}