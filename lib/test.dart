

///
// class CurvedPipePainter extends CustomPainter {
//   final double animationValue;
//
//   CurvedPipePainter(this.animationValue);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 6;
//
//     // Define a path for the curved pipe
//     Path path = Path();
//     double controlPointX = size.width * (0.5 - animationValue * 0.4);
//     double controlPointY = size.height/2;
//     path.moveTo(-3, size.height);
//     path.quadraticBezierTo(controlPointX, controlPointY, size.width, size.height);
//
//     // Draw the path
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true; // Always repaint for animation
//   }
// }
///
// Positioned(
// top: height * 0.59,
// // left: 1,
// child: AnimatedBuilder(
// animation: _pipeAnimation,
// builder: (context, child) {
// return Transform.rotate(
// angle: pi/1.22,
//
// child: CustomPaint(
// painter: CurvedPipePainter(_pipeAnimation.value),
// child: SizedBox(
// width: width * 0.2,
// height: height * 0.07,
// ),
// ),
// );
// },
// ),
// ),
import 'package:flutter/material.dart';

class BalloonPainter extends CustomPainter {
  final Color balloonColor;
  final double balloonHeight;
  final double balloonWidth;
  final double stringLength;

  BalloonPainter({
    required this.balloonColor,
    required this.balloonHeight,
    required this.balloonWidth,
    required this.stringLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint balloonPaint = Paint()
      ..color = balloonColor
      ..style = PaintingStyle.fill;

    Paint stringPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Balloon shape: Drawing an ellipse for the balloon
    Rect balloonRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: balloonWidth,
      height: balloonHeight,
    );
    canvas.drawOval(balloonRect, balloonPaint);

    // Balloon string: Drawing a line from the bottom center of the balloon
    Offset stringStart = Offset(size.width / 2, size.height / 2 + balloonHeight / 2);
    Offset stringEnd = Offset(size.width / 2, size.height / 2 + balloonHeight / 2 + stringLength);
    canvas.drawLine(stringStart, stringEnd, stringPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint whenever the size changes
  }
}

class BalloonWidget extends StatefulWidget {
  @override
  _BalloonWidgetState createState() => _BalloonWidgetState();
}

class _BalloonWidgetState extends State<BalloonWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _balloonSizeAnimation;
  double _balloonHeight = 200.0;
  double _balloonWidth = 120.0;
  double _stringLength = 250.0;
  Color _balloonColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Duration of the size increase animation
    );

    _balloonSizeAnimation = Tween<double>(begin: _balloonHeight, end: _balloonHeight * 1.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _balloonSizeAnimation.addListener(() {
      setState(() {
        _balloonHeight = _balloonSizeAnimation.value;
        _balloonWidth = _balloonHeight * 0.6; // Maintain aspect ratio
      });
    });
  }

  void _onTap() {
    // Start the animation when the balloon is tapped
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tap to Inflate Balloon")),
      body: GestureDetector(
        onTap: _onTap,
        child: Center(
          child: CustomPaint(
            size: Size(300, 600), // Width and height of the canvas
            painter: BalloonPainter(
              balloonColor: _balloonColor, // Balloon color
              balloonHeight: _balloonHeight, // Dynamically updated
              balloonWidth: _balloonWidth, // Dynamically updated
              stringLength: _stringLength,
            ),
          ),
        ),
      ),
    );
  }
}



