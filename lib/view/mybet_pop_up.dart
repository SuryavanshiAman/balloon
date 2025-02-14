import 'package:balloon/main.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/view_model/bet_history_view_model.dart';
import 'package:balloon/view_model/top_win_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void showMyBetsPopup(BuildContext context) {
 final betHistory= Provider.of<BetHistoryViewModel>(context, listen: false).giftHistoryData;

  List<Map<String, String>> bets = [
    {"amount": "0.50", "date": "05.02.25", "reward": "0DMO"},
    {"amount": "0.10", "date": "05.02.25", "reward": "0DMO"},
    {"amount": "50.00", "date": "04.02.25", "reward": "63DMO"},
    {"amount": "50.00", "date": "04.02.25", "reward": "57DMO"},
    {"amount": "5.00", "date": "04.02.25", "reward": "6.25DMO"},
    {"amount": "5.00", "date": "04.02.25", "reward": "5.75DMO"},
    {"amount": "0.10", "date": "04.02.25", "reward": "0.13DMO"},
    {"amount": "0.10", "date": "04.02.25", "reward": "0DMO"},
    {"amount": "0.10", "date": "04.02.25", "reward": "0.13DMO"},
    {"amount": "0.10", "date": "04.02.25", "reward": "0.16DMO"},
  ];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.blue.shade400,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.star, color: Colors.white),
                    Text(
                      "MY BETS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "SitkaSmall",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Bets List
             betHistory!=null&& betHistory.data!.isNotEmpty?  Container(
                height: 400,
                child: ListView.builder(
                  itemCount: betHistory?.data?.length??1,
                  itemBuilder: (context, index) {
                    final data=betHistory?.data?[index];
                    return betHistory!.data!.isNotEmpty? Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade500,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data?.betAmount.toString()??"",
                            style: TextStyle(color: Colors.white,fontFamily: "SitkaSmall", fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                          Text(
                          DateFormat('HH:mm:ss').format(DateTime.parse(data?.createdAt.toString()??""))
                          // DateFormat('HH:mm:ss').format( (data?.createdAt.toString()??""))
                           ,
                            style: TextStyle(color: AppColor.blue,fontWeight: FontWeight.w900,fontFamily: "SitkaSmall", fontSize: 14),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: width*0.3,
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(0xff037be1),
                              border: Border.all(color: AppColor.blue,width: 2),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Text(
                    data?.winningAmount.toString()??"",
                              style: TextStyle(color: Colors.yellow,fontFamily: "SitkaSmall", fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ):Text("No Data Found", style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: "SitkaSmall",
                      fontWeight: FontWeight.bold,
                    ),);
                  },
                ),
              )
                  :Text("No Data Found....", style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "SitkaSmall",
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ),
      );
    },
  );
}
void topWinPopup(BuildContext context) {
  final topWin= Provider.of<TopWinViewModel>(context, listen: false).topWinData;
  List<Map<String, String>> bets = [
    {"name":"aman","amount": "0.50", "date": "05.02.25", "reward": "0DMO"},
    {"name":"aman","amount": "0.10", "date": "05.02.25", "reward": "0DMO"},
    {"name":"aman","amount": "50.00", "date": "04.02.25", "reward": "63DMO"},
    {"name":"aman","amount": "50.00", "date": "04.02.25", "reward": "57DMO"},
    {"name":"aman","amount": "5.00", "date": "04.02.25", "reward": "6.25DMO"},
    {"name":"aman","amount": "5.00", "date": "04.02.25", "reward": "5.75DMO"},
    {"name":"aman","amount": "0.10", "date": "04.02.25", "reward": "0.13DMO"},
    {"name":"aman","amount": "0.10", "date": "04.02.25", "reward": "0DMO"},
    {"name":"aman","amount": "0.10", "date": "04.02.25", "reward": "0.13DMO"},
    {"name":"aman","amount": "0.10", "date": "04.02.25", "reward": "0.16DMO"},
  ];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          // width: 400,
          decoration: BoxDecoration(
            color: Colors.blue.shade400,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon(Icons.wine_bar, color: Colors.white),
                    Text(
                      "🏆",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        fontFamily: "SitkaSmall"
                      ),
                    ),
                    Text(
                      "TOP WIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "SitkaSmall",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Bets List
              Container(
                height: 400,
                child: ListView.builder(
                  itemCount: topWin?.data?.length??0,
                  itemBuilder: (context, index) {
                    final data=topWin?.data?[index];
                    return topWin!.data!.isNotEmpty? Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade500,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data?.name.toString()??"",
                            style: TextStyle(color: Colors.white,fontFamily: "SitkaSmall", fontSize: 14, ),
                          ),
                          Text(
                            DateFormat('HH:mm:ss').format(DateTime.parse( data?.createdAt.toString()??""))
                            // DateFormat('HH:mm:ss').format( (data?.createdAt.toString()??""))
                            ,
                            style: TextStyle(color: AppColor.blue,fontWeight: FontWeight.w900,fontFamily: "SitkaSmall", fontSize: 14),
                          ),
                          Text(
                            data?.betAmount.toString()??"",
                            style: TextStyle(color: Colors.white, fontSize: 14,fontFamily: "SitkaSmall", fontWeight: FontWeight.w900),
                          ),

                          Container(
                            alignment: Alignment.center,
                            width: width*0.2,
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                            decoration: BoxDecoration(
                              color: Color(0xff037be1),
                              border: Border.all(color: AppColor.blue,width: 1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Text(
                              data?.winningAmount.toString()??"",
                              style: TextStyle(color: Colors.yellow,fontFamily: "SitkaSmall", fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ):Text("No Data Found");
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
