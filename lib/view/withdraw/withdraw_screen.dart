
import 'package:balloon/main.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/res/back_button.dart';
import 'package:balloon/res/circular_button.dart';
import 'package:balloon/res/constantButton.dart';
import 'package:balloon/utils/routes/routes_name.dart';
import 'package:balloon/utils/utils.dart';
import 'package:balloon/view_model/withdraw_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  TextEditingController amount = TextEditingController();
  TextEditingController password = TextEditingController();
  int _selectedItemIndex = 10; // Initialize with a value that won't match any index
  bool _isButtonEnabled = false;
  List<int> indianAmount = [200, 500, 800, 1100, 1400, 1700, 2000];
  void _handleTextChange() {
    setState(() {
      _selectedItemIndex = 10; // Reset selected index
      _isButtonEnabled = amount.text.isNotEmpty;
    });
  }

  void _handleListItemSelected(int index) {
    setState(() {
      _selectedItemIndex =indianAmount[index];
      amount.text =indianAmount[index].toString();  // Update TextFormField text
      _isButtonEnabled = true;
    });
  }
  TextEditingController Bank_Name = TextEditingController();
  TextEditingController UPI = TextEditingController();
  TextEditingController Ac_holder = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  var userData;
  bool _passwordVisible = false;
  var Account;
  var walletview;
  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final withdraw= Provider.of<WithdrawViewModel>(context);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                    gradient: LinearGradient(
                        colors: [AppColor.lightBlue, AppColor.white],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter))),
            automaticallyImplyLeading: false,
            leading: const CustomBackButton(),
            centerTitle: true,
            title: Text(
              'WITHDRAWAL',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900, color: AppColor.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.withdrawHistoryScreen);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => const withdrawlrecord()));
                  },
                  child: Text('History',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: AppColor.black)))
            ],
          ),
          body: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'BALANCE : ',
                      style: TextStyle(fontWeight: FontWeight.w500,color: AppColor.black,fontSize: 20),
                    ),
                    Text(
                      userData == null ?"0.0":
                      double.parse(userData['wallet']).toStringAsFixed(2) ,
                      style: TextStyle(fontWeight: FontWeight.w500,color:AppColor.black,fontSize: 16),
                    ),
                    Container(
                      height: 15,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.lightBlue,
                      ),
                      child: const Center(
                          child: Text(
                            'ALL',
                            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Card(
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.lightBlue),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 130,
                                childAspectRatio: 3.5 / 1.5,
                                mainAxisSpacing: 5),
                            itemCount: indianAmount.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  _handleListItemSelected(index);
                                },
                                child: Stack(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: AppColor.lightBlue),
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      color: _selectedItemIndex ==
                                          indianAmount[index]
                                          ? AppColor.lightBlue
                                          : AppColor.white,
                                      child: Center(
                                        child: Text('₹  ${indianAmount[index]}',
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 5,
                                        right: 5,
                                        child: _selectedItemIndex ==
                                            indianAmount[index]
                                            ? Container(
                                          height: 12,
                                          width: 12,
                                          child: const CircleAvatar(
                                            child: Icon(
                                              Icons.check_outlined,
                                              size: 10,
                                            ),
                                          ),
                                        )
                                            : Container()),
                                  ],
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25))),
                          child: TextField(
                            controller: amount,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: AppColor.black),
                            onChanged: (text) {
                              _handleTextChange();
                            },
                            decoration: InputDecoration(
                                prefixIcon: SizedBox(
                                  width: 70,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.currency_rupee,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                          height: 30,
                                          color: Colors.grey,
                                          width: 2)
                                    ],
                                  ),
                                ),
                                hintText: "Enter Withdraw Amount",
                                helperStyle:
                                TextStyle(fontSize: 10, color: Colors.grey.shade200),
                                border:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColor.lightBlue),
                                  borderRadius: BorderRadius.circular(25),
                                )),
                            cursorColor: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25))),
                          child: TextField(
                            controller: password,
                            textAlign: TextAlign.start,
                            obscureText: !_passwordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(color: AppColor.black),
                            decoration: InputDecoration(
                                prefixIcon: SizedBox(
                                  width: 70,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.password,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                          height: 30,
                                          color: Colors.grey,
                                          width: 2)
                                    ],
                                  ),

                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                hintText: "Enter Password",
                                helperStyle:
                                TextStyle(fontSize: 10, color: Colors.grey.shade200),
                                border:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25),
                                )),
                            cursorColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                loading==false
                    ? constantbutton(
                    onTap: () {
                      if(amount.text.isEmpty){
                        Utils.setSnackBar("Enter Amount",AppColor.red, context);
                      }else if(password.text.isEmpty){
                        Utils.setSnackBar("Enter Password ",AppColor.red, context);
                      }else{
                        withdraw.withdrawApi(amount.text, context);
                      }

                    },
                    text: 'WITHDRAL REQUEST')
                    : const CircularButton(),
                SizedBox(
                  height: height * 0.03,
                ),
                const Center(
                    child: Text(
                      "Minimum Withdrawal Amount is ₹300",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))

              ]),
        ));
  }
  bool loading = false;


}
