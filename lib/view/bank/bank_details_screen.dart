import 'dart:convert';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/res/back_button.dart';
import 'package:balloon/res/circular_button.dart';
import 'package:balloon/res/constantButton.dart';
import 'package:balloon/utils/utils.dart';
import 'package:balloon/view_model/add_bank_details_view_model.dart';
import 'package:balloon/view_model/view_bank_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

bool _loading = false;

class _BankDetailsState extends State<BankDetails> {
  TextEditingController account_no = TextEditingController();
  TextEditingController IFSC = TextEditingController();
  TextEditingController Bank_Name = TextEditingController();
  TextEditingController Ac_holder = TextEditingController();
  TextEditingController walletAdd = TextEditingController();
  String type = "1";
  @override
  void initState() {
    Provider.of<ViewBankViewModel>(context,listen: false).viewBankApi(context);
    // accountview();
    Acdetail();
    super.initState();
  }

  Acdetail() {
    final bank= Provider.of<ViewBankViewModel>(context,listen: false).bankData?.data;
    account_no.text = bank == null ? '' : bank.accountNum.toString();
    IFSC.text = bank == null ? '' : bank.ifscCode.toString();
    Bank_Name.text = bank == null ? '' : bank.bankName.toString();
    Ac_holder.text = bank == null ? '' : bank.name.toString();
  }


  bool _isValidIFSC = false;

  void validateIFSC(String ifsc) {
    RegExp ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

    setState(() {
      _isValidIFSC = ifscRegex.hasMatch(ifsc.toUpperCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    final addBank=Provider.of<AddBankDetailsViewModel>(context);
    return SafeArea(
        child: Scaffold(

          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColor.white,
            flexibleSpace: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(00),
                        bottomRight: Radius.circular(00)),
                    gradient: LinearGradient(
                        colors: [AppColor.lightBlue, AppColor.white],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter))),
            automaticallyImplyLeading: false,
            leading: const CustomBackButton(),
            centerTitle: true,
            title:  Text('BANK DETAILS',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: AppColor.black,
              ), ),
          ),
          body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(20),
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColor.lightBlue),
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child:ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  children: [
                    TextField(
                      controller: Ac_holder,
                      keyboardType: TextInputType.name,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: const TextStyle(color: AppColor.black),
                      cursorColor: const Color(0xFF075E54),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        counter: Offstage(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        hintText: "Enter A/c holder name",
                        hintStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: 15,
                        ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: account_no,
                      // focusNode: focusyear,
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: const TextStyle(color: AppColor.black),
                      cursorColor: const Color(0xFF075E54),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.account_balance,
                          color: AppColor.black,
                        ),
                        hintText: "Account NO",
                        hintStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: Bank_Name,
                      // focusNode: focusyear,
                      keyboardType: TextInputType.name,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: const TextStyle(color: AppColor.black),
                      cursorColor: const Color(0xFF075E54),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.account_balance_outlined,
                          color: AppColor.black,
                        ),
                        hintText: "Bank Name",
                        hintStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextField(
                    //   controller: Branch,
                    //   // focusNode: focusyear,
                    //   keyboardType: TextInputType.name,
                    //   textAlignVertical: TextAlignVertical.bottom,
                    //   style: const TextStyle(color: AppColor.black),
                    //   cursorColor: const Color(0xFF075E54),
                    //   decoration: const InputDecoration(
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(width: 1, color: Colors.black),
                    //     ),
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(
                    //         width: 1,
                    //       ),
                    //     ),
                    //     prefixIcon: Icon(
                    //       Icons.account_balance_sharp,
                    //       color: Colors.black,
                    //     ),
                    //     hintText: "Branch Name",
                    //     hintStyle: TextStyle(
                    //       color: AppColor.black,
                    //       fontSize: 15,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: IFSC,
                      // focusNode: focusyear,
                      onChanged: (value) {
                        validateIFSC(value.toUpperCase());
                      },
                      maxLength: 11,
                      keyboardType: TextInputType.name,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: const TextStyle(color: AppColor.black),
                      cursorColor: const Color(0xFF075E54),
                      decoration: const InputDecoration(
                        counter: Offstage(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.pin,
                          color: AppColor.black,
                        ),
                        hintText: "IFSC Code",
                        hintStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _loading == false
                        ? constantbutton(
                      text: 'UPDATE',
                      textColor: Colors.white,
                      onTap: () async {
                        // bool ifscValid = validateIFSC(IFSC.text);

                        if (_isValidIFSC) {
                          // If IFSC is valid, proceed with adding the account
                          // Addaccount(account_no.text, IFSC.text, Branch.text,
                          //     Bank_Name.text, Ac_holder.text);
                        } else {
                          Utils.setSnackBar(
                              "Please enter valid ifsc", AppColor.white,context);
                        }
                        print(IFSC.text);
                        addBank.addBankDetailsApi(Ac_holder.text, account_no.text,Bank_Name.text,IFSC.text, context);
                        // Addaccount(account_no.text, IFSC.text, Branch.text,
                        //     Bank_Name.text, Ac_holder.text);
                      },
                    )
                        : const CircularButton()
                  ],
                )

              )
            ],
          ),
        ));
  }

  // Addaccount(String account_no, String IFSC, String Branch, String Bank_Name,
  //     String Ac_holder) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userid = prefs.getString("userId");
  //   setState(() {
  //     _loading = true;
  //   });
  //
  //   final response = await http.post(
  //     Uri.parse(ApiConst.addAccount),
  //     // headers: <String, String>{
  //     //   'Content-Type': 'application/json; charset=UTF-8',
  //     // },
  //     body: jsonEncode(<String, String>{
  //       "name": Ac_holder,
  //       "accountno": account_no,
  //       "ifsc": IFSC,
  //       "bankname": Bank_Name,
  //       "branch": Branch,
  //       "userid": '${userid}',
  //       "type":type,
  //     }),
  //   );
  //
  //   var data = jsonDecode(response.body);
  //
  //   if (data["status"] == "200") {
  //     final prefs2 = await SharedPreferences.getInstance();
  //     final key1 = 'acId';
  //     final acId = data['id'].toString();
  //     prefs2.setString(key1, acId);
  //     setState(() {
  //       _loading = false;
  //     });
  //     Navigator.pop(context);
  //     Utils.flushBarSuccessMessage(data['msg'], context, black);
  //   } else {
  //     setState(() {
  //       _loading = false;
  //     });
  //     Utils.flushBarErrorMessage(data['msg'], context, black);
  //     print("Error");
  //   }
  // }
  // walletAddress(String walletAdd ) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userid = prefs.getString("userId");
  //   setState(() {
  //     _loading = true;
  //   });
  //
  //   final response = await http.post(
  //     Uri.parse(ApiConst.usdt),
  //     body: jsonEncode(<String, String>{
  //       "usdt_address": walletAdd,
  //       "userid": '${userid}',
  //       "type":type,
  //     }),
  //   );
  //
  //   var data = jsonDecode(response.body);
  //
  //   if (data["status"] == "200") {
  //     // final prefs2 = await SharedPreferences.getInstance();
  //     // final key1 = 'acId';
  //     // final acId = data['id'].toString();
  //     // prefs2.setString(key1, acId);
  //     setState(() {
  //       _loading = false;
  //     });
  //     Navigator.pop(context);
  //     Utils.flushBarSuccessMessage(data['msg'], context, black);
  //   } else {
  //     setState(() {
  //       _loading = false;
  //     });
  //     Utils.flushBarErrorMessage(data['msg'], context, black);
  //     print("Error");
  //   }
  // }
}
