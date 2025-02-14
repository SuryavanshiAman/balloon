
import 'package:balloon/generated/assets.dart';
import 'package:balloon/main.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/res/constantButton.dart';
import 'package:balloon/view_model/profile_view_model.dart';
import 'package:balloon/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'routes/routes_name.dart';

class Utils {

  static setSnackBar(String msg,Color color, BuildContext context) {
    showToastWidget(
      Container(
        margin: EdgeInsets.only(top: 30),
        width: width*0.8,
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:   Text(
          msg,
          style:  TextStyle(
            color:AppColor.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.slideToTop,
      position: StyledToastPosition.top,
      animDuration: const Duration(milliseconds: 300),
      duration: const Duration(seconds: 3),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  static showExitConfirmation(BuildContext context) async {
    return await showModalBottomSheet(
      elevation: 5,
      backgroundColor: AppColor.white,
      shape: const RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      context: context,
      builder: (context) {
        return Container(
          height: height * 0.4,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 28.0, top: 28),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppColor.white,
                    )),
              ),
              SizedBox(height: height / 30),
              const Center(
                child: Text("Exit App",
                    style: TextStyle(
                        color: AppColor.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: height * 0.02),
              const Center(
                child: Text("Are you sure want to exit app?",
                    style: TextStyle(
                        color: AppColor.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: height * 0.04),
              Center(
                child: SizedBox(
                  width: width * 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: constantbutton(
                        width: width*0.8,
                          onTap: (){  SystemNavigator.pop();}, text: "Yes")),
                      SizedBox(height: height * 0.03),
                      Center(child: constantbutton(
                          width: width*0.8,
                          onTap: (){Navigator.pop(context);}, text: "No")),

                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    ) ??
        false;
  }
  static Future<bool?> showLogOutConfirmation(BuildContext context) async {
    return await showModalBottomSheet(
      elevation: 5,
      backgroundColor: AppColor.white,
      shape: const RoundedRectangleBorder(
        // side: BorderSide(width: 2, color: Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust height dynamically
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 28.0, top: 28),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColor.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColor.lightBlue,
                  child: Image.asset(
                    Assets.imagesLogOut,
                    color: AppColor.blue,
                    scale: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "Logging out?",
                  style: TextStyle(
                    color: AppColor.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Are you sure you want to log out of this\naccount?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: constantbutton(
                    width: width*0.8,
                    onTap:( ){
                      UserViewModel userViewModel = UserViewModel();
                      userViewModel.remove();
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.pushReplacementNamed(
                          context, RoutesName.loginScreen);
                    }, text: "Yes, Logout"),
              ),
              const SizedBox(height: 16),
              Center(
                child: constantbutton(
                  width: width*0.8,
                    onTap:( ){
                  Navigator.pop(context, false);
                }, text: "Cancel"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
  static showProfilePopup(BuildContext context) {
    final profile=Provider.of<ProfileViewModel>(context, listen: false).profileResponse?.data;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profile?.image??""), // Replace with user profile image
                ),
                SizedBox(height: 10),

                // User Name
                Text(
                  profile?.name??"", // Replace with dynamic user name
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),

                // User Details
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        buildProfileRow("Total Withdrawal", "₹${profile?.bonus??"0.0"}"),
                        buildProfileRow("Total Deposit",  "₹${profile?.deposit??"0.0"}"),
                        buildProfileRow("Total Balance", "₹${profile?.wallet??"0.0"}"),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15),
                // Close Button
                constantbutton(onTap: (){Navigator.pop(context);}, text: "Close")

              ],
            ),
          ),
        );
      },
    );
  }

  static buildProfileRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
        ],
      ),
    );
  }
}
