import 'package:balloon/repo/api_url.dart';
import 'package:flutter/foundation.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class WithdrawRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> withdrawApi(dynamic data,) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.withdrawApi,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during withdrawApi: $e');
      }
      rethrow;
    }
  }
}