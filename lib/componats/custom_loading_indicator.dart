import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingIndicator  extends StatelessWidget {
  const CustomLoadingIndicator({super.key, required this.indicatorColor});
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    return  SpinKitFadingCircle(color: indicatorColor);
  }
}
