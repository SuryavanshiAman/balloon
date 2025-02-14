import 'package:balloon/repo/api_url.dart';
import 'package:flutter/foundation.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getProfileApi(dynamic data) async {
    try {
      dynamic response = await _apiServices
          .getPostApiResponse(ApiUrl.profileApi, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during getProfileApi: $e');
      }
      rethrow;
    }
  }
}