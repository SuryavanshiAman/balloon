import 'dart:async';
import 'dart:math';
import 'package:balloon/amount_page.dart';
import 'package:balloon/generated/assets.dart';
import 'package:flutter/material.dart';

class BalloonScreen extends StatefulWidget {
  @override
  _BalloonScreenState createState() => _BalloonScreenState();
}

class _BalloonScreenState extends State<BalloonScreen>
    with SingleTickerProviderStateMixin {
  double _balloonSize = 200.0; // Initial size
  late double _burstThreshold;
  final Random _random = Random();
  late AnimationController _controller;
  late Animation<double> _flyAnimation; // Animation for vertical movement
  bool _isFlying = false;
  bool _isButtonPressed = false;
  Timer? _timer; // Timer to increase size continuously
  final double _sizeIncrement = 1.0; // Size increase per tick

  @override
  void initState() {
    super.initState();
    _generateBurstThreshold();

    // Setup the animation controller for smooth flying
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
        _showBurstAnimation();
      }
    });
  }

  void _generateBurstThreshold() {
    _burstThreshold = _balloonSize + _random.nextDouble() * 100.0;
  }
  void _increaseSize() {
    if (_isFlying) return;

    setState(() {
      _balloonSize += _sizeIncrement; // Increase size continuously while button is pressed

      // Randomly check if the balloon should burst
      if (_random.nextDouble() < 0.02) { // 2% chance of burst on each size increase
        _showBurstAnimation();
      }

      if (_balloonSize >= _burstThreshold) {
        // If size exceeds threshold, start flying
        if (_random.nextBool()) {
          _startFlying(); // Balloon flies
        } else {
          _showBurstAnimation(); // Balloon bursts
        }
      }
    });
  }
  void _startFlying() {
    setState(() {
      _isFlying = true;
    });
    _controller.forward(); // Start the flying animation
  }
  void _showBurstAnimation() {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("POP!"),
        content: Container(
          height: 100,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/blasat.gif"))),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetBalloon();
            },
            child: Text("Restart"),
          ),
        ],
      ),
    );
  }

  void _resetBalloon() {
    setState(() {
      _balloonSize = 200.0; // Reset to initial size
      _generateBurstThreshold(); // Generate a new threshold
      _isFlying = false;
    });
    _controller.reset();
  }

  void _startTimer() {
    // Start a timer to repeatedly increase size while button is held
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _increaseSize();
    });
  }

  void _stopTimer() {
    // Stop the timer when the button is released
    _timer?.cancel();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 1; // Default selected index
  final List<String> _values = ['0.10', '0.50', '1.00', '5']; // Displayed values

  void _moveForward() {
    setState(() {
      if (_selectedIndex < _values.length - 1) {
        _selectedIndex++;
        _scrollToIndex(_selectedIndex);
      }
    });
  }

  void _moveBackward() {
    setState(() {
      if (_selectedIndex > 0) {
        _selectedIndex--;
        _scrollToIndex(_selectedIndex);
      }
    });
  }

  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      index * 100.0, // Adjust the width per item
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Balloon Game")),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Balloon widget
            Positioned(
              bottom: _flyAnimation.value, // Use animation for vertical position
              child: AnimatedContainer(
                alignment: Alignment.center,
                duration: Duration(milliseconds: 300),
                width: _balloonSize,
                height: _balloonSize,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(_isFlying==false? Assets.imagesBalloon:Assets.imagesFlyingBallon))),
                child: Text(_values[_selectedIndex],),
              ),
            ),
            // GestureDetector to detect button press
            Positioned(
              bottom: 50, // Position button near the bottom
              child: GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    _isButtonPressed = true;
                  });
                  // Start increasing size when the button is pressed
                  _startTimer();
                },
                onTapUp: (_) {
                  setState(() {
                    _isButtonPressed = false;
                  });
                  // Stop the timer when the button is released
                  _stopTimer();
                },
                onTapCancel: () {
                  setState(() {
                    _isButtonPressed = false;
                  });
                  _stopTimer();
                },
                child:CircleAvatar(
                  radius: 40,
backgroundImage: AssetImage(Assets.imagesClick),
                ),
              ),
            ),
            Positioned(
              bottom: 10, // Adjust position
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Backward Arrow Button
                  GestureDetector(
                    onTap: _moveBackward,
                    child: Icon(Icons.arrow_left, size: 40, color: Colors.white),
                  ),
                  // Scrollable List
                  Container(
                    width: 200, // Adjust width as per your design
                    height: 60, // Adjust height
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: _values.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == _selectedIndex;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _selectedIndex=index;
                                  });
                                },
                                child: Text(
                                  _values[index],
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
                  // Forward Arrow Button
                  GestureDetector(
                    onTap: _moveForward,
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
