import 'package:balloon/game_controller.dart';
import 'package:balloon/res/app_constant.dart';
import 'package:balloon/utils/routes/routes.dart';
import 'package:balloon/utils/routes/routes_name.dart';
import 'package:balloon/view_model/amount_list_view_model.dart';
import 'package:balloon/view_model/withdraw_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view_model/add_bank_details_view_model.dart';
import 'view_model/auth_view_model.dart';
import 'view_model/bet_history_view_model.dart';
import 'view_model/bet_view_model.dart';
import 'view_model/deposit_history_view_model.dart';
import 'view_model/deposit_view_model.dart';
import 'view_model/profile_view_model.dart';
import 'view_model/services/splash_services.dart';
import 'view_model/top_win_view_model.dart';
import 'view_model/user_view_model.dart';
import 'view_model/view_bank_view_model.dart';
import 'view_model/withdraw_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GameController()),
          ChangeNotifierProvider(create: (_) => AmountListViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => BetHistoryViewModel()),
          ChangeNotifierProvider(create: (_) => BetViewModel()),
          ChangeNotifierProvider(create: (_) => TopWinViewModel()),
          ChangeNotifierProvider(create: (_) => AddBankDetailsViewModel()),
          ChangeNotifierProvider(create: (_) => WithdrawViewModel()),
          ChangeNotifierProvider(create: (_) => DepositViewModel()),
          ChangeNotifierProvider(create: (_) => ProfileViewModel()),
          ChangeNotifierProvider(create: (_) => SplashServices()),
          ChangeNotifierProvider(create: (_) => DepositHistoryViewModel()),
          ChangeNotifierProvider(create: (_) => WithdrawHistoryViewModel()),
          ChangeNotifierProvider(create: (_) => ViewBankViewModel()),

        ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: (settings) {
          if (settings.name != null) {
            return MaterialPageRoute(
              builder: Routers.generateRoute(settings.name!),
              settings: settings,
            );
          }
          return null;
        },
        // home:BalloonScreen()
      ),
    );
  }
}
double height=0.0;
double width=0.0;

