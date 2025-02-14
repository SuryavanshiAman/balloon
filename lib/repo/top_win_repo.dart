import 'package:balloon/helper/network/base_api_services.dart';
import 'package:balloon/helper/network/network_api_services.dart';
import 'package:balloon/model/top_win_model.dart';
import 'package:balloon/repo/api_url.dart';
import 'package:flutter/foundation.dart';

class TopWinRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<TopWinModel> topWinApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.topWinApi);
      return TopWinModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during topWinApi: $e');
      }
      rethrow;
    }
  }}