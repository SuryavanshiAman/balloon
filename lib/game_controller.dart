import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameController with ChangeNotifier{
  double _balloonSize = 250.0; // Initial size
  late double _burstThreshold;
  bool _isFlying = false;
  bool _isButtonPressed = false;
  bool _blast = false;
  bool _winGif = false;
  String _walletAmount="3000";
   double _sizeIncrement = 5.0; // Size increase per tick
  final List<String> amount = ['2', '5', '10', '15','20','25','30'];
  int _selectedIndex = 1;
  double _multipliedValue = 0.0;

  double get balloonSize=>_balloonSize;
  setBalloonSize(double value){
    _balloonSize=value;
    notifyListeners();
  }
  bool get blast=>_blast;
  setBlast(bool value){
    _blast=value;
    notifyListeners();
  }
  bool get winGif=>_winGif;
  setWinGif(bool value){
    _winGif=value;
    notifyListeners();
  }
double get burstThreshold=>_burstThreshold;
  setBurstThreshold(double value){
    _burstThreshold=value;
    notifyListeners();
  }
  String get walletAmount=>_walletAmount;
  setWalletAmount(String value){
    _walletAmount=value;
    notifyListeners();
  }
  bool get isFlying=>_isFlying;
  setIsFlying(bool value){
    _isFlying=value;
    notifyListeners();
  }
  bool get isButtonPressed => _isButtonPressed;
  setIsButtonPressed(bool value){
    _isButtonPressed=value;
    notifyListeners();
  }
  double get sizeIncrement=>_sizeIncrement;
  setSizeIncrement(double value){
    _sizeIncrement=value;
    notifyListeners();
  }
  int get selectedIndex=>_selectedIndex;
  setSelectedIndex(int value){
    _selectedIndex=value;
    notifyListeners();
  }

  double get multipliedValue=>_multipliedValue;
  setMultipliedValue(double value){
    _multipliedValue=value;
  }
}
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText({
    Key? key,
    required this.text,
    required this.style,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white), // Color is ignored due to ShaderMask
      ),
    );
  }
}
class CurvedPipePainter extends CustomPainter {
  final double animationValue;

  CurvedPipePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Define a path for the curved pipe
    Path path = Path();
    double controlPointX = size.width * (0.5 - animationValue * 0.4);
    double controlPointY = size.height/2;
    path.moveTo(-3, size.height);
    path.quadraticBezierTo(controlPointX, controlPointY, size.width,  size.height);

    // path.moveTo(-3, size.height);
    // path.quadraticBezierTo(controlPointX, controlPointY, size.width, size.height);

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Always repaint for animation
  }
}
// class CurvedPipeTail extends CustomPainter {
//   final double animationValue;
//   final Offset startPoint;
//
//   CurvedPipeTail(this.animationValue,this.startPoint);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//
//     // Define a path for the curved pipe
//     Path path = Path();
//     double controlPointX = size.width * (0.5 - animationValue * 0.4);
//     double controlPointY = size.height/2;
//     path.moveTo(-3, startPoint.dy);
//     path.quadraticBezierTo(controlPointX, controlPointY, size.width,  size.height);
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

class CurvedPipeTail extends CustomPainter {
  final double animationValue;
  final Offset startPoint;

  CurvedPipeTail(this.animationValue, this.startPoint);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Define a path for the curved pipe
    Path path = Path();
    // Modify control point to move the curve forward as animation progresses
    double controlPointX = startPoint.dx + size.width * (0.5 - animationValue * 0.4);  // Adjust for forward movement
    double controlPointY = size.height/2;
    path.moveTo(-3, startPoint.dy);
    path.quadraticBezierTo(controlPointX, controlPointY, size.width,  size.height); // Draw the curve

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Always repaint for animation
  }
}

class TailPainter extends CustomPainter {
  final double tailHeight;
  final double balloonWidth;

  TailPainter({required this.tailHeight, required this.balloonWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke; // Stroke only, no fill

    // Start the path at the base of the balloon
    Path path = Path();
      // ..moveTo(balloonWidth / 2, 0); // Starting point at the center of the balloon's bottom

    // Control points to create a smooth curve
    path.quadraticBezierTo(
      balloonWidth / 3, // Control point X (adjust for the curve)
      tailHeight / 2,    // Control point Y (adjust for how much curve you want)
      balloonWidth / 2,  // End point X (same X to maintain the center of the balloon)
      tailHeight,        // End point Y (tail height)
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint when the tail changes
  }
}
