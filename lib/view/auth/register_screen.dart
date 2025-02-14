import 'package:balloon/main.dart';
import 'package:balloon/res/constantButton.dart';
import 'package:balloon/res/custom_text_field.dart';
import 'package:balloon/utils/utils.dart';
import 'package:balloon/view_model/auth_view_model.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _selectedCountryCode = '+91';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _inviteController = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordVisibleTwo = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final register=Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      // backgroundColor: AppColor.black,
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(image: AssetImage(Assets.imagesBg),fit: BoxFit.fill)
        ),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(8),
          children: [
            SizedBox(height: height*0.1,),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Sign up ",
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
              "Welcome Let's create your account ",
              style: TextStyle(
                  color: AppColor.lightGray,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: "SitkaSmall"),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height*0.02,),
            // SvgPicture.asset(Assets.svgPhone,
            //     height: height*0.05,
            //     colorFilter: ColorFilter.mode(
            //       AppColor.white, // Apply the color here
            //       BlendMode.srcIn,
            //     )),
            Icon(Icons.phone_android),
        SizedBox(height: height*0.01,),
        Center(
          child: Text(
            "Register your phone",
            style: TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: "SitkaSmall"),),
        ),
            Container(
              width: width,
              margin: EdgeInsets.only(top: 2),
              height: 2,
              decoration: BoxDecoration(
                  gradient:   LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColor.lightBlue,
                      AppColor.white,
                      AppColor.lightBlue,
                      // Color(0xFFE3BE46),
                      AppColor.white,
                      AppColor.lightBlue
                    ],
                  ),
              ),
            ),
            SizedBox(height: height*0.02,),
            Row(
              children: [
                // SvgPicture.asset(Assets.svgEmail,
                //     height: height*0.04,
                //     colorFilter: ColorFilter.mode(
                //       AppColor.white, // Apply the color here
                //       BlendMode.srcIn,
                //     )),
                Icon(Icons.person),
                SizedBox(
                  width: width * 0.03,
                ),
                Text(
                  "Name",
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
              controller: _nameController,
              label: "Enter your name",
              hintColor: AppColor.lightGray,
              hintSize: 16,
              height: 55,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              filled: true,
              borderSide: BorderSide(color: Colors.white),
              fillColor: AppColor.white,
              border: Border.all(color: AppColor.lightBlue.withOpacity(0.3)),
              // border: Border.all(color: AppColor.gray.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(15),
              fieldRadius: BorderRadius.circular(15),
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Row(
              children: [
                // SvgPicture.asset(Assets.svgPhone,
                //     height: height*0.04,
                //     colorFilter: ColorFilter.mode(
                //       AppColor.white, // Apply the color here
                //       BlendMode.srcIn,
                //     )),
                Icon(Icons.phone_android),
                SizedBox(
                  width: width * 0.03,
                ),
                Text(
                  "Phone number",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.29,
                  height: height*0.07,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.lightBlue.withOpacity(0.3)),

                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: CountryCodePicker(
                      onChanged: (countryCode) {
                        setState(() {
                          _selectedCountryCode = countryCode.dialCode!;
                        });
                      },
                      initialSelection: 'IN', // Default selection (India)
                      showCountryOnly: false, // Show both country and code
                      showFlag: false, // Display country flag
                      showFlagDialog: true,
                      showDropDownButton: true,
                      dialogSize: Size(350, 300),
                      boxDecoration: BoxDecoration(
                        // color: AppColor.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:Colors.transparent,
                            blurRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: AppColor.lightGray),
                      // Option to show flag in the dialog
                    ),
                  ),
                ),
                CustomTextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  label: "Enter your phone number",

                  hintColor: AppColor.lightGray,
                  hintSize: 16,
                  height: 55,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  width: width * 0.65,
                  maxLength: 10,
                  filled: true,
                  borderSide: BorderSide(color: Colors.white),
                  fillColor: AppColor.white,
                  border: Border.all(color: AppColor.lightBlue.withOpacity(0.3)),
                  // border: Border.all(color: AppColor.gray.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                  fieldRadius: BorderRadius.circular(15),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Row(
              children: [
                // SvgPicture.asset(Assets.svgEmail,
                //     height: height*0.04,
                //     colorFilter: ColorFilter.mode(
                //       AppColor.white, // Apply the color here
                //       BlendMode.srcIn,
                //     )),
                Icon(Icons.email),
                SizedBox(
                  width: width * 0.03,
                ),
                Text(
                  "Email",
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
              controller: _mailController,
              label: "Enter your email",
              hintColor: AppColor.lightGray,
              hintSize: 16,
              height: 55,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              filled: true,
              borderSide: BorderSide(color: Colors.white),
              fillColor: AppColor.white,
              border: Border.all(color: AppColor.lightBlue.withOpacity(0.3)),
              // border: Border.all(color: AppColor.gray.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(15),
              fieldRadius: BorderRadius.circular(15),
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Row(
              children: [
                // SvgPicture.asset(Assets.svgPassword,
                //     height: height*0.04,
                //     colorFilter: ColorFilter.mode(
                //       AppColor.white, // Apply the color here
                //       BlendMode.srcIn,
                //     )),
                Icon(Icons.lock),
                SizedBox(
                  width: width * 0.03,
                ),
                Text(
                  "Set password",
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontFamily: "SitkaSmall",
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.015,
            ),
            CustomTextField(
              controller: _passController,
              label: "Set password",
              hintColor: AppColor.lightGray,
              hintSize: 16,
              maxLines: 1,
              obscureText: !_passwordVisible,
              height: 55,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              // width: width*0.65,
              maxLength: 10,
              filled: true,
              borderSide: BorderSide(color: Colors.white),
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
              height: height * 0.035,
            ),
            Row(
              children: [
                // SvgPicture.asset(Assets.svgPassword,
                //     height: height*0.04,
                //     colorFilter: ColorFilter.mode(
                //       AppColor.white, // Apply the color here
                //       BlendMode.srcIn,
                //     )),
                Icon(Icons.lock),
                SizedBox(
                  width: width * 0.03,
                ),
                Text(
                  "Confirm password",
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontFamily: "SitkaSmall",
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.015,
            ),
            CustomTextField(
              controller: _confirmPassController,
              label: "Confirm password",
              hintColor: AppColor.lightGray,
              hintSize: 16,
              maxLines: 1,
              obscureText: !_passwordVisibleTwo,
              height: 55,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              // width: width*0.65,
              maxLength: 10,
              filled: true,
              borderSide: BorderSide(color: Colors.white),
              fillColor: AppColor.white,
              border: Border.all(color: AppColor.lightBlue.withOpacity(0.3)),
              // border: Border.all(color: AppColor.gray.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(15),
              fieldRadius: BorderRadius.circular(15),
              suffix: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisibleTwo ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisibleTwo = !_passwordVisibleTwo;
                  });
                },
              ),
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Row(
              children: [
                // SvgPicture.asset(Assets.svgInvitionCode,
                //     height: height*0.04,
                //     colorFilter: ColorFilter.mode(
                //       AppColor.white, // Apply the color here
                //       BlendMode.srcIn,
                //     )),
                Icon(Icons.card_giftcard),
                SizedBox(
                  width: width * 0.03,
                ),
                Text(
                  "Invite code",
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontFamily: "SitkaSmall",
                      fontWeight: FontWeight.w600),
                ),

              ],
            ),
            SizedBox(
              height: height * 0.015,
            ),
            CustomTextField(
              controller: _inviteController,
              label: "Enter invitation code",
              hintColor: AppColor.lightGray,
              hintSize: 16,
              maxLines: 1,
              obscureText: !_passwordVisible,
              height: 55,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              // width: width*0.65,
              maxLength: 10,
              filled: true,
              borderSide: BorderSide(color: Colors.white),
              fillColor: AppColor.white,
              border: Border.all(color: AppColor.lightBlue.withOpacity(0.3)),
              // border: Border.all(color: AppColor.gray.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(15),
              fieldRadius: BorderRadius.circular(15),
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.gray, width: 2),
                      color: isChecked ? Colors.green : null,
                    ),
                    child: isChecked
                        ? Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    )
                        : null,
                  ),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                // Text(
                //   "I have read and agree",
                //   style: TextStyle(
                //       color: AppColor.white,
                //       fontSize: 14,
                //       fontFamily: "SitkaSmall",
                //       fontWeight: FontWeight.w300),
                // ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    children: [
                      TextSpan(
                          text: "I have read and agree ",
                          style: TextStyle(color: AppColor.black)),
                      TextSpan(
                        text: '⟬Privacy Agreement⟭',
                        style: TextStyle(
                          color: AppColor.red,
                          fontWeight: FontWeight.w600,
                          // decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigator.pushNamed(
                            //     context, RoutesName.registerScreen);
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.035,
            ),
            // register.loading==false?
            constantbutton(onTap: () {
              if (_phoneController.text.isEmpty){
                Utils.setSnackBar("Please enter your phone number ",AppColor.red, context);
              } else if(_phoneController.text.length<10){
                Utils.setSnackBar("Please enter proper phone number ",AppColor.red, context);
              } else if (_mailController.text.isEmpty){
                Utils.setSnackBar("Please enter your email",AppColor.red, context);
              } else if (
              _passController.text.isEmpty
              ){
                Utils.setSnackBar("Password must ",AppColor.red, context);
              }  else if (
              _passController.text.length<6
              ){
                Utils.setSnackBar("The password must be at least 6 digits long.",AppColor.red, context);
              }
              else if (_confirmPassController.text.isEmpty){
                Utils.setSnackBar("Re-enter  your password",AppColor.red, context);
              }  else if (_passController.text!=_confirmPassController.text){
                Utils.setSnackBar("Your password is not same",AppColor.red, context);
              }
              else if (!isChecked){
                Utils.setSnackBar("Please agree privacy agreement",AppColor.red, context);
              }
              else{
                Map data={
                "name": _nameController.text,
                  "email":_mailController.text,
                  "mobile":_phoneController.text,
                  "password": _passController.text,
                  "confirm_password": _confirmPassController.text,
                  "referralcode": _inviteController.text
                };
                register.registerApi(data, context);
              }
            }, text: 'Register',),
                // :CircularButton(),
            SizedBox(
              height: height * 0.02,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(
                      text: "I have an account ",
                      style: TextStyle(color: AppColor.black)),
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(
                      color: AppColor.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      // decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                      Navigator.pop(context);
                        // Navigator.pushNamed(
                        //     context, RoutesName.registerScreen);
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
