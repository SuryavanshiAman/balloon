


import 'package:balloon/helper/network/base_api_services.dart';
import 'package:balloon/helper/network/network_api_services.dart';
import 'package:balloon/model/amount_list_moodel.dart';
import 'package:balloon/repo/api_url.dart';
import 'package:flutter/foundation.dart';

class AmountRepository{
  final BaseApiServices _apiServices=NetworkApiServices();
  Future<AmountModel> amountListApi() async{
    try{
      dynamic response =await _apiServices.getGetApiResponse(ApiUrl.amountListApi);
      return AmountModel.fromJson(response);
    } catch (e){
      if (kDebugMode) {
        print('Error occurred during amountListApi: $e');
      }
      rethrow;
    }
    }
  }
