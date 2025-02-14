// import 'package:flutter/material.dart';
//
// import 'color-const.dart';
//
// class constantbutton extends StatefulWidget {
//   const constantbutton(
//       {Key? key,
//       required this.onTap,
//       required this.text,
//       this.btnColor = AppColor.gray,
//       this.textColor = AppColor.white,
//       this.border,
//       this.width,
//       this.height,
//       this.gradient,
//       this.style})
//       : super(key: key);
//
//   final Function() onTap;
//   final String text;
//   final Color? btnColor;
//   final Color? textColor;
//   final BoxBorder? border;
//   final double? width;
//   final double? height;
//   final Gradient? gradient;
//   final TextStyle? style;
//
//   @override
//   State<constantbutton> createState() => _constantbuttonState();
// }
//
// class _constantbuttonState extends State<constantbutton> {
//   double _scale = 1.0;
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return GestureDetector(
//       onTapDown: (_) {
//         setState(() {
//           _scale = 0.9; // Shrink the button when pressed
//         });
//       },
//       onTapUp: (_) {
//         setState(() {
//           _scale = 1.0; // Return to original size
//         });
//       },
//       onTap: () {
//         widget.onTap();
//       },
//       child: AnimatedScale(
//         scale: _scale,
//         duration: Duration(milliseconds: 150), // Duration of the animation
//         curve: Curves.easeOut,
//         child: Container(
//             width: widget.width ?? width * 0.5,
//             height: widget.height ?? height * 0.05,
//             // padding: const EdgeInsets.only(bottom: 1,),
//             decoration: BoxDecoration(
//                 // color: _scale==0.9?null:AppColor.white,
//                 gradient: LinearGradient(
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft,
//                   colors: [
//                     AppColor.gray,
//                     Colors.black,
//                     // Color(0xFFE3BE46),
//                     AppColor.gray,
//                   ],
//                 ),
//                 border: Border(
//                     bottom: BorderSide(
//                         color:
//                             _scale == 0.9 ? AppColor.black : AppColor.white)),
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                     bottomLeft: Radius.circular(15),
//                     bottomRight: Radius.circular(15))
//                 // BorderRadius.all(Radius.circular(10))
//                 ),
//             child: Center(
//               child: Text(
//                 widget.text,
//                 style: widget.style ??
//                     Theme.of(context).textTheme.headlineMedium!.copyWith(
//                           color: widget.textColor,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 18,
//                           fontFamily: "SitkaSmall",
//                           letterSpacing: 1.25,
//                         ),
//               ),
//             )),
//       ),
//     );
//   }
// }
import 'package:balloon/main.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class constantbutton extends StatefulWidget {
  const constantbutton({
    Key? key,
    required this.onTap,
    required this.text,
    this.btnColor = AppColor.gray,
    this.textColor = AppColor.white,
    this.border,
    this.width,
    this.height,
    this.gradient,
    this.style,
  }) : super(key: key);

  final Function() onTap;
  final String text;
  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final TextStyle? style;

  @override
  State<constantbutton> createState() => _constantbuttonState();
}

class _constantbuttonState extends State<constantbutton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _scale = 0.9;
        });
      },
      onTapUp: (_) {
        setState(() {
          _scale = 1.0;
        });
      },
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: Container(
          width: widget.width ?? width ,
          height: widget.height ?? height * 0.05,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColor.lightBlue,
                AppColor.lightBlue,
                // AppColor.gray,
                // Colors.black,
                // AppColor.gray,
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: _scale == 0.9 ? AppColor.black : AppColor.white,
              ),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: widget.style ??
                  Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: widget.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    fontFamily: "SitkaSmall",
                    letterSpacing: 1.25,
                  ),
            ),
          ),
        )
      ),
    );
  }
}
