// import 'dart:async';
// import 'dart:math';
// import 'package:balloon/game_controller.dart';
// import 'package:balloon/generated/assets.dart';
// import 'package:balloon/main.dart';
// import 'package:balloon/view_model/amount_list_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
//
// class BalloonScreen extends StatefulWidget {
//   const BalloonScreen({super.key});
//
//   @override
//   _BalloonScreenState createState() => _BalloonScreenState();
// }
//
// class _BalloonScreenState extends State<BalloonScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _flyAnimation;
//   late AnimationController _pipeController;
//   late Animation<double> _pipeAnimation;
//   final Random _random = Random();
//   Timer? _timer;
//   @override
//   void initState() {
//     super.initState();
//     final gameController = Provider.of<GameController>(context, listen: false);
//     final amountList= Provider.of<AmountListViewModel>(context, listen: false);
//     amountList.amountListApi(context);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       gameController.startUTCTimer();
//       gameController.setBurstThreshold(
//           gameController.balloonSize + _random.nextDouble() * 100.0);
//       gameController.setMultipliedValue(double.parse(amountList.amountResponse?.data?.first.toString()??""));
//     });
//     // Setup animation controller for smooth flying
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     _flyAnimation = Tween<double>(begin: 200.0, end: 500.0).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });
//
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         gameController.setBlast(true);
//         _showBurstAnimation(gameController);
//         gameController.setMultipliedValue(
//             double.parse(amountList.amountResponse!.data![gameController.selectedIndex].amount.toString())
//           // double.parse(gameController.amount[gameController.selectedIndex])
//         );
//       }
//     });
//     _pipeController = AnimationController(
//       duration: Duration(seconds: 10),
//       vsync: this,
//     );
//
//     // Define the animation with a curve
//     _pipeAnimation =CurvedAnimation(
//       parent: _pipeController,
//       curve: Curves.easeInOut,
//     );
//
//   }
//   void _startPipeAnimation() {
//     _pipeController.forward();
//   }
//
//   void _resetPipeAnimation() {
//     _pipeController.reverse();
//   }
//
//   void _increaseSize(GameController gameController) {
//     final amountList= Provider.of<AmountListViewModel>(context, listen: false);
//     if (gameController.isFlying) return;
//
//     gameController.setBalloonSize(
//         gameController.balloonSize + gameController.sizeIncrement);
//
//     double selectedValue =
//         double.tryParse(amountList.amountResponse?.data?[gameController.selectedIndex].amount.toString()??"") ??
//             0.0;
//     gameController
//         .setMultipliedValue(gameController.multipliedValue + selectedValue);
//
//     // Random chance for balloon to burst
//     // if (_random.nextDouble() < 0.02) {
//     //   gameController.setBlast(true);
//     //   _showBurstAnimation(gameController);
//     //   gameController.setMultipliedValue(
//     //       double.parse(amountList.amountResponse!.data![gameController.selectedIndex].amount.toString())
//     //       // double.parse(gameController.amount[gameController.selectedIndex])
//     //   );
//     // }
//     if (_random.nextDouble() < 0.03 + (gameController.balloonSize / 1000)) {
//       final amountList= Provider.of<AmountListViewModel>(context, listen: false);
//       gameController.setBlast(true);
//       _showBurstAnimation(gameController);
//       gameController.setMultipliedValue(
//           double.parse(amountList.amountResponse!.data![gameController.selectedIndex].amount.toString()));
//       // gameController.setMultipliedValue(
//       //     double.parse(gameController.amount[gameController.selectedIndex]));
//     }
//     if (gameController.balloonSize >= gameController.burstThreshold) {
//       if (_random.nextBool()) {
//         gameController.setWinGif(false);
//         _startFlying(gameController); // Balloon flies
//         gameController.setMultipliedValue(
//             double.parse(amountList.amountResponse!.data![gameController.selectedIndex].amount.toString())
//           // double.parse(gameController.amount[gameController.selectedIndex])
//         );
//       } else {
//         gameController.setBlast(true);
//         _showBurstAnimation(gameController);
//         gameController.setMultipliedValue(
//             double.parse(amountList.amountResponse!.data![gameController.selectedIndex].amount.toString())
//           // double.parse(gameController.amount[gameController.selectedIndex])
//         );
//       }
//     }
//
//   }
//
//   void _startFlying(GameController gameController) {
//     gameController.setWinGif(false);
//     gameController.setIsFlying(true);
//     _controller.forward(); // Start the flying animation
//   }
//
//   void _showBurstAnimation(GameController gameController) {
//     showDialog(
//       barrierColor: Colors.transparent,
//       barrierDismissible: false,
//       context: context,
//       builder: (context) => AlertDialog(
//         alignment: Alignment.center,
//         backgroundColor: Colors.transparent,
//         content: TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//             _resetBalloon(gameController);
//           },
//           child: Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage(Assets.imagesButton), fit: BoxFit.fill),
//               ),
//               child: Text(
//                 "Restart the game",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600),
//               )),
//         ),
//       ),
//     );
//   }
//
//   void _resetBalloon(GameController gameController) {
//     gameController.setBlast(false);
//     gameController.setBalloonSize(250.0);
//     gameController.setBurstThreshold(
//         gameController.balloonSize + _random.nextDouble() * 100.0);
//     gameController.setIsFlying(false);
//     _controller.reset();
//   }
//
//   void _startTimer(GameController gameController) {
//     _timer = Timer.periodic(Duration(milliseconds: 700), (timer) {
//       _increaseSize(gameController);
//     });
//   }
//
//   void _stopTimer() {
//     _timer?.cancel();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }
//   Offset _startPosition = Offset.zero;
//   final GlobalKey _containerKey = GlobalKey();
//   final ScrollController _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     final gameController = Provider.of<GameController>(context);
//     final amountList = Provider.of<AmountListViewModel>(context);
//     // print("Size:${gameController.balloonSize}");
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           height: height,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(Assets.imagesBg), fit: BoxFit.fill),
//           ),
//           child: Stack(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 color: Colors.black,
//                 child: Row(
//                   children: [
//                     Text("SMARTSOFT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
//                     SizedBox(width: width*0.03,),
//                     Text("GAMING",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600)),
//                     Spacer(),
//                     Text(gameController.utcTime,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: height * 0.2,
//                 left: width * 0.25,
//                 child: Stack(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(
//                           left: 60, top: 12, bottom: 12, right: 12),
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage(Assets.imagesBalanceTag),
//                               fit: BoxFit.fill),
//                           borderRadius: BorderRadius.circular(20)),
//                       child: RichText(
//                         textAlign: TextAlign.center,
//                         text: TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: GradientText(
//                                 text: "Balance",
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   shadows: [
//                                     Shadow(
//                                       offset: Offset(
//                                           1.1, 1.1), // Creates the 3D effect
//                                       blurRadius: 2.0,
//                                       color: Colors.grey,
//                                     ),
//                                   ],
//                                 ),
//                                 gradient: LinearGradient(
//                                   colors: [Colors.blue, Colors.lightBlue],
//                                 ),
//                               ),
//                             ),
//                             WidgetSpan(
//                               child: GradientText(
//                                 text: gameController.walletAmount,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   shadows: [
//                                     Shadow(
//                                       offset:
//                                       Offset(1, 1), // Creates the 3D effect
//                                       blurRadius: 2.0,
//                                       color: Colors.grey,
//                                     ),
//                                   ],
//                                 ),
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Color(0xFFFFD700), // Gold
//                                     Color(0xFFFFC107), // Lighter Gold
//                                     Color(0xFFFFA500),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             WidgetSpan(
//                               child: GradientText(
//                                 text: ' DMO',
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   shadows: [
//                                     Shadow(
//                                       offset: Offset(1.5, 1.5),
//                                       blurRadius: 2.0,
//                                       color: Colors.grey,
//                                     ),
//                                   ],
//                                 ),
//                                 gradient: LinearGradient(
//                                   colors: [Colors.orange, Colors.red],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     gameController.winGif == true
//                         ? Positioned(
//                       left: width * 0.15,
//                       top: -25,
//                       child: SizedBox(
//                           height: 100,
//                           width: 200,
//                           child: Lottie.asset(
//                             "assets/lotti/confety.json",
//                           )),
//                     )
//                         : Container(),
//                   ],
//                 ),
//               ),
//               gameController.winGif == true
//                   ? Positioned(
//                 bottom: _flyAnimation.value,
//                 child: SizedBox(
//                   width: width * 1,
//                   height: height * 0.35,
//                   child: Lottie.asset("assets/lotti/win.json"),
//                 ),
//               )
//                   : Positioned(
//                 bottom: _flyAnimation.value,
//                 left: 40,
//                 child: LayoutBuilder(
//                   builder: (context, constraints) {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       RenderBox box = _containerKey.currentContext!.findRenderObject() as RenderBox;
//                       Offset position = box.localToGlobal(Offset.zero);
//                       setState(() {
//                         // _startPosition = position;
//                         if (position.dy != _startPosition.dy) {
//                           Future.delayed(Duration(seconds: 1),(){
//                             _startPosition = Offset(position.dx, position.dy);
//                           });
//                           // _startPosition = Offset(position.dx, position.dy);
//                         }
//                       });
//                     });
//
//                     return Stack(
//                       children: [
//                         Container(
//                           key: _containerKey,
//                           width: gameController.winGif == true
//                               ? width * 1
//                               : gameController.balloonSize,
//                           height: gameController.winGif == true
//                               ? height * 0.35
//                               : gameController.balloonSize,
//                           decoration: BoxDecoration(
//                             // color: Colors.red,
//                             image: DecorationImage(
//                               image: AssetImage(gameController.blast == true
//                                   ? Assets.imagesBlasat
//                                   : gameController.isFlying
//                                   ? Assets.imagesFlyingBallon
//                                   : Assets.imagesBalloon),
//                             ),
//                           ),
//                         ),
//                         Center(
//                           child: Padding(
//                             padding:  EdgeInsets.only(left: 80.0, top: height*0.12),
//                             child: Text(
//                               gameController.blast == true || gameController.isFlying
//                                   ? ""
//                                   : gameController.multipliedValue.toStringAsFixed(2),
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               // Positioned(
//               //   bottom: _flyAnimation.value,
//               //   left: 40,
//               //   child: Stack(
//               //     clipBehavior: Clip.none,
//               //     children: [
//               //       AnimatedContainer(
//               //         duration: Duration(milliseconds: 300),
//               //         width: gameController.winGif == true
//               //             ? width * 1
//               //             : gameController.balloonSize,
//               //         height: gameController.winGif == true
//               //             ? height * 0.35
//               //             : gameController.balloonSize,
//               //         decoration: BoxDecoration(
//               //           image: DecorationImage(
//               //             image: AssetImage(gameController.blast == true
//               //                 ? Assets.imagesBlasat
//               //                 : gameController.isFlying
//               //                 ? Assets.imagesFlyingBallon
//               //                 : Assets.imagesBalloon),
//               //           ),
//               //         ),
//               //         child: Center(
//               //           child: Padding(
//               //             padding: const EdgeInsets.only(left: 58.0, bottom: 20),
//               //             child: Text(
//               //               gameController.blast == true || gameController.isFlying
//               //                   ? ""
//               //                   : gameController.multipliedValue.toStringAsFixed(2),
//               //               style: TextStyle(
//               //                 fontSize: 24,
//               //                 fontWeight: FontWeight.bold,
//               //                 color: Colors.white,
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               gameController.winGif == true
//                   ? Positioned(
//                 bottom: _flyAnimation.value,
//                 child: SizedBox(
//                   width: width * 1,
//                   height: height * 0.35,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Stack(
//                         children: [
//                           // Shadowed Text for 3D Effect
//                           Positioned(
//                             top: 3,
//                             left: 3,
//                             child: ShaderMask(
//                               shaderCallback: (bounds) => LinearGradient(
//                                 colors: [
//                                   Colors.black
//                                       .withOpacity(0.5), // Dark shadow
//                                   Colors.black
//                                       .withOpacity(0.2), // Lighter shadow
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ).createShader(bounds),
//                               child: Text(
//                                 'You Won',
//                                 style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors
//                                       .white, // Necessary for ShaderMask
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // Foreground Golden Gradient Text
//                           ShaderMask(
//                             shaderCallback: (bounds) => LinearGradient(
//                               colors: [
//                                 Color(0xFFFFD700), // Gold
//                                 Color(0xFFFFC107), // Lighter Gold
//                                 Color(0xFFFFA500), // Orange Gold
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ).createShader(bounds),
//                             child: Text(
//                               'You Won',
//                               style: TextStyle(
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors
//                                     .white, // Necessary for ShaderMask
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Stack(
//                         children: [
//                           Positioned(
//                             top: 3,
//                             left: 3,
//                             child: ShaderMask(
//                               shaderCallback: (bounds) => LinearGradient(
//                                 colors: [
//                                   Colors.black
//                                       .withOpacity(0.5), // Dark shadow
//                                   Colors.black
//                                       .withOpacity(0.2), // Lighter shadow
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ).createShader(bounds),
//                               child: Text(
//                                 "₹${gameController.multipliedValue.toStringAsFixed(2)}",
//                                 style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors
//                                       .white, // Necessary for ShaderMask
//                                 ),
//                               ),
//                             ),
//                           ),
//                           ShaderMask(
//                             shaderCallback: (bounds) => LinearGradient(
//                               colors: [
//                                 Color(0xFFFFD700), // Gold
//                                 Color(0xFFFFC107), // Lighter Gold
//                                 Color(0xFFFFA500),
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ).createShader(bounds),
//                             child: Text(
//                               "₹${gameController.multipliedValue.toStringAsFixed(2)}",
//                               style: TextStyle(
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.w900,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               )
//                   : Container(),
//               gameController.isFlying ||gameController.blast == true||gameController.winGif == true?Container():  Positioned(
//                 top: height * 0.13 , // Moves upwards based on the animation
//                 left: -5,
//                 child: AnimatedBuilder(
//                   animation: _pipeAnimation,
//                   builder: (context, child) {
//                     return CustomPaint(
//                       painter: CurvedPipeTail(_pipeAnimation.value-7,_startPosition),
//                       child: SizedBox(
//                         width: width * 0.5,
//                         height: height *0.45 , // Increase the height as the animation value increases
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Positioned(
//                   top: height * 0.45,
//                   // left: 1,
//                   child: AnimatedBuilder(
//                     animation: _pipeAnimation,
//                     builder: (context, child) {
//                       return CustomPaint(
//                         painter: CurvedPipePainter(_pipeAnimation.value),
//                         child: SizedBox(
//                           width: width * 0.5,
//                           height: height * 0.4,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               Positioned(
//                 left: width * 0.4,
//                 bottom: height * 0.1,
//                 child: GestureDetector(
//                   onTapDown: (_) {
//                     gameController.setIsButtonPressed(true);
//                     _startTimer(gameController);
//                     _startPipeAnimation();
//
//                   },
//                   onTapUp: (_) {
//                     gameController.setIsButtonPressed(false);
//                     _stopTimer();
//                     setState(() {
//                       gameController.setWinGif(true);
//                     });
//                     gameController.setWalletAmount(
//                         (double.parse(gameController.walletAmount) +
//                             double.parse(gameController.multipliedValue
//                                 .toStringAsFixed(2)))
//                             .toString());
//                     gameController.setBalloonSize(250.0);
//                     Future.delayed(Duration(seconds: 2), () {
//                       gameController.setWinGif(false);
//                       // setState(() {
//
//                       gameController.setMultipliedValue(
//                           double.parse(amountList.amountResponse!.data![gameController.selectedIndex].amount.toString())
//                         // double.parse(
//                         // gameController.amount[gameController.selectedIndex])
//                       );
//                     });
//                     _resetPipeAnimation();
//                   },
//                   onTapCancel: () {
//                     gameController.setIsButtonPressed(false);
//                     _stopTimer();
//                     _resetPipeAnimation();
//                   },
//                   child: CircleAvatar(
//                     radius: 40,
//                     backgroundImage: AssetImage(Assets.imagesClick),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 15,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         final newIndex = max(0, gameController.selectedIndex - 1);
//                         gameController.setSelectedIndex(newIndex);
//                         _scrollToCenter(newIndex, width);
//                         gameController.setMultipliedValue(
//                             double.parse(amountList.amountResponse!.data![gameController.selectedIndex].amount.toString()));
//                       },
//                       child:
//                       Icon(Icons.arrow_left, size: 40, color: Colors.white),
//                     ),
//                     SizedBox(
//                       width: width * 0.8,
//                       height: height * 0.08,
//                       child: ListView.builder(
//                         controller: _scrollController,
//                         scrollDirection: Axis.horizontal,
//                         itemCount:amountList.amountResponse?.data?.length??0 ,
//                         itemBuilder: (context, index) {
//                           final amount =amountList.amountResponse?.data?[index].amount??"";
//                           final isSelected =
//                               index == gameController.selectedIndex;
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     gameController.setSelectedIndex(index);
//                                     gameController.setMultipliedValue(
//                                         double.parse(amountList.amountResponse!.data![gameController.selectedIndex].amount.toString())
//                                     );
//                                     _scrollToCenter(index, width);
//                                   },
//                                   child: Transform.translate(
//                                     offset:
//                                     isSelected ? Offset(0, -8) : Offset(0, 0),
//                                     child: Text(
//                                       amount.toString(),
//                                       style: TextStyle(
//                                         fontSize: isSelected ? 20 : 18,
//                                         fontWeight: isSelected
//                                             ? FontWeight.w900
//                                             : FontWeight.normal,
//                                         color: isSelected
//                                             ? Colors.white
//                                             : Colors.white70,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Transform.translate(
//                                   offset:
//                                   isSelected ? Offset(0, -8) : Offset(0, 0),
//                                   child: Text(
//                                     'DMO',
//                                     style: TextStyle(
//                                       fontSize: isSelected ? 16 : 12,
//                                       fontWeight: isSelected
//                                           ? FontWeight.w900
//                                           : FontWeight.normal,
//                                       color: isSelected
//                                           ? Colors.white
//                                           : Colors.white54,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         final newIndex = min(amountList.amountResponse!.data!.length - 1,
//                             gameController.selectedIndex + 1);
//                         gameController.setSelectedIndex(newIndex);
//                         _scrollToCenter(newIndex, width);
//                         gameController.setMultipliedValue(
//                             double.parse(amountList.amountResponse!.data![gameController.selectedIndex].amount.toString())
//                         );
//                       },
//                       child:
//                       Icon(Icons.arrow_right, size: 40, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _scrollToCenter(int index, double listViewWidth) {
//     const itemWidth =
//     100.0; // Adjust based on the actual item width and padding
//     final offset = (index * itemWidth) - (listViewWidth / 2) + (itemWidth / 2);
//
//     _scrollController.animateTo(
//       offset.clamp(0.0, _scrollController.position.maxScrollExtent),
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
// }
