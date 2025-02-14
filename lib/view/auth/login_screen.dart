import 'package:balloon/generated/assets.dart';
import 'package:balloon/main.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:flutter/material.dart';

import 'tab_page/email_login.dart';
import 'tab_page/phone_number_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Container(
          decoration: BoxDecoration(
              // image: DecorationImage(image: AssetImage("assets/images/login_bg.png"),fit: BoxFit.fill)
          ),
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(height: height*0.1,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Welcome Back!",
                      style: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          fontFamily: "SitkaSmall"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: height*0.02,),
                  Text(
                    "Please sign in to your account",
                    style: TextStyle(
                        color: AppColor.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: "SitkaSmall"),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    decoration: BoxDecoration(
                    //   gradient: LinearGradient(colors: [
                    //     AppColor.lightBlue,
                    //     AppColor.white,
                    //   ],
                    //   begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter
                    //   ),
                    //     color:AppColor.lightBlue
                    ),
                    height: height*0.1,
                    width: width,
                    child: TabBar(
                      // indicator: UnderlineTabIndicator(
                      //   borderSide: BorderSide(color: Colors.amber, width: 2),
                      //   // insets: EdgeInsets.symmetric(horizontal: 20),
                      // ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3,
                      indicatorColor: AppColor.blue,
                      labelColor:AppColor.black,
                      unselectedLabelColor:AppColor.black,
                      labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "SitkaSmall" ),
                      tabs: [
                        Tab(
                          icon: Icon(Icons.phone_android),
                          child: const Text(
                            "Phone Number",
                            // style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Tab(
                          icon: Icon(Icons.email,),
                          child: const Text(
                            "Email / Account",
                            // style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height,
                    width: width,
                    child: TabBarView(
                      children: [
                        PhoneNumberLogin(),
                        EmailLogin()
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
