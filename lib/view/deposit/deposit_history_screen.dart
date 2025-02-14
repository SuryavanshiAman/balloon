import 'dart:convert';
import 'package:balloon/main.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:balloon/res/back_button.dart';
import 'package:balloon/view_model/deposit_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DepositHistoryViewModel>(context, listen: false)
        .depositHistoryApi(context);
  }

  @override
  Widget build(BuildContext context) {
    final DepositHistory = Provider
        .of<DepositHistoryViewModel>(context)
        .depositHistoryData;
    final data = DepositHistory?.data;
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                    gradient: LinearGradient(
                        colors: [AppColor.lightBlue, AppColor.white],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    )
                )
            ),
            automaticallyImplyLeading: false,
            leading: CustomBackButton(),
            centerTitle: true,
            title: Text('DEPOSIT HISTORY',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: AppColor.black,
              ),)
        ),
        body:data != null && data.isNotEmpty? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(

                itemCount: data?.length ?? 0,
                itemBuilder: (BuildContext ctx, index) {
                  final deposit = data?[index];
                  return Card(elevation: 3,
                      child: ListTile(
                        title: Text('ORDER NO.:${deposit?.orderId ?? ""}',
                            style: TextStyle(fontSize: 14,
                                fontWeight: FontWeight.w900)),
                        subtitle: Text(DateFormat('yyy-MM-dd').format(
                            DateTime.parse(deposit?.createdAt ?? ""))),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('₹${deposit?.cash ?? ""}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900)
                            ),
                            // snapshot.data![index].status=='0'?
                            // Container(
                            //   height: 20.h,
                            //   width: 70.w,
                            //   decoration: BoxDecoration(
                            //       color: lightBlue,
                            //       borderRadius: BorderRadius.circular(5)
                            //   ),
                            //   child:Center(child: Text('PENDING',
                            //     style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w900),)),
                            // )
                            //     :snapshot.data![index].status=='1'
                            //     ?
                            Container(
                              height: 20,
                              width: 70,
                              decoration: BoxDecoration(
                                  color:deposit?.status==1? Colors.orange:deposit?.status==2?AppColor.green:deposit?.status==3?AppColor.red:AppColor.red ,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(child: Text(deposit?.status==1?"PENDING":deposit?.status==2?'SUCCESS':deposit?.status==3?"REJECT":"FAILED",
                                style: TextStyle(fontSize: 10,
                                    fontWeight: FontWeight.w900),)),
                            )
                            //     :Container(
                            //   height: 20.h,
                            //   width: 70.w,
                            //   decoration: BoxDecoration(
                            //       color: Colors.redAccent,
                            //       borderRadius: BorderRadius.circular(5)
                            //   ),
                            //   child:Center(child: Text('FAILED',
                            //     style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w900),)),
                            // )
                          ],
                        ),
                      )
                  );
                })
          // FutureBuilder<List<withdrawlhistoryrecord>>(
          //     future: qwe(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //       else if (snapshot.hasError) {
          //         return Center(
          //           child: Text('Error: ${snapshot.error}'),
          //         );
          //       }
          //       else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //         return Center(
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 height: height*0.25,
          //                 width: width*0.5,
          //                 decoration: const BoxDecoration(
          //                     image: DecorationImage(
          //                       fit: BoxFit.fill,
          //                       image: AssetImage(noData),
          //                     )
          //                 ),
          //               ),
          //               Text(
          //                 "No Withdrawal History",
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 25.sp,
          //                   color: black,
          //                 ),
          //               ),
          //
          //             ],
          //           ),
          //         );
          //       }
          //       else {
          //         return ListView.builder(
          //
          //             itemCount: snapshot.data!.length,
          //             itemBuilder: (BuildContext ctx, index) {
          //               return  Card(elevation: 3,
          //                   child: ListTile(
          //                     title: Text('ORDER NO.: '+'${snapshot.data![index].orderNumber}',
          //                         style: TextStyle(fontSize: 14.sp,
          //                             fontWeight: FontWeight.w900)),
          //                     subtitle: Text('${snapshot.data![index].createdAt}'),
          //                     trailing: Column(
          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text('₹ '+'${snapshot.data![index].amount}',
          //                             style: TextStyle(
          //                                 fontSize: 12.sp,
          //                                 fontWeight: FontWeight.w900)
          //                         ),
          //                         snapshot.data![index].status=='0'?
          //                         Container(
          //                           height: 20.h,
          //                           width: 70.w,
          //                           decoration: BoxDecoration(
          //                               color: lightBlue,
          //                               borderRadius: BorderRadius.circular(5)
          //                           ),
          //                           child:Center(child: Text('PENDING',
          //                             style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w900),)),
          //                         )
          //                             :snapshot.data![index].status=='1'
          //                             ?Container(
          //                           height: 20.h,
          //                           width: 70.w,
          //                           decoration: BoxDecoration(
          //                               color: Colors.green,
          //                               borderRadius: BorderRadius.circular(5)
          //                           ),
          //                           child:Center(child: Text('SUCCESS',
          //                             style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w900),)),
          //                         ):Container(
          //                           height: 20.h,
          //                           width: 70.w,
          //                           decoration: BoxDecoration(
          //                               color: Colors.redAccent,
          //                               borderRadius: BorderRadius.circular(5)
          //                           ),
          //                           child:Center(child: Text('FAILED',
          //                             style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w900),)),
          //                         )
          //                       ],
          //                     ),
          //                   )
          //               );
          //             });
          //       }
          //     }),
        ):Center(
          child: Container(
            height: height * 0.2,
            width: width,
            alignment: Alignment.center,
            child: const Text('No data available!',
                style: TextStyle(color: Colors.blue,fontSize:18)),
          ),
        ),
      );


// Future<List<withdrawlhistoryrecord>> qwe()  async {
//   final prefs = await SharedPreferences.getInstance();
//   final userid = prefs.getString("userId");
//   print(userid);
//   final response = await http.post(
//     Uri.parse(ApiConst.withdrawHistory),
//     // headers:<String ,String>{
//     //   "Content-Type":"application/json; charset=UTF-8",
//     // },
//     body: jsonEncode(<String ,String>{
//       "userid": '$userid',
//     }),
//   );
//   if (response.statusCode == 200) {
//     final jsonData = json.decode(response.body)['data'] as List<dynamic>;
//     print(response);
//     print('kkkkkkkkkkkkkkkkkkkkkkkk');
//     return jsonData.map((item) => withdrawlhistoryrecord.fromJson(item)).toList();
//   } else {
//     throw Exception('Failed to load data');
//   }
// }
  }
}