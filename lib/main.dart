import 'package:balloon/game_controller.dart';
import 'package:balloon/res/app_constant.dart';
import 'package:balloon/view/game_screen.dart';
import 'package:balloon/view_model/amount_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

        ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
        home:BalloonScreen()
      ),
    );
  }
}
double height=0.0;
double width=0.0;

