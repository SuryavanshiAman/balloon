import 'package:flutter/material.dart';
import 'dart:math';

class PipeWithShakingButton extends StatefulWidget {
  @override
  _PipeWithShakingButtonState createState() => _PipeWithShakingButtonState();
}

class _PipeWithShakingButtonState extends State<PipeWithShakingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    // Shake animation setup
    _shakeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: -0.05, end: 0.05)
        .chain(CurveTween(curve: Curves.elasticInOut))
        .animate(_shakeController);
  }

  void _onTap() {
    _shakeController.forward().then((_) {
      _shakeController.reverse();
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Stack(
        children: [
          // Pipe
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            left: MediaQuery.of(context).size.width / 4,
            child: CustomPaint(
              size: Size(200, 200),
              painter: PipePainter(),
            ),
          ),
          // Button with shaking effect
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    10 * sin(_shakeAnimation.value * pi), // Shake offset
                    0,
                  ),
                  child: GestureDetector(
                    onTap: _onTap,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 50),
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Tap",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PipePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    Path path = Path();
    // Adjust pipe to start from button's position
    path.moveTo(size.width / 2, size.height + 50); // Starting from button
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
