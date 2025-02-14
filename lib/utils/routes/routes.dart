
import 'package:balloon/res/text_widget.dart';
import 'package:balloon/view/auth/login_screen.dart';
import 'package:balloon/view/auth/register_screen.dart';
import 'package:balloon/view/auth/splash_screen.dart';
import 'package:balloon/view/bank/bank_details_screen.dart';
import 'package:balloon/view/deposit/deposit_history_screen.dart';
import 'package:balloon/view/deposit/deposit_screen.dart';
import 'package:balloon/view/game_screen.dart';
import 'package:balloon/view/profile/profile_screen.dart';
import 'package:balloon/view/withdraw/withdra_history.dart';
import 'package:balloon/view/withdraw/withdraw_screen.dart';
import 'package:flutter/material.dart';

import 'routes_name.dart';

class Routers {
  static WidgetBuilder generateRoute(String routeName) {
    switch (routeName) {
      case RoutesName.splashScreen:
        return (context) => const SplashScreen();
      case RoutesName.loginScreen:
        return (context) => const LoginScreen();
      case RoutesName.registerScreen:
        return (context) => const RegisterScreen();
      case RoutesName.balloonScreen:
        return (context) => const BalloonScreen();
      case RoutesName.bankDetails:
        return (context) => const BankDetails();
      case RoutesName.profileScreen:
        return (context) =>  ProfileScreen();
      case RoutesName.depositScreen:
        return (context) =>  DepositScreen();
      case RoutesName.withdrawScreen:
        return (context) => WithdrawPage();

      case RoutesName.withdrawHistoryScreen:
        return (context) => WithdrawHistory ();
      case RoutesName.depositHistoryScreen:
        return (context) => DepositHistoryScreen ();
      // case RoutesName.transactionHistoryScreen:
      //   return (context) =>  TransactionHistoryScreen();
      // case RoutesName.gameHistoryScreen:
      //   return (context) =>  GameHistoryScreen();
      // case RoutesName.giftScreen:
      //   return (context) =>  GiftScreen();
      // case RoutesName.changeLoginPasswordScreen:
      //   return (context) =>  ChangeLoginPasswordScreen();
      // case RoutesName.aboutUsScreen:
      //   return (context) =>  AboutUsScreen();
      // case RoutesName.feedBackScreen:
      //   return (context) =>  FeedBackScreen();
      // case RoutesName.nickNameScreen:
      //   return (context) =>  NickNameScreen();
      // case RoutesName.changeAvtar:
      //   return (context) =>  ChangeAvtar();
      // case RoutesName.commonAboutPage:
      //   return (context) =>  CommonAboutPage();
      // case RoutesName.chooseBankScreen:
      //   return (context) =>  ChooseBankScreen();
      default:
        return (context) => Scaffold(
          body: Center(
            child: textWidget(
                text: 'No Route Found!',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        );
    }
  }
}
