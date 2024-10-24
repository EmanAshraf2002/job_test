import 'package:flutter/material.dart';
import '../core/utills/app_colors.dart';

class DateTheme extends StatelessWidget {
  const DateTheme({
    super.key, required this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor:AppColors.primary,
        colorScheme:const ColorScheme.light(primary:AppColors.primary),
        buttonTheme:const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      child: Container(
        color: Colors.white,
        child: child,
      ),
    );
  }
}
