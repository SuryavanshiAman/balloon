import 'package:balloon/main.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:flutter/material.dart';
class CustomBackButton extends StatefulWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height:height*0.04,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.gray)
          ),
          child: const Icon(
            Icons.keyboard_arrow_left_rounded,color: AppColor.black,size: 30,
          ),
        ),
      ),
    );
  }
}
