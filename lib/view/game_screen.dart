// import 'dart:async';
// import 'dart:math';
// import 'package:balloon/amount_page.dart';
// import 'package:balloon/generated/assets.dart';
// import 'package:flutter/material.dart';
//
// class BalloonScreen extends StatefulWidget {
//   @override
//   _BalloonScreenState createState() => _BalloonScreenState();
// }
//
// class _BalloonScreenState extends State<BalloonScreen>
//     with SingleTickerProviderStateMixin {
//   double _balloonSize = 200.0; // Initial size
//   late double _burstThreshold;
//   final Random _random = Random();
//   late AnimationController _controller;
//   late Animation<double> _flyAnimation; // Animation for vertical movement
//   bool _isFlying = false;
//   bool _isButtonPressed = false;
//   Timer? _timer; // Timer to increase size continuously
//   final double _sizeIncrement = 1.0; // Size increase per tick
//
//   @override
//   void initState() {
//     super.initState();
//     _generateBurstThreshold();
//
//     // Setup the animation controller for smooth flying
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
//         _showBurstAnimation();
//       }
//     });
//   }
//
//   void _generateBurstThreshold() {
//     _burstThreshold = _balloonSize + _random.nextDouble() * 100.0;
//   }
//   void _increaseSize() {
//     if (_isFlying) return;
//
//     setState(() {
//       _balloonSize += _sizeIncrement; // Increase size continuously while button is pressed
//
//       // Randomly check if the balloon should burst
//       if (_random.nextDouble() < 0.02) { // 2% chance of burst on each size increase
//         _showBurstAnimation();
//       }
//
//       if (_balloonSize >= _burstThreshold) {
//         // If size exceeds threshold, start flying
//         if (_random.nextBool()) {
//           _startFlying(); // Balloon flies
//         } else {
//           _showBurstAnimation(); // Balloon bursts
//         }
//       }
//     });
//   }
//   void _startFlying() {
//     setState(() {
//       _isFlying = true;
//     });
//     _controller.forward(); // Start the flying animation
//   }
//   void _showBurstAnimation() {
//     showDialog(
//       barrierColor: Colors.transparent,
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("POP!"),
//         content: Container(
//           height: 100,
//           decoration: BoxDecoration(
//               image: DecorationImage(image: AssetImage("assets/images/blasat.gif"))),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _resetBalloon();
//             },
//             child: Text("Restart"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _resetBalloon() {
//     setState(() {
//       _balloonSize = 200.0; // Reset to initial size
//       _generateBurstThreshold(); // Generate a new threshold
//       _isFlying = false;
//     });
//     _controller.reset();
//   }
//
//   void _startTimer() {
//     // Start a timer to repeatedly increase size while button is held
//     _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
//       _increaseSize();
//     });
//   }
//
//   void _stopTimer() {
//     // Stop the timer when the button is released
//     _timer?.cancel();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _timer?.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }
//   final ScrollController _scrollController = ScrollController();
//   int _selectedIndex = 1; // Default selected index
//   final List<String> _values = ['0.10', '0.50', '1.00', '5']; // Displayed values
//
//   void _moveForward() {
//     setState(() {
//       if (_selectedIndex < _values.length - 1) {
//         _selectedIndex++;
//         _scrollToIndex(_selectedIndex);
//       }
//     });
//   }
//
//   void _moveBackward() {
//     setState(() {
//       if (_selectedIndex > 0) {
//         _selectedIndex--;
//         _scrollToIndex(_selectedIndex);
//       }
//     });
//   }
//
//   void _scrollToIndex(int index) {
//     _scrollController.animateTo(
//       index * 100.0, // Adjust the width per item
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Balloon Game")),
//       body: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill)),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Balloon widget
//             Positioned(
//               bottom: _flyAnimation.value, // Use animation for vertical position
//               child: AnimatedContainer(
//                 alignment: Alignment.center,
//                 duration: Duration(milliseconds: 300),
//                 width: _balloonSize,
//                 height: _balloonSize,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(image: AssetImage(_isFlying==false? Assets.imagesBalloon:Assets.imagesFlyingBallon))),
//                 child: Text(_values[_selectedIndex],),
//               ),
//             ),
//             // GestureDetector to detect button press
//             Positioned(
//               bottom: 50, // Position button near the bottom
//               child: GestureDetector(
//                 onTapDown: (_) {
//                   setState(() {
//                     _isButtonPressed = true;
//                   });
//                   // Start increasing size when the button is pressed
//                   _startTimer();
//                 },
//                 onTapUp: (_) {
//                   setState(() {
//                     _isButtonPressed = false;
//                   });
//                   // Stop the timer when the button is released
//                   _stopTimer();
//                 },
//                 onTapCancel: () {
//                   setState(() {
//                     _isButtonPressed = false;
//                   });
//                   _stopTimer();
//                 },
//                 child:CircleAvatar(
//                   radius: 40,
// backgroundImage: AssetImage(Assets.imagesClick),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 10, // Adjust position
//               child:  Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Backward Arrow Button
//                   GestureDetector(
//                     onTap: _moveBackward,
//                     child: Icon(Icons.arrow_left, size: 40, color: Colors.white),
//                   ),
//                   // Scrollable List
//                   Container(
//                     width: 200, // Adjust width as per your design
//                     height: 60, // Adjust height
//                     child: ListView.builder(
//                       controller: _scrollController,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _values.length,
//                       itemBuilder: (context, index) {
//                         final isSelected = index == _selectedIndex;
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               GestureDetector(
//                                 onTap: (){
//                                   setState(() {
//                                     _selectedIndex=index;
//                                   });
//                                 },
//                                 child: Text(
//                                   _values[index],
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                                     color: isSelected ? Colors.white : Colors.white70,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'DMO',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: isSelected ? Colors.white : Colors.white54,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // Forward Arrow Button
//                   GestureDetector(
//                     onTap: _moveForward,
//                     child: Icon(Icons.arrow_right, size: 40, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///
// import 'dart:async';
// import 'dart:math';
// import 'package:balloon/main.dart';
// import 'package:flutter/material.dart';
//
// class BalloonScreen extends StatefulWidget {
//   @override
//   _BalloonScreenState createState() => _BalloonScreenState();
// }
//
// class _BalloonScreenState extends State<BalloonScreen> with SingleTickerProviderStateMixin {
//   double _balloonSize = 200.0; // Initial size
//    late double _burstThreshold;
//   final Random _random = Random();
//   late AnimationController _controller;
//   late Animation<double> _flyAnimation; // Animation for vertical movement
//   bool _isFlying = false;
//   bool _isButtonPressed = false;
//   Timer? _timer; // Timer to increase size continuously
//   final double _sizeIncrement = 3.0; // Size increase per tick
//   final List<String> _values = ['2', '5', '10', '15','20','25','30']; // Displayed values
//   int _selectedIndex = 0; // Default selected index
//   double _multipliedValue = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _generateBurstThreshold();
//
//     // Setup the animation controller for smooth flying
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
//         _showBurstAnimation();
//         _multipliedValue=_selectedIndex.toDouble();
//       }
//     });
//   }
//
//   void _generateBurstThreshold() {
//     _burstThreshold = _balloonSize + _random.nextDouble() * 300.0;
//   }
//
//   void _increaseSize() {
//     if (_isFlying) return;
//
//     setState(() {
//       _balloonSize += _sizeIncrement;
//
//       double selectedValue = double.tryParse(_values[_selectedIndex]) ?? 0.0;
//       _multipliedValue = selectedValue * _multipliedValue;
//
//       // Randomly check if the balloon should burst
//       if (_random.nextDouble() < 0.02) { // 2% chance of burst on each size increase
//         _showBurstAnimation();
//         _multipliedValue=selectedValue;
//       }
//
//       if (_balloonSize >= _burstThreshold) {
//         // If size exceeds threshold, start flying
//         if (_random.nextBool()) {
//           _startFlying(); // Balloon flies
//         } else {
//           _showBurstAnimation();
//           _multipliedValue=selectedValue;
//         }
//       }
//     });
//   }
//
//   void _startFlying() {
//     setState(() {
//       _isFlying = true;
//     });
//     _controller.forward(); // Start the flying animation
//   }
//
//   void _showBurstAnimation() {
//     showDialog(
//       barrierColor: Colors.transparent,
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("POP!"),
//         content: Container(
//           height: 100,
//           decoration: BoxDecoration(
//               image: DecorationImage(image: AssetImage("assets/images/blasat.gif"))),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _resetBalloon();
//             },
//             child: Text("Restart"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _resetBalloon() {
//     setState(() {
//       _balloonSize = 200.0; // Reset to initial size
//       _generateBurstThreshold(); // Generate a new threshold
//       _isFlying = false;
//     });
//     _controller.reset();
//   }
//
//   void _startTimer() {
//     // Start a timer to repeatedly increase size while button is held
//     _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
//       _increaseSize();
//     });
//   }
//
//   void _stopTimer() {
//     // Stop the timer when the button is released
//     _timer?.cancel();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _timer?.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }
//
//   void _moveForward() {
//     setState(() {
//       if (_selectedIndex < _values.length - 1) {
//         _selectedIndex++;
//       }
//     });
//   }
//
//   void _moveBackward() {
//     setState(() {
//       if (_selectedIndex > 0) {
//         _selectedIndex--;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Balloon Game")),
//       body: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill)),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Balloon widget with the multiplied value displayed on it
//             Positioned(
//               bottom: _flyAnimation.value, // Use animation for vertical position
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 width: _balloonSize,
//                 height: _balloonSize,
//                 decoration: BoxDecoration(
//                   // color: Colors.red,
//                   image: DecorationImage(
//                     image: AssetImage(_isFlying ? "assets/images/flying_ballon.png" :"assets/images/balloon.png"),fit: BoxFit.fill
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     _multipliedValue.toStringAsFixed(2),
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // GestureDetector to detect button press
//             Positioned(
//               bottom: 50,
//               child: GestureDetector(
//                 onTapDown: (_) {
//                   setState(() {
//                     _isButtonPressed = true;
//                   });
//                   // Start increasing size when the button is pressed
//                   _startTimer();
//                 },
//                 onTapUp: (_) {
//                   setState(() {
//                     _isButtonPressed = false;
//                   });
//                   // Stop the timer when the button is released
//                   _stopTimer();
//                 },
//                 onTapCancel: () {
//                   setState(() {
//                     _isButtonPressed = false;
//                   });
//                   _stopTimer();
//                 },
//                 child: CircleAvatar(
//                   radius: 40,
//                   backgroundImage: AssetImage("assets/images/click.png"),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 10, // Adjust position
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Backward Arrow Button
//                   GestureDetector(
//                     onTap: _moveBackward,
//                     child: Icon(Icons.arrow_left, size: 40, color: Colors.white),
//                   ),
//                   // Scrollable List
//                   Container(
//                     width: width*0.8,
//                     height: height*0.08,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _values.length,
//                       itemBuilder: (context, index) {
//                         final isSelected = index == _selectedIndex;
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     _selectedIndex = index;
//                                     _multipliedValue = double.parse(_values[_selectedIndex]);
//                                   });
//                                 },
//                                 child: Text(
//                                   _values[index],
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                                     color: isSelected ? Colors.white : Colors.white70,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'DMO',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: isSelected ? Colors.white : Colors.white54,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // Forward Arrow Button
//                   GestureDetector(
//                     onTap: _moveForward,
//                     child: Icon(Icons.arrow_right, size: 40, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///
import 'dart:async';
import 'dart:math';
import 'package:balloon/game_controller.dart';
import 'package:balloon/generated/assets.dart';
import 'package:balloon/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalloonScreen extends StatefulWidget {
  @override
  _BalloonScreenState createState() => _BalloonScreenState();
}

class _BalloonScreenState extends State<BalloonScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flyAnimation;
  final Random _random = Random();
  Timer? _timer;
bool blast =false;
  @override
  void initState() {
    super.initState();
    final gameController = Provider.of<GameController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Generate the initial burst threshold
      gameController.setBurstThreshold(gameController.balloonSize + _random.nextDouble() * 100.0);

    });

    // Setup animation controller for smooth flying
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _flyAnimation = Tween<double>(begin: 200.0, end: 500.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          blast=true;
        });
        _showBurstAnimation(gameController);
        gameController.setMultipliedValue(0.0);
      }
    });
  }

  void _increaseSize(GameController gameController) {
    if (gameController.isFlying) return;

    gameController.setBalloonSize(gameController.balloonSize + gameController.sizeIncrement);

    double selectedValue = double.tryParse(gameController.amount[gameController.selectedIndex]) ?? 0.0;
    // gameController.setMultipliedValue(selectedValue * gameController.balloonSize);
    gameController.setMultipliedValue(gameController.multipliedValue + selectedValue);

    // Random chance for balloon to burst
    if (_random.nextDouble() < 0.02) {
      setState(() {
        blast=true;
      });
      _showBurstAnimation(gameController);
      gameController.setMultipliedValue(0.0);
    }

    if (gameController.balloonSize >= gameController.burstThreshold) {
      if (_random.nextBool()) {
        // setState(() {
        //   blast=true;
        // });
        _startFlying(gameController); // Balloon flies
        gameController.setMultipliedValue(0.0);
      } else {
        setState(() {
          blast=true;
        });
        _showBurstAnimation(gameController);
        gameController.setMultipliedValue(0.0);

      }
    }
  }

  void _startFlying(GameController gameController) {
    gameController.setIsFlying(true);
    _controller.forward(); // Start the flying animation
  }

  void _showBurstAnimation(GameController gameController) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
        content:  TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _resetBalloon(gameController);
          },
          child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Assets.imagesButton), fit: BoxFit.fill),
              ),
              child: Text("Restart the game",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:FontWeight.w600),)),
        ),
      ),
    );



  }

  void _resetBalloon(GameController gameController) {
    setState(() {
blast=false;
    });

    gameController.setBalloonSize(300.0);
    gameController.setBurstThreshold(gameController.balloonSize + _random.nextDouble() * 100.0);
    gameController.setIsFlying(false);
    _controller.reset();
  }

  void _startTimer(GameController gameController) {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _increaseSize(gameController);
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
print(blast);
    return Scaffold(
      // appBar: AppBar(title: Text("Balloon Game")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
        ),
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Positioned(
              top: height*0.2,
              left: width*0.3,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text:
                  TextSpan(
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    children: [
                      TextSpan(
                          text: "Balance",
                          style: TextStyle(color:Colors.blue,fontWeight:FontWeight.w600,fontSize: 16)),
                      TextSpan(
                        text: ' 3000',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,fontSize: 18
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          },
                      ),
                      TextSpan(
                        text: 'DMO',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,fontSize: 14
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Balloon widget with the multiplied value displayed on it

            Positioned(
              bottom: _flyAnimation.value,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: gameController.balloonSize,
                // width: width*0.8,
                height: gameController.balloonSize,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                    image: AssetImage(
                        blast==true?"assets/images/blasat.gif":
                        gameController.isFlying
                        ? "assets/images/flying_ballon.png"
                        : "assets/images/balloon.png")
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 58.0,bottom: 20),
                    child: Text(
                        blast==true|| gameController.isFlying?"": gameController.multipliedValue.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // GestureDetector for button press
Positioned(
  top: height*0.66,
  left: 1,

  child: Container(
    height: height*0.18,
      width: width*0.5,

      decoration: BoxDecoration(
          // color: Colors.red,
        image: DecorationImage(image: AssetImage(Assets.imagesPipe),fit: BoxFit.fill)
      ),
      // child: Image.asset(Assets.imagesPipe,fit: BoxFit.fill,),
  ),
),
            Positioned(
              left: width*0.4,
              bottom: height*0.1,
              child: GestureDetector(
                onTapDown: (_) {
                  gameController.setIsButtonPressed(true);
                  _startTimer(gameController);
                },
                onTapUp: (_) {
                  gameController.setIsButtonPressed(false);
                  _stopTimer();
                },
                onTapCancel: () {
                  gameController.setIsButtonPressed(false);
                  _stopTimer();
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/click.png"),
                ),
              ),
            ),
            // Scrollable list with arrow controls
            Positioned(
              bottom: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => gameController.setSelectedIndex(
                        max(0, gameController.selectedIndex - 1)),
                    child: Icon(Icons.arrow_left, size: 40, color: Colors.white),
                  ),
                  SizedBox(
                    width: width * 0.8,
                    height: height * 0.08,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: gameController.amount.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == gameController.selectedIndex;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  gameController.setSelectedIndex(index);
                                  gameController.setMultipliedValue(double.parse(gameController.amount[gameController.selectedIndex]));
                                  },
                                child: Text(
                                  gameController.amount[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? Colors.white : Colors.white70,
                                  ),
                                ),
                              ),
                              Text(
                                'DMO',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white : Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () => gameController.setSelectedIndex(
                        min(gameController.amount.length - 1, gameController.selectedIndex + 1)),
                    child: Icon(Icons.arrow_right, size: 40, color: Colors.white),
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
