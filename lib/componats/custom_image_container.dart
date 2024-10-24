import 'package:flutter/material.dart';
import 'package:job_test/core/utills/app_assets.dart';

class CustomImageContainer  extends StatelessWidget {
  const CustomImageContainer({super.key,
    required this.height, required this.width, required this.imagePathString,this.fit});

  final double height;
  final double width;
  final String imagePathString;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration:BoxDecoration(
       image: DecorationImage(
         fit:fit,
         image: AssetImage(imagePathString)
       )
      ),


    );
  }
}
