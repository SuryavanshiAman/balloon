
import 'package:balloon/main.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/res/back_button.dart';
import 'package:balloon/res/circular_button.dart';
import 'package:balloon/res/constantButton.dart';
import 'package:balloon/utils/routes/routes_name.dart';
import 'package:balloon/utils/utils.dart';
import 'package:balloon/view_model/deposit_view_model.dart';
import 'package:balloon/view_model/profile_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key}) : super(key: key);

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {


  @override
  void initState() {

    super.initState();
  }

  String type = "1";
  Widget displayUpiApps() {
    return constantbutton(
        onTap: () {
          if (amount.text.isEmpty) {
            Utils.setSnackBar("Enter amount", AppColor.white, context);
          }
            else if(int.parse(amount.text) >= int.parse("100")){
              // addmony(context, amount.text, map['userids']);
            }else{
              Utils.setSnackBar(
                  "Minimum Recharge amount is 100", AppColor.white, context);

          }

        },
        text: "Add Cash");
  }

  // Widget displayTransactionData(title, body) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text("$title: ", style: header),
  //         Flexible(
  //             child: Text(
  //               body,
  //               style: value,
  //             )),
  //       ],
  //     ),
  //   );
  // }

  var wallet;

  TextEditingController amount = TextEditingController();
  int _selectedItemIndex =
  10; // Initialize with a value that won't match any index
  bool _isButtonEnabled = false;
  List<int> indianAmount = [100, 200,400, 500, 1000, 2000,4000,5000];
  void _handleTextChange() {
    setState(() {
      _selectedItemIndex = 10; // Reset selected index
      _isButtonEnabled = amount.text.isNotEmpty;
    });
  }

  void _handleListItemSelected(int index) {
    setState(() {
      _selectedItemIndex =  indianAmount[index];
      amount.text = indianAmount[index].toString(); // Update TextFormField text
      _isButtonEnabled = true;
    });
  }

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  bool _loading = false;
  var catogery;
  @override
  Widget build(BuildContext context) {
    final deposit =Provider.of<DepositViewModel>(context);
    final profile=Provider.of<ProfileViewModel>(context, listen: false).profileResponse?.data;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                // gradient: primaryGradient,
                color: AppColor.lightBlue)),
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
        centerTitle: true,
        title: Text(
          'Deposit',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: AppColor.black),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.depositHistoryScreen);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const Recharge_record()));
              },
              child: Text('History',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColor.black)))
        ],
      ),
      body:ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: 'BALANCE: ',
                style:  TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                      text:"₹${profile?.wallet.toString()??"0.0"}",
                      style: TextStyle(fontWeight: FontWeight.w500,color:AppColor.black,fontSize: 16)),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
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
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 130,
                            childAspectRatio: 3.5 / 1.5,
                            mainAxisSpacing: 5),
                        itemCount:  indianAmount.length,
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
                                      side:  BorderSide(
                                          color: AppColor.lightBlue),
                                      borderRadius:
                                      BorderRadius.circular(12)),
                                  color: _selectedItemIndex ==
                                      indianAmount[index]
                                      ? AppColor.lightBlue
                                      : AppColor.white,
                                  child: Center(
                                    child: Text('₹  ${indianAmount[index]}',
                                      style: TextStyle(
                                          color: _selectedItemIndex ==
                                              indianAmount[
                                              index]
                                              ? AppColor.white
                                              : AppColor.lightBlue,
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(25))),
                      child: TextField(
                        controller: amount,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: AppColor.black, fontWeight: FontWeight.w600),
                        onChanged: (text) {
                          _handleTextChange();
                        },
                        decoration: InputDecoration(
                          // filled: true,
                          //   fillColor:lightGray,
                            prefixIcon: SizedBox(
                              width: 70,
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Icon(
                                    type!="2"?
                                    Icons.currency_rupee:Icons.currency_exchange,
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
                            hintText: "Enter Amount",
                            helperStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade200),
                            border: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: AppColor.lightBlue),
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
            _loading == false
                ?constantbutton(
                onTap: () {
                  if (amount.text.isEmpty) {
                    Utils.setSnackBar("Enter amount", AppColor.white, context);
                  }
                  else if(int.parse(amount.text) >= int.parse("100")){
                    deposit.depositApi(amount.text,context);
                  }else{
                    Utils.setSnackBar(
                        "Minimum Recharge amount is 100", AppColor.white, context);

                  }

                },
                text: "Add Cash")
                : const CircularButton(),
            SizedBox(
              height: height * 0.03,
            ),
            const Center(
                child: Text(
                  "Minimum Recharge Amount is ₹100",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ])
          // : const Center(child: CircularProgressIndicator()),
    );
  }


}
