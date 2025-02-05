import 'package:balloon/game_controller.dart';
import 'package:balloon/model/amount_list_moodel.dart';
import 'package:balloon/repo/amount_list_repo.dart';
import 'package:flutter/foundation.dart';

class AmountListViewModel with ChangeNotifier {
  final _amountListRepo = AmountRepository();

  AmountModel? _amountResponse;
  AmountModel? get amountResponse => _amountResponse;

  setAmountListModel(AmountModel banner) {
    _amountResponse = banner;
    notifyListeners();
  }

  Future<void> amountListApi(context) async {
    GameController gameController =GameController();
    _amountListRepo.amountListApi().then((value) {
      if (value.status == 200) {
        setAmountListModel(value);
        print(amountResponse?.data?[0].amount.toString()??"");
        gameController.setMultipliedValue(double.parse(amountResponse?.data?[0].amount.toString()??""));
      } else {
        if (kDebugMode) {
          print('No Data');
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}