// Widget build(BuildContext context) {
//   final gameController = Provider.of<GameController>(context);
//   final amountList = Provider.of<AmountListViewModel>(context);
//   final bet = Provider.of<BetViewModel>(context);
//   return SafeArea(
//     child: Scaffold(
//       body: Container(
//         height: height,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage(Assets.imagesBg), fit: BoxFit.fill),
//         ),
//         child:
//         Stack(
//           children: [
//
//             Container(
//               padding: EdgeInsets.all(8),
//               color: Colors.black,
//               child: Row(
//                 children: [
//                   Text("SMARTSOFT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
//                   SizedBox(width: width*0.03,),
//                   Text("GAMING",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600)),
//                   Spacer(),
//                   Text(gameController.utcTime,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
//                 ],
//               ),
//             ),
//
//             Positioned(
//               top: height * 0.2,
//               left: width * 0.25,
//               child: Stack(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(
//                         left: 60, top: 12, bottom: 12, right: 12),
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage(Assets.imagesBalanceTag),
//                             fit: BoxFit.fill),
//                         borderRadius: BorderRadius.circular(20)),
//                     child: RichText(
//                       textAlign: TextAlign.center,
//                       text: TextSpan(
//                         children: [
//                           WidgetSpan(
//                             child: GradientText(
//                               text: "Balance",
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 shadows: [
//                                   Shadow(
//                                     offset: Offset(
//                                         1.1, 1.1), // Creates the 3D effect
//                                     blurRadius: 2.0,
//                                     color: Colors.grey,
//                                   ),
//                                 ],
//                               ),
//                               gradient: LinearGradient(
//                                 colors: [Colors.blue, Colors.lightBlue],
//                               ),
//                             ),
//                           ),
//                           WidgetSpan(
//                             child: GradientText(
//                               text: gameController.walletAmount,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 shadows: [
//                                   Shadow(
//                                     offset:
//                                     Offset(1, 1), // Creates the 3D effect
//                                     blurRadius: 2.0,
//                                     color: Colors.grey,
//                                   ),
//                                 ],
//                               ),
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color(0xFFFFD700), // Gold
//                                   Color(0xFFFFC107), // Lighter Gold
//                                   Color(0xFFFFA500),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           WidgetSpan(
//                             child: GradientText(
//                               text: ' DMO',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 shadows: [
//                                   Shadow(
//                                     offset: Offset(1.5, 1.5),
//                                     blurRadius: 2.0,
//                                     color: Colors.grey,
//                                   ),
//                                 ],
//                               ),
//                               gradient: LinearGradient(
//                                 colors: [Colors.orange, Colors.red],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   gameController.winGif == true
//                       ? Positioned(
//                     left: width * 0.15,
//                     top: -25,
//                     child: SizedBox(
//                         height: 100,
//                         width: 200,
//                         child: Lottie.asset(
//                           "assets/lotti/confety.json",
//                         )),
//                   )
//                       : Container(),
//                 ],
//               ),
//             ),
//             gameController.winGif == true
//                 ? Positioned(
//               bottom: _flyAnimation.value,
//               child: SizedBox(
//                 width: width * 1,
//                 height: height * 0.35,
//                 child: Lottie.asset("assets/lotti/win.json"),
//               ),
//             )
//                 : Positioned(
//               bottom: _flyAnimation.value,
//               left: 40,
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     RenderBox box = _containerKey.currentContext!.findRenderObject() as RenderBox;
//                     Offset position = box.localToGlobal(Offset.zero);
//                     setState(() {
//                       // _startPosition = position;
//                       if (position.dy != _startPosition.dy) {
//                         Future.delayed(Duration(seconds: 1),(){
//                           _startPosition = Offset(position.dx, position.dy);
//                         });
//                         // _startPosition = Offset(position.dx, position.dy);
//                       }
//                     });
//                   });
//
//                   return Stack(
//                     children: [
//                       Container(
//                         key: _containerKey,
//                         width: gameController.winGif == true
//                             ? width * 1
//                             : gameController.balloonSize,
//                         height: gameController.winGif == true
//                             ? height * 0.35
//                             : gameController.balloonSize,
//                         decoration: BoxDecoration(
//                           // color: Colors.red,
//                           image: DecorationImage(
//                             image: AssetImage(gameController.blast == true
//                                 ? Assets.imagesBlasat
//                                 : gameController.isFlying
//                                 ? Assets.imagesFlyingBallon
//                                 : Assets.imagesBalloon),
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Padding(
//                           padding:  EdgeInsets.only(left: 80.0, top: height*0.12),
//                           child: Text(
//                             gameController.blast == true || gameController.isFlying
//                                 ? ""
//                                 : gameController.multipliedValue.toStringAsFixed(2),
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             gameController.winGif == true
//                 ? Positioned(
//               bottom: _flyAnimation.value,
//               child: SizedBox(
//                 width: width * 1,
//                 height: height * 0.35,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Stack(
//                       children: [
//                         // Shadowed Text for 3D Effect
//                         Positioned(
//                           top: 3,
//                           left: 3,
//                           child: ShaderMask(
//                             shaderCallback: (bounds) => LinearGradient(
//                               colors: [
//                                 Colors.black
//                                     .withOpacity(0.5), // Dark shadow
//                                 Colors.black
//                                     .withOpacity(0.2), // Lighter shadow
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
//                         ),
//                         // Foreground Golden Gradient Text
//                         ShaderMask(
//                           shaderCallback: (bounds) => LinearGradient(
//                             colors: [
//                               Color(0xFFFFD700), // Gold
//                               Color(0xFFFFC107), // Lighter Gold
//                               Color(0xFFFFA500), // Orange Gold
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ).createShader(bounds),
//                           child: Text(
//                             'You Won',
//                             style: TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.bold,
//                               color: Colors
//                                   .white, // Necessary for ShaderMask
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Stack(
//                       children: [
//                         Positioned(
//                           top: 3,
//                           left: 3,
//                           child: ShaderMask(
//                             shaderCallback: (bounds) => LinearGradient(
//                               colors: [
//                                 Colors.black
//                                     .withOpacity(0.5), // Dark shadow
//                                 Colors.black
//                                     .withOpacity(0.2), // Lighter shadow
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ).createShader(bounds),
//                             child: Text(
//                               "₹${gameController.multipliedValue.toStringAsFixed(2)}",
//                               style: TextStyle(
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors
//                                     .white, // Necessary for ShaderMask
//                               ),
//                             ),
//                           ),
//                         ),
//                         ShaderMask(
//                           shaderCallback: (bounds) => LinearGradient(
//                             colors: [
//                               Color(0xFFFFD700), // Gold
//                               Color(0xFFFFC107), // Lighter Gold
//                               Color(0xFFFFA500),
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ).createShader(bounds),
//                           child: Text(
//                             "₹${gameController.multipliedValue.toStringAsFixed(2)}",
//                             style: TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.w900,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             )
//                 : Container(),
//             gameController.isFlying ||gameController.blast == true||gameController.winGif == true?Container():  Positioned(
//               top: height * 0.13 , // Moves upwards based on the animation
//               left: -5,
//               child: AnimatedBuilder(
//                 animation: _pipeAnimation,
//                 builder: (context, child) {
//                   return CustomPaint(
//                     painter: CurvedPipeTail(_pipeAnimation.value-7,_startPosition),
//                     child: SizedBox(
//                       width: width * 0.5,
//                       height: height *0.45 , // Increase the height as the animation value increases
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//           ],
//         ),
//       ),
//
//     ),
//   );
// }