import 'package:balloon/helper/network/base_api_services.dart';
import 'package:balloon/helper/network/network_api_services.dart';
import 'package:balloon/model/view_bank_model.dart';
import 'package:balloon/repo/api_url.dart';
import 'package:flutter/foundation.dart';

class ViewBankRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<BankViewModel> viewBankApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.accountViewApi,data);
      return BankViewModel.fromJson(response);
    } catch (e) {
      if (kDebugMode){
        print('Error occurred during viewBankApi: $e');
      }
      rethrow;
    }
  }

}