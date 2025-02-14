import 'package:balloon/main.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/res/constantButton.dart';
import 'package:balloon/res/custom_text_field.dart';
import 'package:balloon/utils/routes/routes_name.dart';
import 'package:balloon/utils/utils.dart';
import 'package:balloon/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  // String _selectedCountryCode = '+91';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _passwordVisible = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<AuthViewModel>(context);
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      children: [
        SizedBox(
          height: height * 0.025,
        ),
        Row(
          children: [
            // SvgPicture.asset(Assets.svgEmail,
            //     height: height * 0.04,
            //     colorFilter: ColorFilter.mode(
            //       AppColor.white, // Apply the color here
            //       BlendMode.srcIn,
            //     )),
            Icon(Icons.mail),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              "Email/Account Log in",
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 16,
                  fontFamily: "SitkaSmall",
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        SizedBox(
          height: height * 0.015,
        ),
        CustomTextField(
          controller: _emailController,
          label: "Enter your email",
          hintColor: AppColor.lightGray,
          hintSize: 16,
          height: 55,
          borderSide: BorderSide(color: Colors.white),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: width * 0.65,
          filled: true,
          fillColor: AppColor.white,
          border: Border.all(color: AppColor.lightBlue.withOpacity(0.3)),
          // border: Border.all(color: AppColor.gray.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(15),
          fieldRadius: BorderRadius.circular(15),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9._%+-@]*$')), // Allows only valid email characters
          ],
        ),
        SizedBox(
          height: height * 0.035,
        ),
        Row(
          children: [
            // SvgPicture.asset(Assets.svgPassword,
            //     height: height * 0.04,
            //     colorFilter: ColorFilter.mode(
            //       AppColor.white, // Apply the color here
            //       BlendMode.srcIn,
            //     )),
            Icon(Icons.lock),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              "Password",
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 16,
                  fontFamily: "SitkaSmall",
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
        CustomTextField(
          controller: _passController,
          label: "Password",
          hintColor: AppColor.lightGray,
          hintSize: 16,
          maxLines: 1,
          obscureText: !_passwordVisible,
          height: 55,
          borderSide: BorderSide(color: Colors.white),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          // width: width*0.65,
          maxLength: 10,
          filled: true,
          fillColor: AppColor.white,
          border: Border.all(color: AppColor.lightBlue.withOpacity(0.3)),
          // border: Border.all(color: AppColor.gray.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(15),
          fieldRadius: BorderRadius.circular(15),
          suffix: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        SizedBox(
          height: height * 0.04,
        ),
        // login.loading==false?
        constantbutton(
          width: width,
          onTap: () {
            if (_emailController.text.isEmpty) {
              Utils.setSnackBar("Please enter Email.",AppColor.red, context);
            } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(_emailController.text)) {
              Utils.setSnackBar("You can only enter mail here",AppColor.red, context);
            }
            else if (_passController.text.isEmpty) {
              Utils.setSnackBar("Please enter your password",AppColor.red, context);
            } else if (_passController.text.length < 6) {
              Utils.setSnackBar(
                  "The password must be at least 6 digits long.",AppColor.red, context);
            } else {
               Map data = {
            "mobile_or_email": _emailController.text,
            "password": _passController.text
            };
            login.authApi(data, context);
            }
          },
          text: 'Login',
        ),
        // CircularButton(),
        SizedBox(
          height: height * 0.03,
        ),
        constantbutton(
          width: width,
          onTap: () {
            Navigator.pushNamed(context, RoutesName.registerScreen);
          },
          text: 'Register',
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.lock),
                // SvgPicture.asset(Assets.svgPassword,
                //     height: height * 0.05,
                //     colorFilter: ColorFilter.mode(
                //       AppColor.white, // Apply the color here
                //       BlendMode.srcIn,
                //     )),
                Text(
                  "Forgot password",
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontFamily: "SitkaSmall",
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Column(
              children: [
                // SvgPicture.asset(Assets.svgCustomer,
                //     height: height * 0.05,
                //     colorFilter: ColorFilter.mode(
                //       AppColor.white, // Apply the color here
                //       BlendMode.color,
                //     )),
                Icon(Icons.support_agent_outlined),
                Text(
                  "Customer service",
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontFamily: "SitkaSmall",
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
