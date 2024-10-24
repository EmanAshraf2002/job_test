import 'package:flutter/material.dart';

class CustomElevatedButton  extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.height,
    required this.width, required this.bgColor, this.onPressed, required this.child,});

  final double height;
  final double width;
  final Color bgColor;
  final void Function()? onPressed;
  final Widget child ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8)
      ),
      child: ElevatedButton(
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            )
        ),
        child: child,
      ),
    );
  }
}