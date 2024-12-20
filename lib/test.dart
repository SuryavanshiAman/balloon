

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